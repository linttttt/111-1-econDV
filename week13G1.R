library(ggplot2)
library(dplyr)
library(lubridate)
if(!require(martinStyle2)) remotes::install_githu("tpemartin/martinStyle2")
data = readr::read_csv("https://github.com/Vincent23412/111-1-econDV/blob/main/%E6%96%B0%E5%8C%97%E5%B8%82%E5%9C%B0%E5%83%B9%E7%8F%BE%E5%80%BC.csv?raw=true")
source("./R/week13G1support.R")

data = augmentData(data)
dataGitter = createGitterSampleFrac(data) 

cl = martinStyle2::Colors()
cl$show$vanGoghStarNight()

plt = Plot()
plt$ggplot = ggplot(data=data, mapping= aes(x=districtSegment,y= official_value))

plt$geom <- geom_boxplot(
  outlier.shape = NA)
plt$geom2 <- geom_jitter(
  data = dataGitter,
  width = 0.1,
  alpha = 0.5,
  shape = 21,
  color = cl$vanGoghStarNight$night[[1]],
  fill = cl$vanGoghStarNight$night[[5]],
  stroke = 0.5
)
plt$scale = scale_x_discrete(
  labels = function(x) stringr::str_remove(x, "[\u4E00-\u9FFF]+-")
)

plt$grid <- facet_grid(
  rows = vars(district), 
  scales = "free_y"
)
plt$flip = coord_flip()
plt$make()
