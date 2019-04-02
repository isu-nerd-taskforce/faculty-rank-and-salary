#Scraping google scholar user IDs
rm(list=ls())
#Search URL looks like: https://scholar.google.com/citations?hl=en&view_op=search_authors&mauthors=Olga+Chyzh+Iowa+state+university&btnG=
library('xml2')
library('rvest')
library('scholar')
library('stringr')

#URL of author search
search.url = "https://scholar.google.com/citations?hl=en&view_op=search_authors&mauthors=David+Andersen+Iowa+state+university&btnG="
search.url = "https://scholar.google.com/citations?hl=en&view_op=search_authors&mauthors=Olga+Chyzh+Iowa+state+university&btnG="

#Useful code ***Ike don't delete***
#***Code to generate search.urls***
#***Initializing fields***
top.journals = list("American Journal of Political Science","American Political Science Review","Comparative Political Studies","Journal of European Public Policy","The Journal of Politics","JCMS: Journal of Common Market Studies","Journal of Democracy","	British Journal of Political Science","Political Studies","	Party Politics")
First = "David"
Last = "Andersen"
#Constructing search.url
search.url=str_c("https://scholar.google.com/citations?hl=en&view_op=search_authors&mauthors=",First,Last,"Iowa+state+university&btnG=", sep = "+")
#turning webpage into data
webpage = read_html(search.url)
#reading all link nodes
readnodes = html_nodes(webpage,'a')
#subsetting to only link node 19 which contains username
profile.url = readnodes[19]
#string manipulations to give only username

profile.url = substr(profile.url,36,47)
#method if not always at same spot
#profile.url = word(sub(pattern = ";", replacement = " ", x = profile.url),2)
#profile.url = sub(pattern = "=", replacement = " ", x = profile.url)
#profile.url = sub(pattern = "\\\\", replacement = " ", x = profile.url)
#profile.url = word(profile.url,2)
profile.url

get_num_articles(profile.url)

get_num_top_journals(profile.url,top.journals)

pub.mat = as.matrix(get_publications("AhS41dYAAAAJ")) #diagnostic code, don't need
rm(pub.mat)

#***Example using political science department***
#Reading in one of my files
setwd("C:/Users/Ike/Desktop/school/College/Research/Nerd Squad Research")
top.journals = list("American Journal of Political Science","American Political Science Review","Comparative Political Studies","Journal of European Public Policy","The Journal of Politics","JCMS: Journal of Common Market Studies","Journal of Democracy","	British Journal of Political Science","Political Studies","	Party Politics")
polisci.profs = read.table("PolSprofs.txt",sep = " ",col.names=list("First","Last"))
polisci.profs$First = as.character(polisci.profs$First)
polisci.profs$Last = as.character(polisci.profs$Last)

#Function for finding scholarid,num_article,top_article for a given First Last name combo
ScholarStats = function(First,Last){
  search.url=str_c("https://scholar.google.com/citations?hl=en&view_op=search_authors&mauthors=",First,Last,"Iowa+state+university&btnG=", sep = "+")
  webpage = read_html(search.url)
  readnodes = html_nodes(webpage,'a')
  profile.url = readnodes[19]
  profile.url = substr(profile.url,36,47)
  profile = get_profile(profile.url)
  real.pub = get_publications(profile.url)[4]
  real.pub$real_pub = tryCatch(as.numeric(word(real.pub[,1]),1), error=function(e){}, warning=function(e){})
  real.pub = na.omit(real.pub)
  num_article = sum(!grepl("Meeting", real.pub$number, ignore.case = T), na.rm = TRUE) #gives the count of articles left that do not have "meeting" in their names
  num_citations = profile[4] #gives Total Citations
  h_index = profile[5] #gives h index
  top_article = get_num_top_journals(profile.url,top.journals)
  return(c(profile.url,num_article,num_citations,h_index,top_article))
}

#This is the code to repeatedly run the function for a list of names
#for(i in 1:nrow(polisci.profs)){
for(i in 1:25){
  if(i==1){
    add.mat = c(tryCatch(ScholarStats(polisci.profs$First[i],polisci.profs$Last[i]), error=function(e){return(c(-1,-1,-1,-1,-1))}))
  }
  else{
    add.mat = rbind(add.mat,c(tryCatch(ScholarStats(polisci.profs$First[i],polisci.profs$Last[i]), error=function(e){return(c(-1,-1,-1,-1,-1))})))
  }
}

final = cbind(polisci.profs,add.mat)
colnames(final) = list("First","Last","ScholarID","num_article","num_citations","h_index","top_article")


####Experimental lines of code#####
add.mat = lapply(polisci.profs, ScholarStats(polisci.profs$First[i],polisci.profs$Last[i]))

add.mat = c(tryCatch(ScholarStats(polisci.profs$First[1],polisci.profs$Last[1]), error=function(e){}))

tryCatch(ScholarStats(polisci.profs$First[i],polisci.profs$Last[i]), error=function(e){return(c(-1,-1,-1,-1,-1))})
i=1


#change it to lapply and rbind
#use package parallell to split among cores

nrow(real.pub)
