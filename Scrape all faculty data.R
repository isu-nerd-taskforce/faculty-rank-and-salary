library(tidyverse)
library(rvest)
library(stringr)
library(magrittr)
myurl<-"http://catalog.iastate.edu/faculty/"
myhtml<-read_html(myurl)

myhtml %>% html_nodes("h5") %>% html_text->names
names<-names[2:2820]
myhtml %>% html_nodes("p") %>% html_text->ranks

fdata<-cbind(names,ranks)%>%as.data.frame%>%
  mutate(ranks=as.character(ranks))%>%
  mutate(Emeritus=grepl("Emeritus", ranks),Associate=grepl("Associate", ranks))

