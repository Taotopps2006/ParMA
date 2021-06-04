# R environment preparation 
rm(list=ls())    # clears all variables declared in the memory

# installing required packages
install.packages('ggplot2')
install.packages('latticeExtra')
install.packages('Hmisc')
install.packages('reshape2')      # for reshaping data or melting data or normalizing data
install.packages('plyr')

# importing the installed packages
library(ggplot2)
library(lattice)
library(latticeExtra)
require(Hmisc)
library(reshape2)
library(plyr)

# Importing memory footprint data
library(readr)
N_10 <- read_csv("PHD/parallelization/ExperimentsCSV/CSV_memoryCDF/N_10.csv")
N_20 <- read_csv("PHD/parallelization/ExperimentsCSV/CSV_memoryCDF/N_20.csv")
N_30 <- read_csv("PHD/parallelization/ExperimentsCSV/CSV_memoryCDF/N_30.csv")
N_40 <- read_csv("PHD/parallelization/ExperimentsCSV/CSV_memoryCDF/N_40.csv")
N_50 <- read_csv("PHD/parallelization/ExperimentsCSV/CSV_memoryCDF/N_50.csv")
N_60 <- read_csv("PHD/parallelization/ExperimentsCSV/CSV_memoryCDF/N_60.csv")
N_70 <- read_csv("PHD/parallelization/ExperimentsCSV/CSV_memoryCDF/N_70.csv")
N_80 <- read_csv("PHD/parallelization/ExperimentsCSV/CSV_memoryCDF/N_80.csv")
N_90 <- read_csv("PHD/parallelization/ExperimentsCSV/CSV_memoryCDF/N_90.csv")
N_100 <- read_csv("PHD/parallelization/ExperimentsCSV/CSV_memoryCDF/N_100.csv")

# View one of the imported data
View(N_10)

#to see only column names of the data or names of variables
names(N_10)

# Melt the data frame
ggdata <- melt(N_10)  

# Rename a column in R
colnames(ggdata)[colnames(ggdata)=="variable"] <- "PyMP"

# Data Preprocessing
# removes NA's across all columns   
ggdata <- ggdata[complete.cases(ggdata), ]   # makes max(ggdata$value) get the maximium value instead of returning NA

# Set the data frame, & add ecdf() data.    ecdf() is the CDF function in R
ggdata <- ddply(ggdata, .(PyMP), transform, ecd=ecdf(value)(value))

# Create the CDF using ggplot for each rank.
cdf10<- ggplot(ggdata, aes(x=value)) + stat_ecdf(aes(colour=PyMP),lwd=1.2) +
  scale_y_continuous("CDF",breaks = seq(0, max(ggdata$ecd), 0.2)) +
  scale_x_continuous("Memory Usage (MB)", breaks = seq(0, max(ggdata$value), 10)) +
  theme(axis.title = element_text(size=35),axis.text=element_text(size=30,colour = "black"),
        axis.ticks = element_line(size = 3),
        axis.ticks.length = unit(.20, "cm"),
        legend.key.size = unit(0.8, "cm"),
        legend.text= element_text(size=25, face = "bold"),
        legend.title= element_text(size=25, face = "bold"),
        legend.position = c(.02, .97),
        legend.justification = c("left", "top"),
        legend.box.just = "right",
        legend.margin = margin(0.25, 0.05, 6, 0.25),
        panel.background = element_rect(fill = "white", colour = "black")) +
  guides(col = guide_legend(ncol =6)) 
# Generate the CDF.
cdf10

# Melt the data frame
ggdata2 <- melt(N_20)  

# Rename a column in R
colnames(ggdata2)[colnames(ggdata2)=="variable"] <- "PyMP"

# removes NA's across all columns   
ggdata2 <- ggdata2[complete.cases(ggdata2), ]  

# Set the data frame, & add ecdf() data.
ggdata2 <- ddply(ggdata2, .(PyMP), transform, ecd=ecdf(value)(value))

cdf20<- ggplot(ggdata2, aes(x=value)) + stat_ecdf(aes(colour=PyMP),lwd=1.2) +
  scale_y_continuous("CDF", breaks = seq(0, max(ggdata2$ecd), 0.2)) +
  scale_x_continuous("Memory Usage (MB)", breaks = seq(0, max(ggdata2$value), 20)) +
  theme(axis.title = element_text(size=35),axis.text=element_text(size=30,colour = "black"),
        axis.ticks = element_line(size = 3),
        axis.ticks.length = unit(.20, "cm"),
        legend.key.size = unit(0.8, "cm"),
        legend.text= element_text(size=25, face = "bold"),
        legend.title= element_text(size=25, face = "bold"),
        legend.position = c(.02, .97),
        legend.justification = c("left", "top"),
        legend.box.just = "right",
        legend.margin = margin(0.25, 0.05, 6, 0.25),
        panel.background = element_rect(fill = "white", colour = "black")) +
  guides(col = guide_legend(ncol =6))
# Generate the CDF..
cdf20

# Melt the data frame
ggdata3 <- melt(N_30)  

# Rename a column in R
colnames(ggdata3)[colnames(ggdata3)=="variable"] <- "PyMP"

# removes NA's across all columns   
ggdata3 <- ggdata3[complete.cases(ggdata3), ] 

# Set the data frame, & add ecdf() data.
ggdata3 <- ddply(ggdata3, .(PyMP), transform, ecd=ecdf(value)(value))

cdf30<- ggplot(ggdata3, aes(x=value)) + stat_ecdf(aes(colour=PyMP),lwd=1.2) +
  scale_y_continuous("CDF", breaks = seq(0, max(ggdata3$ecd), 0.2)) +
  scale_x_continuous("Memory Usage (MB)", breaks = seq(0, max(ggdata3$value)+20, 50)) +
  theme(axis.title = element_text(size=35),axis.text=element_text(size=30,colour = "black"),
        axis.ticks = element_line(size = 3),
        axis.ticks.length = unit(.20, "cm"),
        legend.key.size = unit(0.8, "cm"),
        legend.text= element_text(size=25, face = "bold"),
        legend.title= element_text(size=25, face = "bold"),
        legend.position = c(.02, .97),
        legend.justification = c("left", "top"),
        legend.box.just = "right",
        legend.margin = margin(0.25, 0.05, 6, 0.25),
        panel.background = element_rect(fill = "white", colour = "black")) +
  guides(col = guide_legend(ncol =6))
# Generate the CDF.
cdf30

# Melt the data frame
ggdata4 <- melt(N_40)  

# Rename a column in R
colnames(ggdata4)[colnames(ggdata4)=="variable"] <- "PyMP"

# removes NA's across all columns   
ggdata4 <- ggdata4[complete.cases(ggdata4), ] 

# Set the data frame, & add ecdf() data.
ggdata4 <- ddply(ggdata4, .(PyMP), transform, ecd=ecdf(value)(value))

cdf40<- ggplot(ggdata4, aes(x=value)) + stat_ecdf(aes(colour=PyMP),lwd=1.2) +
  scale_y_continuous("CDF", breaks = seq(0, max(ggdata4$ecd), 0.2)) +
  scale_x_continuous("Memory Usage (MB)", breaks = seq(0, max(ggdata4$value)+20, 100)) +
  theme(axis.title = element_text(size=35),axis.text=element_text(size=30,colour = "black"),
        axis.ticks = element_line(size = 3),
        axis.ticks.length = unit(.20, "cm"),
        legend.key.size = unit(0.8, "cm"),
        legend.text= element_text(size=25, face = "bold"),
        legend.title= element_text(size=25, face = "bold"),
        legend.position = c(.02, .97),
        legend.justification = c("left", "top"),
        legend.box.just = "right",
        legend.margin = margin(0.25, 0.05, 6, 0.25),
        panel.background = element_rect(fill = "white", colour = "black")) +
  guides(col = guide_legend(ncol =6))
# Generate the CDF.
cdf40

# Melt the data frame
ggdata5 <- melt(N_50)  

# Rename a column in R
colnames(ggdata5)[colnames(ggdata5)=="variable"] <- "PyMP"

# removes NA's across all columns   
ggdata5 <- ggdata5[complete.cases(ggdata5), ]  

# Set the data frame, & add ecdf() data.
ggdata5 <- ddply(ggdata5, .(PyMP), transform, ecd=ecdf(value)(value))

cdf50<- ggplot(ggdata5, aes(x=value)) + stat_ecdf(aes(colour=PyMP),lwd=1.2) +
  scale_y_continuous("CDF", breaks = seq(0, max(ggdata5$ecd), 0.2)) +
  scale_x_continuous("Memory Usage (MB)", breaks = seq(0, max(ggdata5$value)+400, 250)) +
  theme(axis.title = element_text(size=35),axis.text=element_text(size=30,colour = "black"),
        axis.ticks = element_line(size = 3),
        axis.ticks.length = unit(.20, "cm"),
        legend.key.size = unit(0.8, "cm"),
        legend.text= element_text(size=25, face = "bold"),
        legend.title= element_text(size=25, face = "bold"),
        legend.position = c(.02, .97),
        legend.justification = c("left", "top"),
        legend.box.just = "right",
        legend.margin = margin(0.25, 0.05, 6, 0.25),
        panel.background = element_rect(fill = "white", colour = "black")) +
  guides(col = guide_legend(ncol =6))
# Generate the CDF.
cdf50

# Melt the data frame
ggdata6 <- melt(N_60)  

# Rename a column in R
colnames(ggdata6)[colnames(ggdata6)=="variable"] <- "PyMP"

# removes NA's across all columns   
ggdata6 <- ggdata6[complete.cases(ggdata6), ]  

# Set the data frame, & add ecdf() data.
ggdata6 <- ddply(ggdata6, .(PyMP), transform, ecd=ecdf(value)(value))

cdf60<- ggplot(ggdata6, aes(x=value)) + stat_ecdf(aes(colour=PyMP),lwd=1.2) +
  scale_y_continuous("CDF", breaks = seq(0, max(ggdata6$ecd), 0.2)) +
  scale_x_continuous("Memory Usage (MB)", breaks = seq(0, max(ggdata6$value)+100, 500)) +
  theme(axis.title = element_text(size=35),axis.text=element_text(size=30,colour = "black"),
        axis.ticks = element_line(size = 3),
        axis.ticks.length = unit(.20, "cm"),
        legend.key.size = unit(0.8, "cm"),
        legend.text= element_text(size=25, face = "bold"),
        legend.title= element_text(size=25, face = "bold"),
        legend.position = c(.02, .97),
        legend.justification = c("left", "top"),
        legend.box.just = "right",
        legend.margin = margin(0.25, 0.05, 6, 0.25),
        panel.background = element_rect(fill = "white", colour = "black")) +
  guides(col = guide_legend(ncol =6))
# Generate the CDF.
cdf60

# Melt the data frame
ggdata7 <- melt(N_70)  

# Rename a column in R
colnames(ggdata7)[colnames(ggdata7)=="variable"] <- "PyMP"

# removes NA's across all columns   
ggdata7 <- ggdata7[complete.cases(ggdata7), ]  

# Set the data frame, & add ecdf() data.
ggdata7 <- ddply(ggdata7, .(PyMP), transform, ecd=ecdf(value)(value))

cdf70<- ggplot(ggdata7, aes(x=value)) + stat_ecdf(aes(colour=PyMP),lwd=1.2) +
  scale_y_continuous("CDF", breaks = seq(0, max(ggdata7$ecd), 0.2)) +
  scale_x_continuous("Memory Usage (MB)", breaks = seq(0, max(ggdata7$value)+400, 1000)) +
  theme(axis.title = element_text(size=35),axis.text=element_text(size=30,colour = "black"),
        axis.ticks = element_line(size = 3),
        axis.ticks.length = unit(.20, "cm"),
        legend.key.size = unit(0.8, "cm"),
        legend.text= element_text(size=25, face = "bold"),
        legend.title= element_text(size=25, face = "bold"),
        legend.position = c(.02, .97),
        legend.justification = c("left", "top"),
        legend.box.just = "right",
        legend.margin = margin(0.25, 0.05, 6, 0.25),
        panel.background = element_rect(fill = "white", colour = "black")) +
  guides(col = guide_legend(ncol =6))
# Generate the CDF.
cdf70

# Melt the data frame
ggdata8 <- melt(N_80)  

# Rename a column in R
colnames(ggdata8)[colnames(ggdata8)=="variable"] <- "PyMP"

# removes NA's across all columns   
ggdata8 <- ggdata8[complete.cases(ggdata8), ]   

# Set the data frame, & add ecdf() data.
ggdata8 <- ddply(ggdata8, .(PyMP), transform, ecd=ecdf(value)(value))

cdf80<- ggplot(ggdata8, aes(x=value)) + stat_ecdf(aes(colour=PyMP),lwd=1.2) +
  scale_y_continuous("CDF", breaks = seq(0, max(ggdata8$ecd), 0.2)) +
  scale_x_continuous("Memory Usage (MB)", breaks = seq(0, max(ggdata8$value)+400, 2000)) +
  theme(axis.title = element_text(size=35),axis.text=element_text(size=30,colour = "black"),
        axis.ticks = element_line(size = 3),
        axis.ticks.length = unit(.20, "cm"),
        legend.key.size = unit(0.8, "cm"),
        legend.text= element_text(size=25, face = "bold"),
        legend.title= element_text(size=25, face = "bold"),
        legend.position = c(.02, .97),
        legend.justification = c("left", "top"),
        legend.box.just = "right",
        legend.margin = margin(0.25, 0.05, 6, 0.25),
        panel.background = element_rect(fill = "white", colour = "black")) +
  guides(col = guide_legend(ncol =6))
# Generate the CDF.
cdf80

# Melt the data frame
ggdata9 <- melt(N_90)  

# Rename a column in R
colnames(ggdata9)[colnames(ggdata9)=="variable"] <- "PyMP"

# removes NA's across all columns   
ggdata9 <- ggdata9[complete.cases(ggdata9), ]  

# Set the data frame, & add ecdf() data.
ggdata9 <- ddply(ggdata9, .(PyMP), transform, ecd=ecdf(value)(value))

cdf90<- ggplot(ggdata9, aes(x=value)) + stat_ecdf(aes(colour=PyMP),lwd=1.2) +
  scale_y_continuous("CDF", breaks = seq(0, max(ggdata9$ecd), 0.2)) +
  scale_x_continuous("Memory Usage (MB)", breaks = seq(0, max(ggdata9$value)+400, 2500)) +
  theme(axis.title = element_text(size=35),axis.text=element_text(size=30,colour = "black"),
        axis.ticks = element_line(size = 3),
        axis.ticks.length = unit(.20, "cm"),
        legend.key.size = unit(0.8, "cm"),
        legend.text= element_text(size=25, face = "bold"),
        legend.title= element_text(size=25, face = "bold"),
        legend.position = c(.02, .97),
        legend.justification = c("left", "top"),
        legend.box.just = "right",
        legend.margin = margin(0.25, 0.05, 6, 0.25),
        panel.background = element_rect(fill = "white", colour = "black")) +
  guides(col = guide_legend(ncol =6))
# Generate the CDF.
cdf90

# Melt the data frame
ggdata10 <- melt(N_100)  

# Rename a column in R
colnames(ggdata10)[colnames(ggdata10)=="variable"] <- "PyMP"

# removes NA's across all columns   
ggdata10 <- ggdata10[complete.cases(ggdata10), ]  

# Set the data frame, & add ecdf() data.
ggdata10 <- ddply(ggdata10, .(PyMP), transform, ecd=ecdf(value)(value))

cdf100<- ggplot(ggdata10, aes(x=value)) + stat_ecdf(aes(colour=PyMP),lwd=1.2) +
  scale_y_continuous("CDF", breaks = seq(0, max(ggdata10$ecd), 0.2)) +
  scale_x_continuous("Memory Usage (MB)", breaks = seq(0, max(ggdata10$value)+400, 5000)) +
  theme(axis.title = element_text(size=35),axis.text=element_text(size=30,colour = "black"),
        axis.ticks = element_line(size = 3),
        axis.ticks.length = unit(.20, "cm"),
        legend.key.size = unit(0.8, "cm"),
        legend.text= element_text(size=25, face = "bold"),
        legend.title= element_text(size=25, face = "bold"),
        legend.position = c(.02, .97),
        legend.justification = c("left", "top"),
        legend.box.just = "right",
        
        legend.margin = margin(0.25, 0.05, 6, 0.25),
        panel.background = element_rect(fill = "white", colour = "black")) +
  guides(col = guide_legend(ncol =6))
# Generate the CDF.
cdf100
