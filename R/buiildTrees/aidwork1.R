#setwd("D:/CHAID")

## ----decision1

library(CHAID)
aidwork1 = read.table("aidwork1.dat",header=TRUE)

aidwork1$Urb<-as.factor(aidwork1$Urb)
aidwork1$Comp<-as.factor(aidwork1$Comp)
aidwork1$Child<-as.factor(aidwork1$Child)
aidwork1$Day<-as.factor(aidwork1$Day)
aidwork1$pAge<-as.factor(aidwork1$pAge)
aidwork1$SEC<-as.factor(aidwork1$SEC)
aidwork1$Ncar<-as.factor(aidwork1$Ncar)
aidwork1$Gend<-as.factor(aidwork1$Gend)
aidwork1$Driver<-as.factor(aidwork1$Driver)
aidwork1$wstat<-as.factor(aidwork1$wstat)
aidwork1$Pwstat<-as.factor(aidwork1$Pwstat)
aidwork1$Xdag<-as.ordered(aidwork1$Xdag)
aidwork1$Xndag<-as.ordered(aidwork1$Xndag)
aidwork1$Xarb<-as.ordered(aidwork1$Xarb)
aidwork1$Xpop<-as.ordered(aidwork1$Xpop)
aidwork1$Ddag<-as.ordered(aidwork1$Ddag)
aidwork1$Dndag<-as.ordered(aidwork1$Dndag)
aidwork1$Darb<-as.ordered(aidwork1$Darb)
aidwork1$Dpop<-as.ordered(aidwork1$Dpop)
aidwork1$Empty<-as.ordered(aidwork1$Empty)
aidwork1$Empty.1<-as.ordered(aidwork1$Empty.1)
aidwork1$nWo<-as.factor(aidwork1$nWo)
aidwork1$yWo<-as.factor(aidwork1$yWo)

ctrl<-chaid_control(minsplit=300,minbucket=150)

DTaidwork1<-chaid(yWo ~ Urb + Comp + Child + Day + pAge + SEC + Ncar + Gend + Driver +
          wstat + Pwstat + Xdag + Xndag + Xarb + Xpop + Ddag + Dndag + Darb +
          Dpop, data = aidwork1, control = ctrl)
