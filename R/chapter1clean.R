
clean_chapter1 <- function(path=NULL){

    library(readxl)
    library(lubridate)

    clean <- function(dat, names, year2date, char2num){
        names(dat) <- names
        if(dat[1,year2date]=="0") dat[1,year2date] <- "0000"
        dat[[year2date]] <- lubridate::ymd(dat[[year2date]], truncated = 2L)
        for(j in char2num){
            dat[[j]] <- as.numeric(dat[[j]])
        }
        return(dat)
    }

    if(is.null(path)){
        wd <- getwd()
        location <- "/Piketty2014TechnicalAppendix/Piketty2014FiguresTables"
        chapter <- "/Chapter1TablesFigures.xlsx"
        path <- paste0(wd,location,chapter)
        rm(wd,location,chapter)
    }

    # Get relevant sheetnames
    sheetnames <- excel_sheets(path)
    sheetnames <- sheetnames[grepl("T", sheetnames)]

    # Get dfs
    mylist <- lapply(sheetnames, read_excel, path = path)

    # name the dataframes
    names(mylist) <- sheetnames

    # Bring the dataframes to the global environment
    list2env(mylist ,.GlobalEnv)

    ## cleaning

    getNames <- function(data, rows){
        subdat <- data[rows,]
        coln <- character(ncol(data))
        for(i in 1:ncol(data)){
            for(j in 1:length(rows)){
                coln[i] <- paste0(coln[i],data[j,i])
            }
        }
        coln
    }
    getNames(data, 1:2)

    # T1.1
    dist_world_gdp <- T1.1[complete.cases(T1.1),]
    names(dist_world_gdp) <- c("Location", "Population (million inhabitants)", "Population  world percentage",
                               "GDP (billion euros 2012)", "GDP world percentage",
                               "Per capita GDP (euros 2012)", "Equivalent per capita monthly income")
    for(j in 2:ncol(dist_world_gdp)){
        dist_world_gdp[[j]] <- as.numeric(dist_world_gdp[[j]])
    }
    devtools::use_data(dist_world_gdp, overwrite = T)


    # TS1.1a
    # percent
    dist_world_output_percent <- TS1.1a[4:14,c(1,3:6)]
    names(dist_world_output_percent) <- c("Year", "Europe", "America", "Africa", "Asia")
    dist_world_output_percent[1,1] <- "0000"
    dist_world_output_percent$Year <- lubridate::ymd(dist_world_output_percent$Year, truncated = 2L)
    for(j in 2:ncol(dist_world_output_percent)){
        dist_world_output_percent[[j]] <- as.numeric(dist_world_output_percent[[j]])
    }
    devtools::use_data(dist_world_output_percent, overwrite = T)

    # billions
    dist_world_output_val <- TS1.1a[4:14,c(1,8:12)]
    names(dist_world_output_val) <- c("Year", "World", "Europe", "America", "Africa", "Asia")
    dist_world_output_val[1,1] <- "0000"
    dist_world_output_val$Year <- lubridate::ymd(dist_world_output_val$Year, truncated = 2L)
    for(j in 2:ncol(dist_world_output_val)){
        dist_world_output_val[[j]] <- as.numeric(dist_world_output_val[[j]])
    }
    devtools::use_data(dist_world_output_val, overwrite = T)

    # b - details
    dist_world_output_detailed <- TS1.1a[4:14,c(14:29)]
    names(dist_world_output_detailed) <- unlist(c("Year", TS1.1a[3,c(15:29)]))
    dist_world_output_detailed[1,1] <- "0000"
    dist_world_output_detailed$Year <- lubridate::ymd(dist_world_output_detailed$Year, truncated = 2L)
    for(j in 2:ncol(dist_world_output_detailed)){
        dist_world_output_detailed[[j]] <- as.numeric(dist_world_output_detailed[[j]])
    }
    devtools::use_data(dist_world_output_detailed, overwrite = T)


    # TS1.2
    world_population <- clean(TS1.2[4:14, c(1,3:6)],
                          unlist(c("Year", TS1.2[3,c(3:6)])),
                          1,
                          2:5)
    devtools::use_data(world_population, overwrite = T)

    world_population_count <- clean(TS1.2[4:14, c(1,8:12)],
                                       unlist(c("Year", TS1.2[3, c(8:12)])),
                                       1, 2:6)
    devtools::use_data(world_population_count, overwrite = T)


    world_population_detail <- clean(TS1.2[4:14, c(14:29)],
                                    unlist(c("Year", TS1.2[3, c(15:29)])),
                                    1, 2:15)
    devtools::use_data(world_population_detail, overwrite = T)

    # TS1.3
    View(TS1.3)



}


chapter_1_data <- function(){
    data(dist_world_gdp)
    data(dist_world_output_percent)
    data(dist_world_output_val)
    data(dist_world_output_detailed)
    data(world_population)
    data(world_population_count)
    data(world_population_detail)
}

