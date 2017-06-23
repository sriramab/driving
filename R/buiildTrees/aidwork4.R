## @knitr decision4

library(cchaid)
library(partykit)
aidwork4 = read.table("aidwork4.dat",header=TRUE)

aidwork4$Urb<-as.factor(aidwork4$Urb)
aidwork4$Comp<-as.factor(aidwork4$Comp)
aidwork4$Child<-as.factor(aidwork4$Child)
aidwork4$Day<-as.factor(aidwork4$Day)
aidwork4$pAge<-as.factor(aidwork4$pAge)
aidwork4$SEC<-as.factor(aidwork4$SEC)
aidwork4$Ncar<-as.factor(aidwork4$Ncar)
aidwork4$Gend<-as.factor(aidwork4$Gend)
aidwork4$Driver<-as.factor(aidwork4$Driver)
aidwork4$wstat<-as.factor(aidwork4$wstat)
aidwork4$Pwstat<-as.factor(aidwork4$Pwstat)
aidwork4$Xdag<-as.ordered(aidwork4$Xdag)
aidwork4$Xn.dag<-as.ordered(aidwork4$Xn.dag)
aidwork4$Xarb<-as.ordered(aidwork4$Xarb)
aidwork4$Xpop<-as.ordered(aidwork4$Xpop)
aidwork4$Ddag<-as.ordered(aidwork4$Ddag)
aidwork4$Dn.dag<-as.ordered(aidwork4$Dn.dag)
aidwork4$Darb<-as.ordered(aidwork4$Darb)
aidwork4$Dpop<-as.ordered(aidwork4$Dpop)
aidwork4$Empty<-as.ordered(aidwork4$Empty)
aidwork4$Empty.1<-as.ordered(aidwork4$Empty.1)

aidwork4$Duration<-as.factor(aidwork4$Duration)
aidwork4$Ratio<-as.numeric(aidwork4$Ratio)


aidwork4formula <- (Ratio ~ Urb + Comp + Child + Day + pAge + SEC + Ncar + Gend +
              Driver + wstat + Pwstat + Xdag + Xn.dag + Xarb + Xpop + Ddag +
              Dn.dag + Darb + Dpop + Duration)
calculate_minbucket = ifelse(nrow(aidwork4)/150>60, 60,ifelse(nrow(aidwork4)/150<30, 30,nrow(aidwork4)/150))
aidwork4tree <- cchaid(aidwork4formula,data = aidwork4, weights = NULL, minbucket = calculate_minbucket,
                 minsplit = 2*calculate_minbucket, alpha_split=0.05, alpha_merge=0.05,
                 max_depth = 8)
