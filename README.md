
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sccthemes <img src="inst/figures/scc-hex.png" align="right" width="120"/>

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of sccthemes is to provide a consistent styling framework and
helper functions for graphics made in ggplot at the Suffolk County
Council.

This package has been heavily inspired by
[bbplot](https://github.com/bbc/bbplot), the BBC’s R package for
creating and exporting graphics made in ggplot.

## Installation

You can install the development version of sccthemes from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("thomaszwagerman/sccthemes")
```

## Suffolk County Council brand and styling

The font and colour codes have been sourced from the [Suffolk County
Council’s website](https://www.suffolk.gov.uk/), and Google Chrome’s
Inspect functionality (Ctrl + Shift + i).

The style can be called to any ggplot2 object using `scc_style()`

``` r
library(ggplot2)
library(gapminder)
library(dplyr)
library(sccthemes)

barchart_data <- gapminder |> 
  filter(year == 2007 & continent == "Europe") |> 
  arrange(desc(gdpPercap)) |> 
  head(5)

barchart_data |> 
  ggplot(aes(x = country, y = gdpPercap)) +
  geom_bar(
    stat = "identity",
    position = "identity",
    color = "#333333",
    fill = "#428bca"
  ) +
  geom_hline(
    yintercept =  0,
    size = 1,
    colour = "#333333"
  ) +
  scc_style() +
  labs(
    title = "Europe's Richest Countries",
    subtitle = "GDP per Capita, 2007"
  )
```

<img src="man/figures/README-style_example-1.png" width="100%" />

## Helper functions for ggplot2

Helper functions for certain types of plots are also provided in this
repo.

Instead of the code above for instance, this package also contains
helper functions which are rough and ready:

``` r
library(ggplot2)
library(gapminder)
library(dplyr)
library(sccthemes)

barchart_data <- gapminder |> 
  filter(year == 2007 & continent == "Europe") |> 
  arrange(desc(gdpPercap)) |> 
  head(5)

scc_barchart(
  barchart_data,
  x = "country",
  y = "gdpPercap",
  title = "Europe's Richest Countries",
  subtitle = "GDP per Capita, 2007"
)
```

<img src="man/figures/README-helper_example-1.png" width="100%" />
Currently, there are helper functions for the following plot types:

- Barplots
- Piecharts (but why you [should discourage their use if you
  can](https://www.data-to-viz.com/caveat/pie.html))

The BBC’s [“ggplot
cookbook”](https://bbc.github.io/rcookbook/#make_a_bar_chart) is a good
starting point to use as a reference.

More helper functions will be added as I need to make them.

## Publishing your plots

To publish your work, so will need to save your plot. Saving plots in
ggplot2 can be a bit of a hassle, so we’re porting bbplot’s
`finalise_plot()` function. Some adjustments have been made, for example
we might not want a logo on every plot. Also, because this package does
not just deal with ggplot, I’ve renamed the function
`finalise_ggplot()`, to specify this is for `ggplot2` object only.

Once you have created your plot and are happy with it, you can use
`finalise_ggplot()` so that you can look at it outside RStudio. Note
that the position of the text and other elements do not render
accurately in the RStudio Plots panel, so saving it out and opening up
the files give you an accurate representation of how the graphic looks.

Also you might want to use the same plot for different purpose: the size
of a plot in a presentation will need to be a different size from one in
a report. `finalise_ggplot()` allows for this without having to change
the original plot.

``` r
library(ggplot2)
library(gapminder)
library(dplyr)
library(sccthemes)

barchart_data <- gapminder |> 
  filter(year == 2007 & continent == "Europe") |> 
  arrange(desc(gdpPercap)) |> 
  head(5)

plot_to_save <- scc_barchart(
  barchart_data,
  x = "country",
  y = "gdpPercap",
  title = "Europe's Richest Countries",
  subtitle = "GDP per Capita, 2007"
)

finalise_ggplot(
  plot_to_save,
  source = "Jennifer Bryan, 2017, Gapminder R package, https://github.com/jennybc/gapminder",
  save_filepath = "inst/plots/publish_plot_example.png",
  width_pixels = 225,
  height_pixels = 175
)
```

<p align="center">
<img src="inst/plots/publish_plot_example.png">
</p>

## A note on colour palettes, branding and accessibility

### Putting thought into requirements and responsibilities

The goal of colour palettes is to improve storytelling with data,
whether it is to show continuous change in a value, differences between
distinct categories or to highlight a specific category that you want to
highlight.

Some questions we need to think about when choosing colour:

- Is it accessible for everyone, specifically for those with colour
  blindness/color vision deficiency?
- Is there an association with the colour we use (ie green is
  good/positive, red is bad/negative)
- Does it fit within the SCC brand?

### Sticking to the Suffolk County Council brand, where possible

The Suffolk County Council has its own colour schemes, the recognisable
blues and orange found on the [website](https://www.suffolk.gov.uk/).

This <span style="color:#2d6ca2">**blue (#2d6ca2)**</span> is used as
the primary colour in graphs, with <span style="color:#e8850c">**orange
(#e8850c)**</span> as the secondary colour. Where applicable, the <span
style="color:#e2eefa">**light blue (#e2eefa)**</span> can used as a
tertiary colour - but note that this not easily visible against white
background (consider using a black outline).

Blue and Orange are colours that are distinct for most common forms of
colour blindness/color vision deficiency. However, different types of
graphs have vastly different requirements to tell a story, and where the
number of categories exceeds three colours the SCC palette is not
sufficient.

### No need to reinvent the wheel - use **Viridis**

Therefore, instead of designing our own colour palette, I’d recommend
the use of [viridis](https://github.com/sjmgarnier/viridis), for graphs
with more than three categories. This package has visually appealing
colour palettes, and improve graph readability for readers with
**common** forms of color blindness and/or color vision deficiency. Note
that for some specific forms, you may have to choose another palette
within viridis (for example
[seaborn](https://seaborn.pydata.org/tutorial/color_palettes.html), or
[turbo](https://ai.googleblog.com/2019/08/turbo-improved-rainbow-colormap-for.html)).

``` r
library(sccthemes)
library(gapminder)
library(dplyr)

asia_pop <- gapminder |> 
  filter(year == 1997 & continent == "Asia") |> 
  select(country, lifeExp, pop, gdpPercap) |> 
  top_n(5)

asia_pop$country <- forcats::fct_drop(asia_pop$country)

scc_piechart(
  asia_pop,
  asia_pop$gdpPercap,
  asia_pop$country,
  title = "GDP per Capita contribution percentage by county",
  subtitle = "Five largest countries only"
  )
```

<img src="man/figures/README-viridis_example-1.png" width="100%" />

## Future additions to this package

If there is a further need in the future, other styling options can be
added.

For example:

- [bslib](https://rstudio.github.io/bslib/) themes for Shiny, see this
  example from [UKCEH](https://github.com/NERC-CEH/UKCEH_shiny_theming).
- gt table themes
