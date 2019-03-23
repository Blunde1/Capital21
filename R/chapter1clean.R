
clean_chapter0 <- function(path=NULL){

    library(readxl)
    library(lubridate)

    if(is.null(path)){
        wd <- getwd()
        location <- "/Piketty2014TechnicalAppendix/Piketty2014FiguresTables"
        chapter <- "/Chapter0TablesFigures.xlsx"
        path <- paste0(wd,location,chapter)
    }

    # Get relevant sheetnames
    sheetnames <- excel_sheets(path)
    sheetnames <- sheetnames[grepl("TS", sheetnames)]

    # Get dfs
    mylist <- lapply(sheetnames, read_excel, path = path)

    # name the dataframes
    names(mylist) <- sheetnames

    # Bring the dataframes to the global environment
    list2env(mylist ,.GlobalEnv)

    ## cleaning

    # Dataset 1:
    decile_share_us <- TSI.1[complete.cases(TSI.1),]
    names(decile_share_us) <- c("year", "percentage")
    decile_share_us$year <- lubridate::ymd(decile_share_us$year, truncated = 2L)

    # save to package
    devtools::use_data(decile_share_us, overwrite = T)

    # Dataset 2:
    capital_V_income_eu <- TSI.2[complete.cases(TSI.2),]
    capital_V_income_eu <- capital_V_income_eu[-1,]
    names(capital_V_income_eu) <- c("year", "Germany", "France", "Britain")
    capital_V_income_eu$year <- lubridate::ymd(capital_V_income_eu$year, truncated = 2L)
    for(j in 2:4){
        capital_V_income_eu[[j]] <- as.numeric(capital_V_income_eu[[j]])
    }

    #save to package
    devtools::use_data(capital_V_income_eu, overwrite = T)

}

