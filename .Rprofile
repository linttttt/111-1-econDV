library(ggplot2)
library(showtext)
library(econDV2)
sysfonts::font_add_google("Noto Sans TC")
showtext_auto()
theme_set(theme(text = element_text(family = "Noto Sans TC")) +
  theme_classic())
ggenv = new.env()
ggenv$gg <- list(dash = econDV2::ggdash, geom = econDV2::ggbrowse,
aes = econDV2::ggaes)
attach(ggenv)
gg <- list(dash = econDV2::ggdash, geom = econDV2::ggbrowse,
aes = econDV2::ggaes)

econDV2::attachPlot()



library(dplyr)
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
