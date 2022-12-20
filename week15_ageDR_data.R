library(stringr)
library(magrittr)
library(openxlsx)
#主要國家扶養比
#https://data.gov.tw/dataset/39500
data20 <- readr::read_csv("https://ws.ndc.gov.tw/001/administrator/10/relfile/0/13729/23eadb48-741f-4656-a19e-c837ee20c326.csv")
#世界銀行資料https://data.worldbank.org/indicator/SP.POP.DPND
ageDependencyRatio <- readr::read_csv("C:/Users/user/Downloads/ageDependencyRatio.csv")
ageDependencyRatio_old <- readr::read_csv("C:/Users/user/Downloads/ageDependencyRatio_old.csv")
ageDependencyRatio_young <- readr::read_csv("C:/Users/user/Downloads/ageDependencyRatio_young.csv")
countryName <- read.xlsx("C:/Users/user/Downloads/countryName.xlsx", sheet = "Sheet1")

ageDependencyRatio %<>%
  dplyr::filter(`Country Code`%in%c("GBR","USA"))
ageDependencyRatio_old %<>%
  dplyr::filter(`Country Code`%in%c("GBR","USA"))
ageDependencyRatio_young %<>%
  dplyr::filter(`Country Code`%in%c("GBR","USA"))
ageDependencyRatio <- ageDependencyRatio[c(1, 2, 4, 15, 20)]
ageDependencyRatio_old <- ageDependencyRatio_old[c(1, 2, 4, 15, 20)]
ageDependencyRatio_young <- ageDependencyRatio_young[c(1, 2, 4, 15, 20)]
ageDependencyRatio_USUK <- dplyr::bind_rows(
  ageDependencyRatio,
  ageDependencyRatio_young,
  ageDependencyRatio_old)
ageDependencyRatio_USUK |> 
  tidyr::pivot_longer(
    cols = 4:5,
    names_to = "year",
    values_to = "ratio"
  ) |> 
  tidyr::pivot_wider(
    names_from = `Indicator Code`,
    values_from = ratio
  ) |> 
  dplyr::mutate(
    `國家` = ifelse(
      `Country Code`=="USA", "美國", "英國"
    )
  ) -> ageDependencyRatio_USUK

dataRatio <- data20[-which(data20$`年別`>2030),]
dataRatio <- dataRatio[-c(7, 8)]
dataRatio[which((dataRatio$國別=="美國")&(dataRatio$年別==1970)),c(4:6)] <- round(ageDependencyRatio_USUK[3,c(4:6)],2)
dataRatio[which((dataRatio$國別=="美國")&(dataRatio$年別==1975)),c(4:6)] <- round(ageDependencyRatio_USUK[4,c(4:6)],2)
dataRatio[which((dataRatio$國別=="英國")&(dataRatio$年別==1970)),c(4:6)] <- round(ageDependencyRatio_USUK[1,c(4:6)],2)

dataRatio |> 
  dplyr::filter(
    `年別` == 2020
  ) -> Temp
Temp$類別 <- "中推估"
dataRatio |> 
  dplyr::bind_rows(Temp) |> 
  dplyr::arrange(`國別`, `年別`) |> 
  dplyr::mutate(
    `線類型` = dplyr::case_when(
      `類別` == "實際" ~ "real",
      `類別` == "中推估" ~ "estimate"
    )
  ) -> dataRatio

nlvs <- c("荷蘭", "奧地利", "瑞典", "義大利", "芬蘭",
  "英國","挪威","西班牙","法國", "德國", "美國",
  "韓國", "日本", "中華民國")
dataRatio$`國別` |> 
  factor(levels = nlvs) ->dataRatio$`國別`

dataRatio |> 
  tidyr::pivot_longer(
    cols = 4:6,
    names_to = "比率類型",
    values_to = "ratio"
  ) -> dataRatio_long

dataRatio_long |> saveRDS(file = "./ageDependencyRatio_long.Rds")
