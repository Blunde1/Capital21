
runExample <- function(){
    # Packages for data wrangeling
    library(ggplot2)
    library(dplyr)
    library(tidyr)

    # Load data from Capital21
    data("capital_V_income_eu")

    # Melt data
    df <- capital_V_income_eu %>%
        gather(key = "variable", value = "value", -year)
    head(df, 3)

    # Reproducing Figure 2 in the book
    chap0_fig2 <- df %>%
        ggplot +
        aes(x = year, y = value) +
        geom_line(aes(color = variable), size=1) +
        scale_color_manual(values = c("black","red","blue")) +
        theme_minimal()
    chap0_fig2
}
