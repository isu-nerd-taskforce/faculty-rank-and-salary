library(tidyverse)
library(rvest)
library(stringr)
library(magrittr)
library(gender)
myurl<-"http://catalog.iastate.edu/faculty/"
myhtml<-read_html(myurl)

myhtml %>% html_nodes("h5") %>% html_text->names
names<-names[2:2820]
myhtml %>% html_nodes("p") %>% html_text->ranks

fdata<-cbind(names,ranks)%>%as.data.frame%>%
  mutate(ranks=as.character(ranks))%>%
  mutate(Emeritus= as.numeric(grepl("Emeritus", ranks)),Associate= as.numeric(grepl("Associate", ranks)),
         Assistant= as.numeric(grepl("Assistant", ranks)),Lecturer= as.numeric(grepl("Lecturer", ranks)))%>%
  mutate(names=as.character(names))%>%
  separate(names, c("last", "first"), sep=" ")
write.csv(fdata, "namesandranks.csv")
