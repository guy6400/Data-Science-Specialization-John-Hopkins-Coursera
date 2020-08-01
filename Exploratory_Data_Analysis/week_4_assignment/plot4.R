
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


######question 4 : Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?


# Look for all coal combustion-related sources

grep("Coal",SCC$EI.Sector,value=TRUE) ## look for coal related sources
# results from quary show all are combustion-related


rownum <-grep("Coal",SCC$EI.Sector) # save relevant rows

coal_only <-SCC[rownum,] # subset

coal_cat <-unique(coal_only$SCC) # save category numbers


coalcomb_df <-filter(NEI,SCC %in% coal_cat ) # create new df with only coal combustion related sources



ggplot(coalcomb_df,aes(factor(year),Emissions, fill =factor(year))) + geom_bar(stat="identity")+
    theme_clean()+
    xlab("Year")+
    guides(fill=FALSE)+
    ggtitle("Emissions from Coal Combustion-Related Sources Over Time")+
    theme(plot.title = element_text(hjust = 0.5))+
    scale_fill_manual(values=c("#ff1919", "#ff6666", "#ff6666","#66b266"))


ggsave("plot4.png",
       device = "png")
