#setwd("D:/CHAID")
## @knitr decision3

library(CHAID)
aidwork3 = read.table("aidwork3.dat",header=TRUE)

aidwork3$Urb<-as.factor(aidwork3$Urb)
aidwork3$Comp<-as.factor(aidwork3$Comp)
aidwork3$Child<-as.factor(aidwork3$Child)
aidwork3$Day<-as.factor(aidwork3$Day)
aidwork3$pAge<-as.factor(aidwork3$pAge)
aidwork3$SEC<-as.factor(aidwork3$SEC)
aidwork3$Ncar<-as.factor(aidwork3$Ncar)
aidwork3$Gend<-as.factor(aidwork3$Gend)
aidwork3$Driver<-as.factor(aidwork3$Driver)
aidwork3$wstat<-as.factor(aidwork3$wstat)
aidwork3$Pwstat<-as.factor(aidwork3$Pwstat)
aidwork3$Xdag<-as.ordered(aidwork3$Xdag)
aidwork3$Xndag<-as.ordered(aidwork3$Xndag)
aidwork3$Xarb<-as.ordered(aidwork3$Xarb)
aidwork3$Xpop<-as.ordered(aidwork3$Xpop)
aidwork3$Ddag<-as.ordered(aidwork3$Ddag)
aidwork3$Dndag<-as.ordered(aidwork3$Dndag)
aidwork3$Darb<-as.ordered(aidwork3$Darb)
aidwork3$Dpop<-as.ordered(aidwork3$Dpop)
aidwork3$Empty<-as.ordered(aidwork3$Empty)
aidwork3$Empty.1<-as.ordered(aidwork3$Empty.1)
aidwork3$Dur<-as.factor(aidwork3$Dur)
#aidwork3$nNep<-as.factor(aidwork3$nNep)
aidwork3$yNep<-as.factor(aidwork3$yNep)

ctrl<-chaid_control(minsplit=300,minbucket=150)

DTaidwork3<-chaid(yNep ~ Urb + Comp + Child + Day + pAge + SEC + Ncar + Gend + Driver +
          wstat + Pwstat + Xdag + Xndag + Xarb + Xpop + Ddag + Dndag + Darb +
          Dpop + Dur, data = aidwork3, control = ctrl)
