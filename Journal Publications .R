library(tidyverse)
library(rvest)
library(stringr)
library(magrittr)
myurl <- ("https://scholar.google.com/citations?view_op=top_venues&hl=en&vq=soc_politicalscience")
myhtml<-read_html(myurl)

mynodes<-html_nodes(myhtml,"td")

myattr<-html_attr(mynodes, "class")
myattr
#Alternatively, use the piping operator 
facpaths<-html_nodes(myhtml, "a")[62:86] %>% html_attr("href")

#Stumping the constant for href e.g. header 
mystub<-"https://www.pols.iastate.edu"
myurls<-paste0(mystub, myattr)
#why god, why
#cbinding the function 
get_info<-function(myurls){
  myurls[1] %>% read_html() %>% html_nodes(".entry-title") %>% html_text() -> pname
  myurls[1] %>% read_html() %>% html_nodes(".title") %>% html_text() -> title
  cbind.data.frame(pname,title)
}
ndsbfmndbfmn
#To format the information (Usually rbind)
lapply(myurls,get_info)
#To clean up the information
do.call(rbind, lapply(myurls, get_info))
