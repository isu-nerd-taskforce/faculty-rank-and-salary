library(tidyverse)
library(rvest)
library(stringr)
library(magrittr)

myurl<-"https://www.legis.iowa.gov/publications/fiscal/salaryBook"
myhtml<-read_html(myurl)

nodes<-html_nodes(myhtml, "div")[21]
myattr<-html_attr(nodes, "class")
myattr



table<-html_table()