setwd("C:/Users/kolodinj/Dropbox/Jesse&Jorge/CNH Hedonic Analysis Manuscript/Manuscript/R_Folder")
library(tidyverse)
library(foreign)
library(Hmisc)
library(psych)
library(car)
##----------------------------------------
#databook WITH Barnegat Light and Brant Beach Properties
LBIWHOLEStudy<-read.csv("SORTEDwDUNE_2016&2017_NetValue_BH_LBT_SB_YEARBUILTTRIM_FULL11921_AllDunes.csv", stringsAsFactors = FALSE)
#-----------------------------------------
#-----------------------------------------
#Replacing all NA values in EXCEL-BORN Log columns with means(cont), or median(categorical)
LBIWHOLEStudy$LnNetValue<-as.numeric(impute(LBIWHOLEStudy$LnNetValue, mean))
LBIWHOLEStudy$LnYearBuilt<-as.numeric(impute(LBIWHOLEStudy$LnYearBuilt, mean))
LBIWHOLEStudy$LnAcreageSqFt<-as.numeric(impute(LBIWHOLEStudy$LnAcreageSqFt, mean))
LBIWHOLEStudy$LnSqFt<-as.numeric(impute(LBIWHOLEStudy$LnSqFt, mean))
LBIWHOLEStudy$TotalRooms<-as.numeric(impute(LBIWHOLEStudy$TotalRooms, mean))
LBIWHOLEStudy$StoryHeight<-as.numeric(impute(LBIWHOLEStudy$StoryHeight, mean))
LBIWHOLEStudy$Beds<-as.numeric(impute(LBIWHOLEStudy$Beds, mean))
LBIWHOLEStudy$Baths<-as.numeric(impute(LBIWHOLEStudy$Baths, mean))
summary(LBIWHOLEStudy)
##-----------------------------------------
##-----------------------------------------
#linear regression model for: Entire Communities Stacked Matrix with SB as reference town (LBT,BH,SB)
#         NewDune(SB)   BH        LBT
#2016(BH)     0         1         0
#2017(BH)     1         1         0
#2016(LBT)    0         0         1
#2017(LBT)    1         0         1
#2016(SB)     0         0         0
#2017(SB)     1         0         0
#-----------------------------------------
mydataStackedMatrixSB<-select(as.data.frame(LBIWHOLEStudy), LnNetValue, 
                              LnYearBuilt, LnAcreageSqFt, LnSqFt, TotalRooms, StoryHeight, 
                              Beds, Baths, Primary0Secondary1, PilingFoundation, Basement1No0,
                              ContemporaryRoof, ContemporaryDesign, ExtWood, ExtAsbestos, ExtAluminum,
                              ElectricHeating, Fireplace, AC, Patio, Deck, Porch, Garage,
                              Pool, Shed, HotTub, NewDune, BH, LBT)
mydataStackedMatrixSB2<-na.omit(mydataStackedMatrixSB)
#-------------------------
ModelStackedMatrixSB = lm(LnNetValue~
                            LnYearBuilt+LnAcreageSqFt+LnSqFt+TotalRooms+StoryHeight+
                            Beds+Baths+Primary0Secondary1+ PilingFoundation+Basement1No0+
                            ContemporaryRoof+ContemporaryDesign+ExtWood+ExtAsbestos+ExtAluminum+
                            ElectricHeating+Fireplace+AC+Patio+Deck+Porch+Garage+
                            Pool+Shed+HotTub+NewDune+(NewDune*BH)+(NewDune*LBT), mydataStackedMatrixSB2)
summary(ModelStackedMatrixSB)

##-----------------------------------------##
##-----------------------------------------##
##       Generating a more robust SE       ##
##-----------------------------------------##
##-----------------------------------------##
#Robust/White Standard Errors for heteroscadasticity
##Robust Standard Erros
summaryR(ModelStackedMatrixSB)                ##Most conservative alternative
summaryR(ModelStackedMatrixSB, type="hc0")    ##White SE - Special Function written by John Fox
summaryR(ModelStackedMatrixSB, type="hc1")    #Stata's Default
summaryR(ModelStackedMatrixSB, type="hc2")    #Unbiased under homoskedasticity
summaryR(ModelStackedMatrixSB, type="hc3")    #default (conservative), same as no "type"
#-------------------------
#Test using linearHypothesis - Ftests
linearHypothesis(ModelStackedMatrixSB, "NewDuneSB+NewDuneBH+NewDuneLBT =1", white.adjust = "hc0")
linearHypothesis(ModelStackedMatrixSB, "LnYearBuilt+LnAcreageSqFt+LnSqFt+LnTotalRooms+LnStoryHeight+
                            LnBeds+LnBaths =1", white.adjust = "hc0")
linearHypothesis(ModelStackedMatrixSB, "Primary0Secondary1+Basement1No0+
                            ContemporaryRoof+ContemporaryDesign+ExtWood+ExtAsbestos+ExtAluminum+
                            ConcreteFoundation+ElectricHeating+AC+Patio+Deck+Porch+Garage+
                            Barn+Pool+Shed+HotTub+Fireplace =1", white.adjust = "hc0")





##--------------------------------
#linear regresion model for: ALL COMMUNITIES AS ONE BIG PROJECT
#          NewDune
#2016(BH)     0
#2017(BH)     1
#2016(LBT)    0
#2017(LBT)    1
#2016(SB)     0
#2017(SB)     1
#-----------------------------------------
mydataEntireProjectMatrix<-select(as.data.frame(LBIWHOLEStudy), LnNetValue, 
                              LnYearBuilt, LnAcreageSqFt, LnSqFt, TotalRooms, StoryHeight, 
                              Beds, Baths, Primary0Secondary1, PilingFoundation, Basement1No0,
                              ContemporaryRoof, ContemporaryDesign, ExtWood, ExtAsbestos, ExtAluminum,
                              ElectricHeating, Fireplace, AC, Patio, Deck, Porch, Garage,
                              Pool, Shed, HotTub, NewDune)
mydataEntireProjectMatrix2<-na.omit(mydataEntireProjectMatrix)
#-------------------------
ModelEntireMatrix = lm(LnNetValue~
                            LnYearBuilt+LnAcreageSqFt+LnSqFt+TotalRooms+StoryHeight+
                            Beds+Baths+Primary0Secondary1+ PilingFoundation+Basement1No0+
                            ContemporaryRoof+ContemporaryDesign+ExtWood+ExtAsbestos+ExtAluminum+
                            ElectricHeating+Fireplace+AC+Patio+Deck+Porch+Garage+
                            Pool+Shed+HotTub+NewDune, mydataEntireProjectMatrix2)
summary(ModelEntireMatrix)
##------Descriptive Statistics--------##
LBIWHOLEStudy$NetValue16<-as.numeric(impute(LBIWHOLEStudy$NetValue16, mean))
LBIWHOLEStudy$NetValue17<-as.numeric(impute(LBIWHOLEStudy$NetValue17, mean))
LBIWHOLEStudy$LnNetValue16<-as.numeric(impute(LBIWHOLEStudy$LnNetValue16, mean))
LBIWHOLEStudy$LnNetValue17<-as.numeric(impute(LBIWHOLEStudy$LnNetValue17, mean))
LBIWHOLEStudy$YearBuilt<-as.numeric(impute(LBIWHOLEStudy$YearBuilt, mean))
LBIWHOLEStudy$AcreageSqFt<-as.numeric(impute(LBIWHOLEStudy$AcreageSqFt, mean))
LBIWHOLEStudy$SqFt<-as.numeric(impute(LBIWHOLEStudy$SqFt, mean))
LBIWHOLEStudy$AcreageSqFt<-as.numeric(impute(LBIWHOLEStudy$AcreageSqFt, mean))
#ALL Descriptive Statistics for both Continuous and Dummy Variables
WHOLEStudyContDummyDescriptions<-select(as.data.frame(LBIWHOLEStudy), NetValue16, NetValue17, LnNetValue16, LnNetValue17, YearBuilt, AcreageSqFt, SqFt, TotalRooms, 
                                        StoryHeight, Beds, Baths, Primary0Secondary1, PilingFoundation, Basement1No0,
                                        ContemporaryRoof, ContemporaryDesign, ExtWood, ExtAsbestos, ExtAluminum,
                                        ElectricHeating, Fireplace, AC, Patio, Deck, Porch, Garage,
                                        Pool, Shed, HotTub)
describe(WHOLEStudyContDummyDescriptions)

