library(tidyverse)
library(rvest)
library(stringr)
library(magrittr)


myurl<-"https://db.desmoinesregister.com/state-salaries-for-iowa/?searchterms%5Bcol3%5D=&searchterms%5Bcol2%5D=Iowa+State+University&searchterms%5Bcol6%5D=&searchterms%5Bcol11%5D=2018"

myhtml<-read_html(myurl)

html_nodes(myhtml, "table") %>%  html_table(header=TRUE)

