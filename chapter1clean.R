library(readxl)
wd <- getwd()
location <- "/Piketty2014TechnicalAppendix/Piketty2014FiguresTables"
chapter <- "/Chapter0TablesFigures.xlsx"
path <- paste0(wd,location,chapter)
sheetnames <- excel_sheets(path)
sheetnames <- sheetnames[grepl("TS", sheetnames)]
mylist <- lapply(sheetnames, read_excel, path = path)

# name the dataframes
names(mylist) <- sheetnames

# Bring the dataframes to the global environment
list2env(mylist ,.GlobalEnv)

# Dataset 1:
decile_share_us <- TSI.1[complete.cases(TSI.1),]
names(decile_share_us) <- c("year", "percentage")
#View(decile_share_us)

# save to package
devtools::use_data(decile_share_us, overwrite = T)

# Dataset 2:
capital_V_income_eu <- TSI.2[complete.cases(TSI.2),]
#View(capital_V_income_eu)
capital_V_income_eu <- capital_V_income_eu[-1,]
names(capital_V_income_eu) <- c("year", "Germany", "France", "Britain")

#save to package
devtools::use_data(capital_V_income_eu, overwrite = T)

