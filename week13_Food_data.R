#不符合食品資訊資料集
#https://data.gov.tw/dataset/6133
data8 <- readr::read_csv("https://data.fda.gov.tw/opendata/exportDataList.do?method=ExportData&InfoId=52&logType=2")
library(lubridate)
library(stringr)
library(magrittr)
options(scipen = 999)


event <- data.frame(
  country = unique(data8$產地),
  number = 0
)
for (i in seq_along(event[[1]])) {
  event$number[[i]] <- sum(data8$`產地`==event$country[[i]])
}

event %<>% dplyr::arrange(desc(number))

topInfoRank <- event[1:12,]

data8 |> 
  dplyr::filter(
    data8$`產地` %in% topInfoRank$country
  ) -> Top12Info
#View(Top12Info)


topInfoReason <- data.frame(
  reason = unique(Top12Info$`原因`),
  number = 0
)

for (i in seq_along(topInfoReason[[1]])) {
  topInfoReason$number[[i]] <- sum(
    Top12Info$`原因`==topInfoReason$reason[[i]]
  )
  
}
topInfoReason %<>% dplyr::arrange(number)


Top12Info$`產地` |> 
  factor(levels = topInfoRank$country
  ) -> Top12Info$`產地`
Top12Info$`原因` |> 
  factor(levels = topInfoReason$reason
  ) -> Top12Info$`原因`
