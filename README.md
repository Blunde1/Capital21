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
```

> "The capital/income ratio in Europe, 1870-2010"

| year       |   Germany|    France|   Britain|
|:-----------|---------:|---------:|---------:|
| 1870-01-01 |  6.438988|  6.992606|  6.961611|
| 1880-01-01 |  6.443348|  7.328977|  6.367099|
| 1890-01-01 |  5.923051|  7.264028|  6.092323|
| 1900-01-01 |  6.112386|  7.261795|  6.499294|
| 1910-01-01 |  6.042470|  6.994556|  6.725313|
| 1920-01-01 |  2.591279|  3.300902|  4.412806|
| 1930-01-01 |  3.068955|  3.438186|  5.079650|
| 1940-01-01 |  2.664139|  3.172543|  3.990266|
| 1950-01-01 |  1.656535|  2.185893|  3.127889|
| 1960-01-01 |  2.093342|  2.797374|  3.128338|
| 1970-01-01 |  2.294364|  3.114872|  3.144080|
| 1980-01-01 |  2.844778|  3.204479|  3.503478|
| 1990-01-01 |  3.134487|  3.413831|  4.282104|
| 2000-01-01 |  3.766189|  4.742294|  4.955841|
| 2010-01-01 |  4.116648|  5.745578|  5.218760|

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

<img src="README_files/figure-markdown_github/unnamed-chunk-4-1.png" style="display: block; margin: auto;" />

#### Retrieve all figures from a chapter

``` r
# Typically relies on ggplot2 and dplyr
chapter_0_figures()
FI.1
```

<img src="README_files/figure-markdown_github/unnamed-chunk-5-1.png" style="display: block; margin: auto;" />

``` r
FI.2
```

<img src="README_files/figure-markdown_github/unnamed-chunk-5-2.png" style="display: block; margin: auto;" />
