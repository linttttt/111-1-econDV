#https://github.com/linttttt/111-1-econDV/blob/main/week13_Food_data.R
pltFood <- Plot()
pltFood$ggplot = ggplot()
pltFood$geom = list(
  geom_bar(
    data = Top12Info,
    aes(
      x = `產地`,
      fill = `原因`
    )
  ),
  geom_point(
    data = data.frame(x = 0, y = 700),
    aes(
      x = x,
      y = y
      ),
    size = 0.1
  ),
  geom_text(
    data = topInfoRank,
    aes(
      x = country,
      y = number+10,
      label = number
    )
  )
)

pltFood$scale = scale_fill_manual(
  limits = rev(topInfoReason$reason[30:33]), 
  values = c("#DD2C00", "#FF5722","#B2EBF2", "grey"),
  na.value = "grey",
  label = c(rev(topInfoReason$reason[31:33]), "其他")
)

pltFood$others = list(
  scale_y_continuous(
    name = "件數",
    expand = c(0, 0)
  )
)

pltFood$theme = list(
  theme(
    axis.title.y = element_text(angle = 0),
    axis.title.x = element_blank(),
    axis.text.x = element_text(
      angle = 30,
      hjust = 0.7,
      vjust = 1,
      size = 12
    ),
    axis.ticks.x = element_blank(),
    axis.ticks.y = element_blank(),
    panel.grid.major.y = element_line(
      color = "grey",
      size = 0.1
    )
  )
)

pltFood$explain = list(
  labs(
    title = "臺灣不合格進口食品及相關產品的來源地排名",
    subtitle = "註1: 統計時間(依發布日期): 2020/01/07~2022/12/06\n註2: 10~12名件數相同，故同登排名",
    caption = "資料來源：政府資料開放平臺\n https://data.gov.tw/dataset/6133"
  )
)


pltFood$make() + 
  coord_fixed(ratio = 1/60)+
  theme(
    plot.title = element_text(size = 20 #input$title
    ),
    plot.subtitle = element_text(size= 10 #input$subtitle
    ),
    plot.caption = element_text(size=10 #input$caption
    )
  )
#econDV2::ggdash()
