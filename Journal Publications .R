library(tidyverse)
library(rvest)
library(stringr)
library(magrittr)
myurl <- ("https://scholar.google.com/citations?view_op=top_venues&hl=en&vq=soc_politicalscience")
myhtml<-read_html(myurl)
gsstub<-"https://scholar.google.com/"


#Scrape Categories
gsurl<-("https://scholar.google.com/citations?view_op=top_venues&hl=en&vq=en")
gshtml<-read_html(gsurl)

catnodes<-html_nodes(gshtml,"a")[15:22]%>% html_attr("href")
caturls<-paste0(gsstub,catnodes)

##Scrape Sub Categories

#business
busurl<-caturls[1]
bushtml<-read_html(busurl)
buscat<-html_nodes(bushtml, "a")[19:34]%>% html_attr("href")
buscat
#chemical science
chemurl<-caturls[2]
chemhtml<-read_html(chemurl)
chemcat<-html_nodes(chemhtml, "a")[19:36]%>% html_attr("href")
#Egineering
engurl<-caturls[3]
enghtml<-read_html(engurl)
engcat<-html_nodes(enghtml, "a")[19:76]%>% html_attr("href")
#health
healthurl<-caturls[4]
healthhtml<-read_html(healthurl)
healthcat<-html_nodes(healthhtml, "a")[19:87]%>% html_attr("href")
#humanities
humurl<-caturls[5]
humhtml<-read_html(humurl)
humcat<-html_nodes(humhtml, "a")[19:44]%>% html_attr("href")
#Life Science
lifeurl<-caturls[6]
lifehtml<-read_html(lifeurl)
lifecat<-html_nodes(lifehtml, "a")[19:57]%>% html_attr("href")
#Physics and Math
mathurl<-caturls[7]
mathhtml<-read_html(mathurl)
mathcat<-html_nodes(mathhtml, "a")[19:41]%>% html_attr("href")
mathcat
#social sciences
socurl<-caturls[8]
htmlsoc<-read_html(socurl)
soccat<-html_nodes(htmlsoc, "a")[19:70]%>% html_attr("href")

##All dep list
departments<-c(buscat,chemcat,engcat,healthcat,humcat,lifecat,mathcat,soccat)


mydepurls<-as.list(paste0(gsstub,departments))
mydepurl<-mydepurls[1]
#Scrape journals for one department
topjournals<-function(mydepurl){
mynodes<-read_html(mydepurl)%>%html_nodes("td")
tex<-html_text(mynodes)
tex<-gsub("[0-9]",NA,tex)
tex<-as.data.frame(na.omit(tex)[1:10])
return(tex)}


topjournaldata<-do.call(rbind, lapply(mydepurls,topjournals))

write.csv(topjournaldata, "topjournals.csv")
