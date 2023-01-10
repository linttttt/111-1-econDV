#同學作品連結
#https://github.com/KinoCyan/111-1-econDV/blob/main/R_homework_w13_411073116.R
library(stringr)
library(magrittr)
library(tidyr)

getDataHA = function(){
  #Download data
  #https://happiness-report.s3.amazonaws.com/2022/Appendix_2_Data_for_Figure_2.1.xls
  dataHA <- readxl::read_xls("C:/Users/user/Downloads/Appendix_2_Data_for_Figure_2.1.xls")
  
  return(dataHA)
}
getDataHA_organized = function(dataHA){
  dataHA <- dataHA[, -c(4, 5)]
  dataHA$Country[c(26, 147)] <- c("Taiwan", "Average")
  
  for (i in c(3:10)) {
    dataHA[147, i] <- sum(dataHA[1:146, i])/length(dataHA$Country)
  }
  
  for (i in seq_along(dataHA[[1]])){
    dataHA$maxSort[[i]] <- names(
      which.max(dataHA[i,5:10]))
  }
  
  dataHA[c(1:20, 26, 147), ] |> 
    dplyr::mutate(
      area = c("北歐五國", "北歐五國", "北歐五國",
        "中歐", "西歐", "西歐", "北歐五國",
        "北歐五國", "西亞", "大洋洲", "	西歐",
        "大洋洲", "北歐", "西歐", "北美", "北美",
        "北歐", "東歐", "西歐", "西歐", "臺灣",
        "平均"
      )
    ) |>
    tidyr::pivot_longer(
      cols = 4:10,
      names_to = "scoreSorts",
      values_to = "sortValue"
    ) -> dataHA_long
  
  dataHA_long$Country |> 
    factor(
      levels = rev(unique(dataHA_long$Country))
    ) -> dataHA_long$Country
  
  dataHA_long$scoreSorts |> 
    factor(
      levels = rev(
        c(unique(dataHA_long$scoreSorts)[-1],
          unique(dataHA_long$scoreSorts)[[1]]
          )
        )
    ) -> dataHA_long$scoreSorts
  
  return(dataHA_long)
  
}
getPlot = function(dataHA_organized){
  pltHA = Plot()
  pltHA$ggplot = ggplot(data = dataHA_organized)
  pltHA$geom = list(
    geom_col(
      aes(
        x = Country,
        y = sortValue,
        fill = scoreSorts,
      ),
      position = "stack"
    ),
    geom_text(
      y=0.1,
      aes(
        x=Country,
        label = Country,
        color = area,
      ),
      
      hjust = 0,
      size = 5,
      fontface = "bold"
    )
  )
  return(pltHA)
}
plotScale = function(pltHA, dataHA_organized){
  pltHA$scale = list(
    scale_fill_manual(
      name = "細項分類",
      limits = c(
        unique(dataHA_organized$scoreSorts)[-1],
        unique(dataHA_organized$scoreSorts)[[1]]
      ),
      values = c("#86f9d5", "#ffab71", "#acd4ff",
        "#ffa0ef", "#d5ff6f", "#ffff40", "grey"),
      labels = c("GDP per capita", "Social support",
        "Healthy life expectancy",
        "Freedom to make life choices",
        "Generosity", "Perceptions of corruption",
        "Dystopia (1.83) + residual")
    ),
    scale_color_manual(
      name = "",
      limits = c("北歐五國", "臺灣", "平均"),
      values = c("#540099","#900048","#ff5f33"),
      na.value = "#ffffff"
    )
  )
  
  pltHA$others = list(
    scale_y_continuous(
      name = "分數",
      expand = c(0, 0)
    ),
    scale_x_discrete(
      name = "排名",
      labels = list("", 26, 20:1)
    )
  )
  return(pltHA)
}
plotTitle = function(pltHA){
  pltHA$theme = list(
    theme(
      axis.text.y = element_text(hjust = 1),
      axis.title.y = element_text(
        angle = 0, vjust = 1
        ),
      axis.ticks.y = element_blank(),
      axis.title.x = element_text(hjust = 0.5)
    )
  )
  
  pltHA$explain = list(
    labs(
      title = "2022世界幸福分數細項累積",
      subtitle = "註: 細項以世界平均的六項主要指標(不包含Dystopia (1.83) + residual)大小排序",
      caption = "資料來源：World Happiness Report\nhttps://worldhappiness.report/ed/2022/#appendices-and-data"
    )
  )
  return(pltHA)
}

dataHA <- getDataHA()
dataHA_organized <- getDataHA_organized(dataHA)
pltHA <- getPlot(dataHA_organized)
pltHA <- plotScale(pltHA, dataHA_organized)
pltHA <- plotTitle(pltHA)

# pltHA$make()+
#   coord_flip()+
#   theme(
#     plot.title = element_text(size = 30 #input$title
#     ),
#     plot.subtitle = element_text(size= 10 #input$subtitle
#     ),
#     plot.caption = element_text(size=10 #input$caption
#     )
#   )
