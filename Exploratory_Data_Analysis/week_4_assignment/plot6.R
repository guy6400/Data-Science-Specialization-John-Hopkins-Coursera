
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

#########question 6:Compare emissions from motor vehicle sources in Baltimore City
#with emissions from motor vehicle sources in Los Angeles County, California
# Which city has seen greater changes over time in motor vehicle emissions?




grep("Vehicle",SCC$EI.Sector,value=TRUE) ## look for motor vehicle  related sources




rownum <-grep("Vehicle",SCC$EI.Sector) # save relevant rows

Vehicle_only <-SCC[rownum,] # subset

Vehicle_cat <-unique(Vehicle_only$SCC) # save category numbers


Vehicle_df <-filter(NEI,SCC %in% Vehicle_cat ) # create new df with only Vehicle related sources




###create separate df for Baltimore City, Maryland & Los Angeles County, California


Cities_df <-filter(Vehicle_df,fips == "24510" | fips == "06037" )


## ass character variable with city name, to better label the plot

Cities_df <- Cities_df %>% 
    mutate( city = case_when(
        Cities_df$fips == "24510" ~ "Baltimore City, Maryland",
        Cities_df$fips == "06037" ~ "Los Angeles County, California"
    )
    )






ggplot(Cities_df,aes(factor(year),Emissions, fill = city)) + geom_bar(stat="identity")+
    theme_clean()+
    facet_grid(.~city)+
    guides(fill=FALSE)+
    xlab("Year")+
    ggtitle("Emission Comparison Over Time: Baltimore City VS Los Angeles County")+
    theme(plot.title = element_text(hjust = 0.5))+
    scale_fill_manual(values=c("green", "red"))



ggsave("plot6.png",
       device = "png")

