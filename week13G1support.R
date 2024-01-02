augmentData = function(dd){
  library(dplyr)
  dd |>
    mutate(
      districtSegment = 
        paste0(district,"-",segment)
    ) -> data
  
  sg = data |> arrangeDistrictSegmentByDescOfficialValues()
  
  data |> 
    mutate(
      districtSegment = factor(
        districtSegment, levels=rev(sg)
      )
    ) -> data
  return(data)
}
arrangeDistrictSegmentByDescOfficialValues = function(data){
  data |> 
    group_by(district, segment, districtSegment) |>
    summarise(
      meanValue = official_value |> mean(na.rm=T)
    ) |>
    ungroup() |>
    group_by(district) |>
    arrange(desc(meanValue))  |>
    pull(districtSegment) ->
    districtSegment
  
  return(districtSegment)
}
createGitterSampleFrac = function(dd, size=0.1){
  dd |>
    group_by(districtSegment) |>
    dplyr::sample_frac(size=size) |>
    ungroup()
}
