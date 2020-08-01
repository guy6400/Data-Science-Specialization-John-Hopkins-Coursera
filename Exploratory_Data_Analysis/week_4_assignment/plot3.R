
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

### question 3 : Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
#Which have seen increases in emissions from 1999–2008?



###create separate df for Baltimore City, Maryland

Balt_df <-filter(NEI,fips == "24510" )




ggplot(Balt_df,aes(factor(year),Emissions, fill = type)) + geom_bar(stat="identity")+
    theme_clean()+
    facet_grid(.~type)+
    guides(fill=FALSE)+
    xlab("Year")+
    ggtitle("Emission in Baltimore City over Time & by Source Type")+
    theme(plot.title = element_text(hjust = 0.5))+
    scale_fill_manual(values=c("orange", "red", "Gray","black"))



ggsave("plot3.png",
       device = "png")

