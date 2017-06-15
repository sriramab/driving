library(cchaid)
library(partykit)
aidwork5 = read.table("aidwork5.dat",header=TRUE, sep="\t")

aidwork5$Urb<-as.factor(aidwork5$Urb)
aidwork5$Comp<-as.factor(aidwork5$Comp)
aidwork5$Child<-as.factor(aidwork5$Child)
aidwork5$Day<-as.factor(aidwork5$Day)
aidwork5$pAge<-as.factor(aidwork5$pAge)
aidwork5$SEC<-as.factor(aidwork5$SEC)
aidwork5$Ncar<-as.factor(aidwork5$Ncar)
aidwork5$Gend<-as.factor(aidwork5$Gend)
aidwork5$Driver<-as.factor(aidwork5$Driver)
aidwork5$wstat<-as.factor(aidwork5$wstat)
aidwork5$Pwstat<-as.factor(aidwork5$Pwstat)
aidwork5$Xdag<-as.ordered(aidwork5$Xdag)
aidwork5$Xn.dag<-as.ordered(aidwork5$Xn.dag)
aidwork5$Xarb<-as.ordered(aidwork5$Xarb)
aidwork5$Xpop<-as.ordered(aidwork5$Xpop)
aidwork5$Ddag<-as.ordered(aidwork5$Ddag)
aidwork5$Dn.dag<-as.ordered(aidwork5$Dn.dag)
aidwork5$Darb<-as.ordered(aidwork5$Darb)
aidwork5$Dpop<-as.ordered(aidwork5$Dpop)
aidwork5$Empty<-as.ordered(aidwork5$Empty)
aidwork5$Empty.1<-as.ordered(aidwork5$Empty.1)

aidwork5$Duration<-as.factor(aidwork5$Duration)
aidwork5$Ratio<-as.factor(aidwork5$Ratio)

aidwork5$Durbreak<-as.numeric(aidwork5$Durbreak)


aidwork5formula <- (Durbreak ~ Urb + Comp + Child + Day + pAge + SEC + Ncar + Gend +
              Driver + wstat + Pwstat + Xdag + Xn.dag + Xarb + Xpop + Ddag +
              Dn.dag + Darb + Dpop + Duration + Ratio)
calculate_minbucket = ifelse(nrow(aidwork5)/150>60, 60,ifelse(nrow(aidwork5)/150<30, 30,nrow(aidwork5)/150))
aidwork5tree <- cchaid(aidwork5formula,data = aidwork5, weights = NULL, minbucket = calculate_minbucket,
                 minsplit = 2*calculate_minbucket, alpha_split=0.05, alpha_merge=0.05,
                 max_depth = 8)
