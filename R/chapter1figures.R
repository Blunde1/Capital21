
chapter_0_figures <- function(){

    library(scales)
    library(ggplot2)
    library(dplyr)

    chapter_0_data()

    FI.1 <- decile_share_us %>%
        ggplot +
        aes(x=year, y=percentage) +
        geom_line() +
        geom_point(shape=15, size=3) +
        ylab("Share of top decile in national income") + xlab("") +
        theme_bw() +
        scale_y_continuous(labels=percent, breaks=pretty_breaks(n=6)) +
        scale_x_date(breaks=pretty_breaks(n=11))

    FI.2 <-
        capital_V_income_eu %>%
        gather(key = "Country", value = "value", -year) %>%
        ggplot +
        aes(x = year, y = value, group=Country) +
        geom_line(aes(color = Country), size=1) +
        geom_point(aes(shape=Country), size=3) +
        ylab("Market value of private capital (% national income)") + xlab("") +
        theme_bw() + theme(legend.key=element_blank()) +
        scale_y_continuous(labels=percent,breaks=pretty_breaks(n=5)) +
        scale_x_date(breaks=pretty_breaks(n=8)) +
        theme(legend.position=c(.75, .75),legend.background=element_rect(colour='black'))

    assign("FI.1", FI.1, .GlobalEnv)
    assign("FI.2", FI.2, .GlobalEnv)


}
