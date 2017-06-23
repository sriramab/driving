## @knitr decision2

library(cchaid)
library(partykit)
aidwork2 = read.table("aidwork2.dat",header=TRUE)

aidwork2$Urb<-as.factor(aidwork2$Urb)
aidwork2$Comp<-as.factor(aidwork2$Comp)
aidwork2$Child<-as.factor(aidwork2$Child)
aidwork2$Day<-as.factor(aidwork2$Day)
aidwork2$pAge<-as.factor(aidwork2$pAge)
aidwork2$SEC<-as.factor(aidwork2$SEC)
aidwork2$Ncar<-as.factor(aidwork2$Ncar)
aidwork2$Gend<-as.factor(aidwork2$Gend)
aidwork2$Driver<-as.factor(aidwork2$Driver)
aidwork2$wstat<-as.factor(aidwork2$wstat)
aidwork2$Pwstat<-as.factor(aidwork2$Pwstat)
aidwork2$Xdag<-as.ordered(aidwork2$Xdag)
aidwork2$Xn.dag<-as.ordered(aidwork2$Xn.dag)
aidwork2$Xarb<-as.ordered(aidwork2$Xarb)
aidwork2$Xpop<-as.ordered(aidwork2$Xpop)
aidwork2$Ddag<-as.ordered(aidwork2$Ddag)
aidwork2$Dn.dag<-as.ordered(aidwork2$Dn.dag)
aidwork2$Darb<-as.ordered(aidwork2$Darb)
aidwork2$Dpop<-as.ordered(aidwork2$Dpop)
aidwork2$Empty<-as.ordered(aidwork2$Empty)
aidwork2$Empty.1<-as.ordered(aidwork2$Empty.1)

aidwork2$Duration<-as.numeric(aidwork2$Duration)


aidwork2formula <- (Duration ~ Urb + Comp + Child + Day + pAge + SEC + Ncar + Gend +
              Driver + wstat + Pwstat + Xdag + Xn.dag + Xarb + Xpop + Ddag +
              Dn.dag + Darb + Dpop)
calculate_minbucket = ifelse(nrow(aidwork2)/150>60, 60,ifelse(nrow(aidwork2)/150<30, 30,nrow(aidwork2)/150))
aidwork2tree <- cchaid(aidwork2formula,data = aidwork2, weights = NULL, minbucket = calculate_minbucket,
                 minsplit = 2*calculate_minbucket, alpha_split=0.05, alpha_merge=0.05,
                 max_depth = 8)
