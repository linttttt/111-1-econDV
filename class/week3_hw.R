#有權限問題
#googlesheets4::gs4_deauth()

googlesheets4::read_sheet(
  "https://docs.google.com/spreadsheets/d/1lkts4hLkrAFAobONFXiEjgDnuUmXKci6YF--vg1pC1s/edit?usp=sharing",
  sheet="data 3"
) -> data3
data3_split <- split(data3, data3$Country)

library(dplyr)
data3 |> 
  group_by(Characteristic) |> 
  summarise(
    maxMisery = max(`Total Effect`)
  ) |> 
  ungroup() -> data3Max

ggplot(
  mapping = aes(
    x = `Total Effect`,
    y = `Characteristic`,
    alpha = 0.5)
)+
  geom_segment(
    data = data3Max,
    mapping = aes(
      x = 0,
      y = `Characteristic`,
      xend = maxMisery,
      yend = `Characteristic`
    ),
    color = "grey",
    alpha = 0.8
  )+
  geom_point(
    data = data3_split$a,
    aes(size = `Population`),
    shape = 21,
    fill = "#f8c37e"
  )+
  geom_point(
    data = data3_split$b,
    aes(size = `Population`),
    shape = 21,
    fill = "#f1b28e"
  )+
  geom_point(
    data = data3_split$c,
    aes(size = `Population`),
    shape = 21,
    fill = "#90d8cc"
  )+
  geom_point(
    data = data3_split$d,
    aes(size = `Population`),
    shape = 21,
    fill = "#88a5c0"
  )+
  geom_point(
    data = data3,
    aes(
      size = `Population`,
      color = `Country`
    ),
    size = 0.5,
    alpha = 0.5
  )


ggplot(
  mapping = aes(
    x = `Total Effect`,
    y = `Characteristic`,
    alpha = 0.5)
)+
  geom_segment(
    data = data3Max,
    mapping = aes(
      x = 0,
      y = `Characteristic`,
      xend = maxMisery,
      yend = `Characteristic`
    ),
    color = "grey",
    alpha = 0.8
  )+
  geom_point(
    data = data3,
    aes(
      size = `Population`,
      fill = `Country`,
      color = `Country`),
    shape = 21,
    alpha = 0.5,
    stroke = 0.5
    
  )+
  geom_point(
    data = data3,
    aes(
      color = `Country`),
    shape = 20,
    size = 1,
  )





