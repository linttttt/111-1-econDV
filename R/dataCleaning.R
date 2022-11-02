correctClass = function(marriageTaoYuan){
  # the input is a data frame
  marriageTaoYuan$female_age_or_spouse1 |>
    factor() |>
    levels() -> defaultLevels
  lastIndex = length(defaultLevels)
  
  c(
    defaultLevels[[lastIndex]], # "未滿15歲",
    defaultLevels[-lastIndex]
  ) -> correctLevels
  
  marriageTaoYuan$female_age_or_spouse1 |>
    factor(
      levels=correctLevels
    ) -> marriageTaoYuan$female_age_or_spouse1
  
  marriageTaoYuan$marry_pair |> 
    as.integer() -> marriageTaoYuan$marry_pair
  
  marriageTaoYuan # output is a data frame
}

prepareLateMarriageData = function(marriageTaoYuan){
# input is a data frame  
  
  allLevels = levels(marriageTaoYuan$female_age_or_spouse1)
  lateMarriageLevels = allLevels[-c(1:16)]
  marriageTaoYuan |>
    # 計算每個(group_by)次行政區，有多少晚婚(filter)對數(summarise)
    dplyr::filter(
      female_age_or_spouse1 %in% lateMarriageLevels
    ) |>
    group_by(site_id2) |>
    summarise(
      late_marry_pair = sum(marry_pair)
    ) -> marriageTaoYuanLate
  
  marriageTaoYuan |>
    group_by(site_id2) |>
    summarise(
      total_marry_pair = sum(marry_pair)
    ) -> marriageTaoYuanTotal
  
  marriageTaoYuanLate
  marriageTaoYuanTotal
  
  marriageTaoYuanLate |> 
    left_join(marriageTaoYuanTotal,
      by=c("site_id2")) -> 
    marriageTaoYuanLate
  marriageTaoYuanLate |>
    mutate(
      prop_marry_pair_late = 
        late_marry_pair/total_marry_pair
    ) -> marriageTaoYuanLate
  marriageTaoYuanLate # output is a dataframe
}
