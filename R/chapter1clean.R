
clean_chapter1 <- function(path=NULL){

    library(readxl)
    library(lubridate)
    #library(dplyr)

    clean <- function(dat, names, year2date=NULL, char2num=NULL){
        names(dat) <- names
        if(!is.null(year2date)){
            if(dat[1,year2date]=="0") dat[1,year2date] <- "0000"
            dat[[year2date]] <- lubridate::ymd(dat[[year2date]], truncated = 2L)
            dat <- dat[order(dat[[year2date]]),]
        }
        if(!is.null(char2num)){
            for(j in char2num){
                dat[[j]] <- as.numeric(dat[[j]])
            }
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
    #View(TS1.3)
    per_capita_gdp <- clean(TS1.3[c(4:14,18),c(1,3:8)],
                            unlist(c("Year", TS1.3[3, 3:8])),
                            year2date = 1,
                            char2num = 2:7)
    devtools::use_data(per_capita_gdp, overwrite = T)

    per_capita_gdp_count <- clean(TS1.3[ c(4:14, 18), c(1, 10:14)],
                                  unlist(c("Year", TS1.3[3,10:14])),
                                  year2date = 1,
                                  char2num = 2:6)
    devtools::use_data(per_capita_gdp_count, overwrite = T)

    per_capita_gdp_detail <- clean(
        dat = TS1.3[c(4:14, 18), c(1, 17:31)],
        names = unlist(c("Year", TS1.3[3, 17:31])),
        year2date = 1,
        char2num = 2:16)
    devtools::use_data(per_capita_gdp_detail, overwrite = T)

    # TS1.4 = ROUNDED TS1.5
    View(TS1.4); View(TS1.5)
    dist_world_gdp_2012 <- clean(
        dat = TS1.5[4:20,],
        names = c("Region", "Population (millions)", "ppp_gdp", "ppp_per_capita_gdp", "ppp_per_capita_gdp_monthly",
                  "cer_gdp", "cer_per_capita_gdp", "cer_per_capita_gdp_monthly"),
        char2num = 2:8
        )
    devtools::use_data(dist_world_gdp_2012, overwrite = T)


    # TS1.7
    View(TS1.7)
    er_ppp_1990_2012 <- clean(
        dat = TS1.7[4:26, c(1:9, 11:22)],
        names = unlist(c("Year", TS1.7[3,c(2:9, 11:22)])),
        year2date = 1,
        char2num = 2:21
    )
    devtools::use_data(er_ppp_1990_2012, overwrite = T)


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

