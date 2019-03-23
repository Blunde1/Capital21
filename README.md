# Capital21
Datasets from the book: "Capital in the Twenty-First Century" by Thomas Piketty.

The Capital21 package provides an easy interface for the datasets used in the book "Capital in the Twenty-First Century" by Thomas Piketty.

Authored and maintained by [Berent Å. S. Lunde](https://berentlunde.netlify.com).

Installation instructions:

``` r
library(devtools)
install_github("Blunde1/Capital21)
```

Example:
--------

``` r
library(Capital21)

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
p <- df %>% 
    ggplot + 
    aes(x = year, y = value) + 
    geom_line(aes(color = variable), size=1) +
    scale_color_manual(values = c("black","red","blue")) +
    theme_minimal()
p
```
