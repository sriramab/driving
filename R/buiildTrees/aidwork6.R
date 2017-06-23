## @knitr decision6

library(cchaid)
library(partykit)
aidwork6 = read.table("aidwork6.dat",header=TRUE)

aidwork6$Urb<-as.factor(aidwork6$Urb)
aidwork6$Comp<-as.factor(aidwork6$Comp)
aidwork6$Child<-as.factor(aidwork6$Child)
aidwork6$Day<-as.factor(aidwork6$Day)
aidwork6$pAge<-as.factor(aidwork6$pAge)
aidwork6$SEC<-as.factor(aidwork6$SEC)
aidwork6$Ncar<-as.factor(aidwork6$Ncar)
aidwork6$Gend<-as.factor(aidwork6$Gend)
aidwork6$Driver<-as.factor(aidwork6$Driver)
aidwork6$wstat<-as.factor(aidwork6$wstat)
aidwork6$Pwstat<-as.factor(aidwork6$Pwstat)
aidwork6$Xdag<-as.ordered(aidwork6$Xdag)
aidwork6$Xn.dag<-as.ordered(aidwork6$Xn.dag)
aidwork6$Xarb<-as.ordered(aidwork6$Xarb)
aidwork6$Xpop<-as.ordered(aidwork6$Xpop)
aidwork6$Ddag<-as.ordered(aidwork6$Ddag)
aidwork6$Dn.dag<-as.ordered(aidwork6$Dn.dag)
aidwork6$Darb<-as.ordered(aidwork6$Darb)
aidwork6$Dpop<-as.ordered(aidwork6$Dpop)
aidwork6$Empty<-as.ordered(aidwork6$Empty)
aidwork6$Empty.1<-as.ordered(aidwork6$Empty.1)

aidwork6$Dur<-as.factor(aidwork6$Dur)
aidwork6$Nep<-as.factor(aidwork6$Nep)
aidwork6$Ratio<-as.factor(aidwork6$Ratio)
aidwork6$Inter<-as.factor(aidwork6$Inter)
aidwork6$startTime<-as.numeric(aidwork6$startTime)


aidwork6formula <- (startTime ~ Urb + Comp + Child + Day + pAge + SEC + Ncar + Gend +
              Driver + wstat + Pwstat + Xdag + Xn.dag + Xarb + Xpop + Ddag +
              Dn.dag + Darb + Dpop + Dur + Nep + Ratio + Inter)
calculate_minbucket = ifelse(nrow(aidwork6)/150>60, 60,ifelse(nrow(aidwork6)/150<30, 30,nrow(aidwork6)/150))
aidwork6tree <- cchaid(aidwork6formula,data = aidwork6, weights = NULL, minbucket = calculate_minbucket,
                 minsplit = 2*calculate_minbucket, alpha_split=0.05, alpha_merge=0.05,
                 max_depth = 8)
