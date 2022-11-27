COVIDNationalSum <- readRDS(file = "./COVIDNationalSum.Rds")

pltCOVID=Plot()
pltCOVID$ggplot = ggplot(data = COVIDNationalSum)
pltCOVID$geoms = list(
  geom_tile(
    aes(
      x = as.numeric(yearPlusMonth),
      y = `區域_性別`,
      fill = numberColor
    ),
    width = 1,
    height = 1
  ),
  geom_vline(
    aes(xintercept = x),
    color = "white",
    size = 0.1
  ),
  geom_hline(
    aes(yintercept = y),
    color = "white",
    size = 0.1
  )
)

maxMale <- max(COVIDNationalSum$numberColor)
maxFemale <- min(COVIDNationalSum$numberColor)

pltCOVID$scale = scale_fill_gradient2(
  name = "男女人數",
  low = "#00bbcc",
  mid = "#d6dff5",#ebeffa
  high = "#6304C8",
  na.value = "grey",
  breaks = c(maxMale, maxMale, 0, maxFemale, maxFemale),
  labels = c(paste("最大值:", maxMale), "\n男(M)",
    "0", paste("最大值:", maxFemale*(-1)), "\n女(F)"
    )
  )

pltCOVID$others = list(
  scale_y_discrete(
    expand = c(0, 0)
  ),
  scale_x_continuous(
    expand = c(0, 0),
    breaks = c(seq(1,31, by=6), 33),
    labels = c(
      "2020/01", "2020/07",
      "2021/01", "2021/07",
      "2022/01", "", "2022/09"),
    name = NULL,
    sec.axis = dup_axis()
  )
)

pltCOVID$theme = list(
  theme(
    legend.position = "bottom",
    axis.title.y = element_text(angle = 0),
    axis.line.x = element_line(color="#666666"),
    axis.line.y = element_blank(),
    axis.ticks.x = element_line(color="#666666"),
    axis.ticks.y = element_blank(),
    axis.ticks.length.y = unit(-1, "cm")
    ),
  guides(
    fill = guide_colorbar(
      label.position = "bottom",
      title.position = "top",
      title.hjust = 0.5,
      barwidth = 10)
  )
)

pltCOVID$explain = list(
  labs(
    title = "台灣境內各地區COVID-19傳染病人數",
    subtitle = "註1:去除性別未定(U﹑X)\n註2:空白區域為無確診資料",
    caption = "資料來源：政府資料開放平臺\n https://data.gov.tw/dataset/118039"
  )
)

pltCOVID$make()+
  theme(
    plot.title = element_text(size = 20 #input$title
    ),
    plot.subtitle = element_text(size= 10 #input$subtitle
    ),
    plot.caption = element_text(size=10 #input$caption
    )
  )

#可互動化
pltCOVID$make() |> plotly::ggplotly()

#econDV2::ggdash()
