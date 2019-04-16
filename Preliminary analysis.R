library(magrittr)
library(tidyverse)
library(rvest)
library(stringr)
##Load data

sal<-read.csv("profsalaries.csv")


#Gender
sal$female<-NA
sal$female[sal$Sex=="F"]<-1
sal$female[is.na(sal$female)]<-0

data<-sal%>%mutate(Emeritus= as.numeric(grepl("Emer", Position)),Associate= as.numeric(grepl("Assoc", Position)),
       Assistant= as.numeric(grepl("Asst", Position)),Lecturer= as.numeric(grepl("Lecturer", Position)),
       Adjunct= as.numeric(grepl("Adj", Position)))

data$Salary = as.numeric(gsub("[\\$,]", "", data$FY.Salary))

#Prelim Analysis
base<-lm(Salary~female, data=data)
summary(base)


#lm with assosiate as reference group
rank<-lm(Salary~Emeritus+Assistant+Lecturer, data=data)
summary(rank)

#
full<-lm(Salary~female+Emeritus+Assistant+Lecturer, data=data)
summary(full)
