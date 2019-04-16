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
namesandranks$flet<-substr(namesandranks$first,1,1)

data2<-data%>%separate(Employee, c("last", "first"), sep=" ")
data2$flet<-substr(data2$first,1,1)

salandranks<-merge(data2,namesandranks, by=c("last","flet"))

#Race Varirable
data2$surname<-data2$last
get_census_data("ed40afcdd1f52887858390f1a29de4a0f58b661c", "IA", age = FALSE, sex = FALSE,
                census.geo = "block", retry = 0)
data3<-predict_race(data2, census.surname = TRUE,
                    surname.only = TRUE,
                    census.key = "ed40afcdd1f52887858390f1a29de4a0f58b661c" , census.data="IA")

data3$white<-as.numeric(data3$pred.whi>.5)
data3$black<-as.numeric(data3$pred.bla>.5)
data3$hisp<-as.numeric(data3$pred.his>.5)
data3$asian<-as.numeric(data3$pred.asi>.5)
data3$other<-as.numeric(data3$pred.oth>.5)

data4<-subset(data3, select = c("last","first","Position","July.Salary", "Travel..etc" ,"FY.Salary"  
                                ,"female"   ,   "Emeritus",    "Associate"  , "Assistant" ,  "Lecturer" ,   "Adjunct",     "Salary"
                                ,"flet"   ,     "county"  ,   
                                "white" ,      "black",       "hisp"  ,     
                                "asian"  ,     "other" ))
write.csv(data4, "genderracesalary.csv")