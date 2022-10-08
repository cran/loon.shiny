## ---- include = FALSE---------------------------------------------------------
library(knitr)
library(grid)
library(gridExtra)
knitr::opts_chunk$set(echo = TRUE)
imageDirectory <- "./img/introduction"
dataDirectory <- "./data"
path_concat <- function(path1, path2, sep="/") {paste(path1, path2, sep = sep)}
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----library_loon_shiny, eval = TRUE, echo = TRUE, fig.align="center", fig.width = 6, fig.height = 4, out.width = "75%", warning=FALSE, message=FALSE----
library(loon.shiny)

## ---- iris basic, eval = FALSE, echo = TRUE, fig.align="center", warning=FALSE, message=FALSE----
#  library(loon.shiny)
#  library(dplyr)
#  library(magrittr)
#  # Loon scatterplot
#  p <- with(iris,
#    l_plot(x = Petal.Width,
#           y = Sepal.Width,
#           color = Species)
#  )
#  # Modify glyph to radial axes glyph.
#  p['glyph'] <- l_glyph_add_serialaxes(p, data = iris)
#  # Fit a linear regression on each group (species)
#  for(s in unique(iris$Species)) {
#    # sub data set
#    subdata <- iris %>%
#      filter(Species == s)
#    # fitted line
#    fit <- lm(Sepal.Width ~ Petal.Width, data = subdata)
#    x <- subdata$Petal.Width
#    pred <- predict(fit, interval = "confidence")
#    ord <- order(x)
#    # Loon pipe model (connected with %T>%)
#    # Check ```help(`%T>%`)``` for more details
#    p <- p %T>%
#      # fitted line
#      l_layer_line(x = x[ord],
#                   y = pred[, "fit"][ord],
#                   color = "firebrick",
#                   linewidth = 1.5,
#                   index = "end") %T>%
#      # confidence interval
#      l_layer_line(x = c(x[ord], rev(x[ord]), x[ord][1]),
#                   y = c(pred[, "lwr"][ord], rev(pred[, "upr"][ord]), pred[, "lwr"][ord][1]),
#                   color = "grey50",
#                   linewidth = 2,
#                   index = "end")
#  }
#  loon.shiny(p, plotRegionWidth = "400px")

## ----shiny basic, echo = FALSE, message = FALSE, warning = FALSE, fig.width = 5, fig.height = 4, fig.align = "center", out.width = "80%"----
include_graphics(path_concat(imageDirectory, "loon_shiny_scatterplot.PNG"))

## ----inspector, echo = FALSE, message = FALSE, warning = FALSE, fig.width = 2, fig.height = 2, fig.show = "hold", out.width = "30%", fig.align = "center"----
include_graphics(path_concat(imageDirectory, "inspector_analysis.PNG"))

## ----plot panel, echo = FALSE, message = FALSE, warning = FALSE, fig.width = 2, fig.height = 2, fig.align = "center", out.width = "30%"----
include_graphics(path_concat(imageDirectory, "plot_panel.PNG"))

## ----select panel, echo = FALSE, message = FALSE, warning = FALSE, fig.width = 2, fig.height = 2, fig.align = "center", out.width = "30%"----
include_graphics(path_concat(imageDirectory, "select_panel.PNG"))

## ----modify panel, echo = FALSE, message = FALSE, warning = FALSE, fig.width = 2, fig.height = 2, fig.align = "center", out.width = "30%"----
include_graphics(path_concat(imageDirectory, "modify_panel.PNG"))

## ----layer panel, echo = FALSE, message = FALSE, warning = FALSE, fig.width = 2, fig.height = 2, fig.align = "center", out.width = "30%"----
include_graphics(path_concat(imageDirectory, "layer_panel.PNG"))

## ----glyph panel, echo = FALSE, message = FALSE, warning = FALSE, fig.width = 2, fig.height = 2, fig.align = "center", out.width = "30%"----
include_graphics(path_concat(imageDirectory, "glyph_panel.PNG"))

## ----linking, eval = FALSE, echo = TRUE, fig.align="center", warning=FALSE, message=FALSE----
#  p1 <- l_plot(iris, linkingGroup = "iris",
#               showLabels = FALSE)
#  p2 <- l_hist(iris$Sepal.Length, linkingGroup = "iris",
#               showLabels = FALSE,
#               showStackedColors = TRUE)
#  p3 <- l_hist(iris$Sepal.Width, color = iris$Species,
#               linkingGroup = "iris",
#               showLabels = FALSE,  swapAxes = TRUE,
#               showStackedColors = TRUE)
#  loon.shiny(list(p1, p2, p3),
#             layout_matrix = matrix(c(2,NA,1,3), nrow = 2, byrow = TRUE),
#             plotRegionWidth = "400px")

## ----compound_plot, echo = FALSE, message = FALSE, warning = FALSE, fig.width = 2, fig.height = 2, fig.align = "center", out.width = "80%"----
include_graphics(path_concat(imageDirectory, "compound_plot.PNG"))

## ----linking panel, echo = FALSE, message = FALSE, warning = FALSE, fig.width = 2, fig.height = 2, fig.align = "center", out.width = "30%"----
include_graphics(path_concat(imageDirectory, "linking_panel.PNG"))

