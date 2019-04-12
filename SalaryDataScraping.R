library(tidyverse)
library(rvest)
library(stringr)
library(magrittr)


myurl<-"https://db.desmoinesregister.com/state-salaries-for-iowa/?searchterms%5Bcol3%5D=&searchterms%5Bcol2%5D=Iowa+State+University&searchterms%5Bcol6%5D=&searchterms%5Bcol11%5D=2018"

myhtml<-read_html(myurl)

page<-"page="
numb<-1:1198

pages<-as.list(paste0(page,numb))

frontstub<-"http://db.desmoinesregister.com/state-salaries-for-iowa/"
backstub<-"&ordercol=col11&orderdir=desc&searchterms%5Bcol3%5D=&searchterms%5Bcol2%5D=Iowa+State+University&searchterms%5Bcol6%5D=&searchterms%5Bcol11%5D=2018"
myurls<-paste0(frontstub,pages,backstub)

steve<-myurls[1:5]

salary<-function(myurls){

myhtml<-read_html(myurls)
html_nodes(myhtml, "table") %>%  html_table(header=TRUE)->p
q<-as.data.frame(p)
positions<-c("Prof","Lecturer")
subset(q, grepl(paste(positions,collapse="|"), q$Position))
}
test<-do.call(rbind, lapply(steve,salary))

statesal<-do.call(rbind, lapply(myurls,salary))
 write.csv(statesal, "profsalaries.csv")
 