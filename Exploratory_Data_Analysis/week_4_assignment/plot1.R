
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


##### question 1:Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
###Using the base plotting system, make a plot showing the total PM2.5 emission
#from all sources for each of the years 1999, 2002, 2005, and 2008.


# create df grouped by year

df_agg <- NEI %>%
    group_by(as.factor(year))

#summerize according to the sum of emmisions

df_summary <- summarize(df_agg,emissions_per_year =sum(Emissions))



png("plot1.png")

barplot(df_summary$emissions_per_year,main = "Overall USA Emissions over Time",ylab = "Total Emissions"
        ,names = df_summary$`as.factor(year)`
        ,col = "red")


dev.off()

