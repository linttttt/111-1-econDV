#資料引入___https://github.com/linttttt/111-1-econDV/blob/main/week15_ageDR_data.R
#整理後資料___https://github.com/linttttt/111-1-econDV/blob/main/ageDependencyRatio_long.Rds

dataRatio_long <- readRDS(file = "./ageDependencyRatio_long.Rds")
pltAgeDR=Plot()
pltAgeDR$ggplot = ggplot(data = dataRatio_long)
pltAgeDR$geom = list(
  geom_line(
    aes(
      x = `年別`,
      y = ratio,
      color = `國別`,
      linetype = `線類型`,
    ),
    size = 1.2
  )
)

pltAgeDR$scale = list(
  scale_color_manual(
    name = "國家",
    limits = c("中華民國", "美國", "日本", "韓國", "德國"),
    values = c("#524C84", "#FFF9AF", "#D65D7A", "#92E6E6",
      "#d9d9d9"),
    na.value = "#d9d9d9",
    label = c("臺灣", "美國", "日本", "韓國", "歐洲\n國家")
  ),
  scale_linetype_manual(
    name = "數據",
    limits = c("real", "estimate"),
    values = c("solid", "11")
  )
)


pltAgeDR$others = list(
  scale_x_continuous(
    name = "",
    expand = c(0, 0),
    breaks = c(seq(1970, 2030, by=5)),
    labels = c("1970", "", "1980", "", "1990", "", "2000",
      "", "2010", "", "2020", "", "2030")
  ),
  scale_y_continuous(
    name = "比例",
    breaks = c(seq(10, 100, by=10)),
    labels = as.character(c(seq(10, 100, by=10)))
  ),
  guides(linetype = "none")
)

pltAgeDR$theme = list(
  theme(
    panel.grid.major.y = element_line(color="grey", size= 0.1),
    axis.title.y = element_text(angle = 0),
    axis.title.x = element_text(hjust = 1)
  )
)

pltAgeDR$explain = list(
  labs(
    title = "未來青壯年是否會擔起愈多責任？",
    subtitle = "註1: 虛線(2020年後)為中推估的估計資料(假設總生育率維持當前水準)\n註2: 扶養比 = 扶老比 + 扶幼比",
    caption = "資料來源：政府資料開放平臺\n   https://data.gov.tw/dataset/39500"
  )
)

pltAgeDR$make()+
  facet_wrap(
    vars(`比率類型`),
    strip.position = "top",
  )+
  theme(
    strip.background = element_blank(),
    strip.text = element_text(size = 12),
    panel.spacing.x = unit(1, "cm"),
    plot.title = element_text(size = 20 #input$title
    ),
    plot.subtitle = element_text(size= 10 #input$subtitle
    ),
    plot.caption = element_text(size=10 #input$caption
    )
  )
#econDV2::ggdash()