library(magrittr)
library(tidyverse)
library(rvest)
library(stringr)
library(wru)
##Load data

sal<-read.csv("genderracesalary.csv")


#Prelim Analysis
base<-lm(Salary~female+black+hisp+asian, data=sal)
summary(base)


#lm with assosiate as reference group
rank<-lm(Salary~Emeritus+Assistant+Lecturer, data=sal)
summary(rank)

#
full<-lm(Salary~female+Emeritus+Assistant+Lecturer, data=sal)
summary(full)
