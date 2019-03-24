Capital 21
================
Berent Lunde

#### Datasets from the book: "Capital in the Twenty-First Century" by Thomas Piketty.

The Capital21 package provides an easy interface for the datasets used in the book "Capital in the Twenty-First Century" by Thomas Piketty.

Authored and maintained by [Berent Å. S. Lunde](https://berentlunde.netlify.com).

Installation instructions:

``` r
library(devtools)
install_github("Blunde1/Capital21")

# Optionally run example
runExample()
```

Examples:
---------

#### Loading chapter data into global environment

``` r
library(Capital21)

# Load and list chapter 0 data
chapter_0_data()
ls()
```

\[1\] "capital\_V\_income\_eu" "decile\_share\_us"

``` r
rm(list=ls())

# Load and list chapter 1 data
chapter_1_data()
ls()
```

\[1\] "dist\_world\_gdp" "dist\_world\_gdp\_2012"
\[3\] "dist\_world\_output\_detailed" "dist\_world\_output\_percent" \[5\] "dist\_world\_output\_val" "er\_ppp\_1990\_2012"
\[7\] "per\_capita\_gdp" "per\_capita\_gdp\_count"
\[9\] "per\_capita\_gdp\_detail" "world\_population"
\[11\] "world\_population\_count" "world\_population\_detail"

#### Reproducing figures

``` r
# Packages for data wrangeling
library(ggplot2)
library(dplyr)
library(tidyr)

# Load data from Capital21
data("capital_V_income_eu")

# Melt and plot data 
p <- capital_V_income_eu %>%
    gather(key = "variable", value = "value", -year) %>%
    ggplot + 
    aes(x = year, y = value) + 
    geom_line(aes(color = variable), size=1) +
    scale_color_manual(values = c("black","red","blue")) +
    theme_minimal()
p
```

![](README_files/figure-markdown_github/unnamed-chunk-3-1.png)
