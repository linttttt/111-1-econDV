library(ggplot2)
library(showtext)
library(econDV2)
# add google font: Noto Sans TC for chinese characters
sysfonts::font_add_google('Noto Sans TC')
# turn on showing chinese text in graph device
showtext_auto()
# set our graph theme to use the google font and a classic white back ground
theme_set(
  theme(
    text=element_text(family = "Noto Sans TC")
  )+
    theme_classic()
)
# some handy tool to use later through out the class
ggenv=new.env()
ggenv$gg <- list(
  dash = econDV2::ggdash,
  geom = econDV2::ggbrowse,
  aes = econDV2::ggaes
)
attach(ggenv)


Sys.setenv(CLIPR_ALLOW=TRUE)


# library(ggplot2)
# library(showtext)
# library(econDV2)
# sysfonts::font_add_google("Noto Sans TC")
# showtext_auto()
# theme_set(theme(text = element_text(family = "Noto Sans TC")) +
#   theme_classic())
# ggenv = new.env()
# ggenv$gg <- list(dash = econDV2::ggdash, geom = econDV2::ggbrowse,
# aes = econDV2::ggaes)
# attach(ggenv)
# gg <- list(dash = econDV2::ggdash, geom = econDV2::ggbrowse,
# aes = econDV2::ggaes)
# 
# econDV2::attachPlot()
# 
# 
# 
# library(dplyr)
# 
# Plot <- function(data) {
#   plot <- list(
#     data = data,
#     ggplot = NULL,
#     geoms = NULL,
#     make = function() {
#       plot$ggplot + plot$geoms
#     },
#     save = function() {
#       saveRDS(plot, filename)
#       message(paste("The plot is saved at ", filename))
#     }
#   )
#   return(plot)
# }
# 
# myTools = new.env()
# myTools$Plot <- Plot
# attach(myTools)
