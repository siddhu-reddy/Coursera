## Exploratory Data Analysis
## Course Project 2: Plot 2
## plot2.R

val_dfpath <- paste(getwd(), "data", sep = "/")
val_dfname <- c("summarySCC_PM25.rds", "Source_Classification_Code.rds")
val_dfdlink <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

for (i in val_dfname) {
  
  if(file.exists(paste(val_dfpath, i, sep = "/")) == FALSE){
    
    tryCatch({
      
      temp_data <- tempfile()
      download.file(val_dfdlink, temp_data)
      dir.create(val_dfpath)
      unzip(temp_data, exdir = val_dfpath)
      unlink(temp_data, force = TRUE)
      rm(temp_data)
      
    }, error = function(e){
      
      stop("Datafile error")
      
    })
    
  } 
  
}

## Set the name of the datafiles
Val_df_em <- paste(val_dfpath, val_dfname[1], sep = "/")
Val_df_scc <- paste(val_dfpath, val_dfname[2], sep = "/")

## Read the datafiles
data_em <- readRDS(Val_df_em)
data_scc <- readRDS(Val_df_scc)

## Show datafile structure
## str(data_em)
## str(data_scc)

## Subset Emissions datafile by Baltimore fips instances
data_em_balt <- subset(data_em, data_em$fips == "24510")

## Sum emissions per year within Baltimore fips subset
val_em_balt_emyr <- tapply(data_em_balt$Emissions, INDEX = data_em_balt$year, sum)

## Create plot file
png("plot2.png", width = 480, height = 480)

## Create plot
plot(names(val_em_balt_emyr), val_em_balt_emyr, type = "o", main = "Total US Emissions: Baltimore", xlab = "Year", ylab = expression(PM[2.5] ~ "Emissions (tons)"))

## Return number and name of new active device
dev.off()