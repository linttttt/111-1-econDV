
cleanData = function(marriageTaoYuan){
  marriageTaoYuan |>
    mutate(
      marry_pair = as.integer(marry_pair)
    ) -> marriageTaoYuan
  
  marriageTaoYuan$female_age_or_spouse1 |>
    factor() |>
    levels() -> defaultLevels
  
  lastIndex = length(defaultLevels)
  currectLevels = c(
    defaultLevels[[lastIndex]],
    defaultLevels[-lastIndex])
  
  marriageTaoYuan$female_age_or_spouse1 =
    factor(
      marriageTaoYuan$female_age_or_spouse1,
      levels=currectLevels
    )
  
  return(marriageTaoYuan)
}
