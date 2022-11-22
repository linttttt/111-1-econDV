library(dplyr)
library(magrittr)

#資料讀取
# dataCOVID <- readr::read_csv(
#   "https://od.cdc.gov.tw/eic/Age_County_Gender_19Cov.csv")

#資料整理
dataCOVID |> 
  dplyr::filter(
    stringr::str_detect(`是否為境外移入`, "否")
  ) |> 
  dplyr::filter(
    stringr::str_detect(
      `性別`, paste(c("M", "F"), collapse = "|")
      )
    )-> COVIDNational
COVIDNational[-c(1,5,7)] -> COVIDNational

COVIDNational |> 
  dplyr::mutate(
    `區域` = dplyr::case_when(
      `縣市` %in% c("新北市", "桃園市", "台北市","基隆市",
        "新竹市", "宜蘭縣", "新竹縣") ~ "北部",
      `縣市` %in% c("台中市", "南投縣", "彰化縣","苗栗縣",
        "雲林縣") ~ "中部",
      `縣市` %in% c("台南市", "屏東縣", "高雄市","嘉義市",
        "嘉義縣", "澎湖縣") ~ "南部",
      `縣市` %in% c("台東縣", "花蓮縣") ~ "東部",
      `縣市` %in% c("連江縣", "金門縣") ~ "離島"
    ),
    `區域_性別` = paste(`區域`,`性別`,sep = '_')
  ) -> COVIDNational

COVIDNationalSum <- NULL
for (i in c(2020:2022)) {
  for (j in c(1:12)) {
    if (i==2022 && j>9) break
    COVIDNational |>
      filter(COVIDNational$`發病月份`==j) |>
      group_by(`區域_性別`) |>
      summarise(
        yearPlusMonth = i*100+j,
        number = sum(
          as.numeric(`確定病例數`)),
        x = ((i-2020)*12+j)+0.5
      ) |>
      dplyr::ungroup() |>
      dplyr::bind_rows(COVIDNationalSum) |>
      dplyr::arrange(yearPlusMonth) -> COVIDNationalSum
    }
}
COVIDNationalSum |> 
  dplyr::mutate(
    yearPlusMonth = as.numeric(yearPlusMonth),
    y = dplyr::case_when(
      `區域_性別` == "北部_M" ~ 10.5,
      `區域_性別` == "北部_F" ~ 9.5,
      `區域_性別` == "中部_M" ~ 8.5,
      `區域_性別` == "中部_F" ~ 7.5,
      `區域_性別` == "南部_M" ~ 6.5,
      `區域_性別` == "南部_F" ~ 5.5,
      `區域_性別` == "東部_M" ~ 4.5,
      `區域_性別` == "東部_F" ~ 3.5,
      `區域_性別` == "離島_M" ~ 2.5,
      `區域_性別` == "離島_F" ~ 1.5
    )
  ) -> COVIDNationalSum

COVIDNationalSum$gender <- stringr::str_sub(
  COVIDNationalSum$`區域_性別`, start = 4)

# COVIDNationalSum$yearPlusMonth |>
#   factor() |>
#   levels()
# COVIDNationalSum$區域_性別 |>
#   factor() |>
#   levels()

#資料調整
newLv <- rev(c("北部_M", "北部_F", "北部_U", "北部_X", "中部_M", "中部_F", "中部_U", "中部_X", "南部_M", "南部_F", "南部_U", "南部_X", "東部_M", "東部_F", "東部_U", "東部_X", "離島_M", "離島_F", "離島_X"))

COVIDNationalSum$yearPlusMonth |> 
  factor() -> COVIDNationalSum$yearPlusMonth
COVIDNationalSum$區域_性別 |> 
  factor(levels = newLv) -> COVIDNationalSum$區域_性別

##分男(正數)and女(負數)人數
COVIDNationalSum$numberColor <- ifelse(
  COVIDNationalSum$gender=="M", 
  COVIDNationalSum$number, 
  COVIDNationalSum$number*(-1)
  )

COVIDNationalSum |> saveRDS(
  file = "./COVIDNationalSum.Rds")
COVIDNationalSum <- readRDS(file = "./COVIDNationalSum.Rds")
