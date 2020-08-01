
#####libraries

library(dplyr)
library(ggthemes)
library(ggplot2)





#####download files####

setwd("G:\\Scripting\\R\\John Hopkins Data Science\\Exploratory Data Analysis\\week 4 assignment")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
path<- getwd()
download.file(url,file.path(path, "dataFiles.zip"))
unzip(zipfile ="dataFiles.zip")


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#########question 5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?




grep("Vehicle",SCC$EI.Sector,value=TRUE) ## look for motor vehicle  related sources




rownum <-grep("Vehicle",SCC$EI.Sector) # save relevant rows

Vehicle_only <-SCC[rownum,] # subset

Vehicle_cat <-unique(Vehicle_only$SCC) # save category numbers


Vehicle_df <-filter(NEI,SCC %in% Vehicle_cat ) # create new df with only Vehicle related sources




###create separate df for Baltimore City, Maryland

Balt_df <-filter(Vehicle_df,fips == "24510" )




ggplot(Balt_df,aes(factor(year),Emissions, fill = factor(year))) + geom_bar(stat="identity")+
    theme_clean()+
    guides(fill=FALSE)+
    xlab("Year")+
    ggtitle("Emission from Motor Vehicle Sources in Baltimore City over Time")+
    theme(plot.title = element_text(hjust = 0.5))+
    scale_fill_manual(values=c("#ff1919", "#e5f2e5", "#e5f2e5","#7fbf7f"))



ggsave("plot5.png",
       device = "png")

