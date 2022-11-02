data0 = data.frame(
  x = c(1, 2, 3, 4),
  y = c(2, 3, 6, 7),
  alpha_stroke = c(1, 2, 1, 2)
)

ggplot(
  data = data0,
  mapping = aes(
    x = x,
    y = y)
)+
  geom_point(
    mapping = aes(
      stroke = alpha_stroke,
      alpha = alpha_stroke),
    fill = "blue",
    color = "black",
    size = 5,
    shape = 21
  )

data2 = data.frame(
  x = c(1, 2, 3, 4),
  y = c(2, 3, 6, 7),
  alpha_stroke = c("A", "B", "A", "B")
)
dataSplit <- split(data2, data2$alpha_stroke)
dataSplit
#data cleaning / manipulation
ggplot()+
  geom_point(
    data = dataSplit$A,
    aes(
      x = x,
      y = y
    ),
    alpha = 0.5,
    color = "blue",
    size = 3
  )+
  geom_point(
    data = dataSplit$B,
    aes(
      x = x,
      y = y
    ),
    shape = 21,
    size = 3,
    fill = "blue",
    color = "black"
    
  )
# google sheets
googlesheets4::read_sheet(
  "https://docs.google.com/spreadsheets/d/1lkts4hLkrAFAobONFXiEjgDnuUmXKci6YF--vg1pC1s/edit?usp=sharing",
  sheet="data 1"
) -> data1
ggplot(
  data = data1
)+
  geom_line(
    mapping = aes(
      x = Time,
      y = Index1
    ),
    color = "black"
  )+
  geom_line(
    mapping = aes(
      x = Time,
      y = Index2
    ),
    color = "red"
  )+
  geom_line(
    mapping = aes(
      x = Time,
      y = Index3
    ),
    color = "blue"
  )



library(tidyr)
# pivot wide data to long data
tidyr::pivot_longer(
  data = data1,
  cols = 2:4,
  #col name what
  names_to = "IndexName",
  values_to = "IndexValue"
) -> data1_long

ggplot(
  data=data1_long
)+
  geom_line(
    aes(
      x=Time,
      y=IndexValue,
      color=IndexName
    )
  )

tidyr::pivot_wider(
  data = data1_long,
  names_from = "IndexName",
  values_from = "IndexValue"
) -> data1_wide




