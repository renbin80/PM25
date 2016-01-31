
mm<-readRDS("baltimore.rds")
t<-c(unique(mm$type))
#y<-c(rep(unique(mm$year)[1],4),rep(unique(mm$year)[2],4),rep(unique(mm$year)[3],4),rep(unique(mm$year)[4],4))
y<-c(unique(mm$year))
e<-NULL
mat<-NULL

for(j in 1:length(unique(mm$type))) {
     for(i in 1:length(unique(mm$year))){
          
          m<-subset(mm,mm$type==t[i] & mm$year==y[j])
          #print(t[i])
          #print(y[j])
          
          #print(sum(m$Emissions))
          e<-c(y[j],t[i],sum(m$Emissions))

          mat<-rbind(mat,e)
     }     
     
}
colnames(mat)<-c("Year","Type","Total_Em")
rownames(mat)<-NULL


mm<-as.data.frame(mat)
print(mm)
mm$Year<-as.numeric(as.character(mm$Year))
mm$Total_Em<-as.numeric(as.character(mm$Total_Em))

print(mm)
#mm<-mm[order(y,t),]

#q<-qplot(Year, Total_Em, data=mm, facets=.~Type)
q<-ggplot(mm, aes(Year, Total_Em)) + geom_point() + facet_grid(.~Type) + geom_smooth(method="lm")
print(q)