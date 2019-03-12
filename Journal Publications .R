library(tidyverse)
library(rvest)
library(stringr)
library(magrittr)
myurl <- ("https://scholar.google.com/citations?view_op=top_venues&hl=en&vq=soc_politicalscience")
myhtml<-read_html(myurl)
catstub<-"https://scholar.google.com/"
#
urlsoc<-("https://scholar.google.com/citations?view_op=top_venues&hl=en&vq=soc")
htmlsoc<-read_html(urlsoc)
departments<-html_nodes(htmlsoc, "a")[19:70]%>% html_attr("href")
departments

mydepurls<-as.list(paste0(catstub,departments))
mydepurl<-mydepurls[1]
#Scrape journals for one department
topjournals<-function(mydepurl){
mynodes<-read_html(mydepurl)%>%html_nodes("td")
tex<-html_text(mynodes)
tex<-gsub("[0-9]",NA,tex)
tex<-as.data.frame(na.omit(tex))
return(tex)}


topjournaldata<-do.call(rbind, lapply(mydepurls[1:4],topjournals))
