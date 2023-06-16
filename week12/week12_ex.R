ubikeData <-
jsonlite::fromJSON("https://tcgbusfs.blob.core.windows.net/dotapp/youbike/v2/youbike_immediate.json")


names(ubikeData) <-
c("sno(站點代號)", "sna(場站中文名稱)", "tot(場站總停車格)", "sbi(場站目前車輛數量)", "sarea(場站區域)", "mday(資料更新時間)", "lat", "lng", "ar(地點)", "sareaen(場站區域英文)", "snaen(場站名稱英文)", "aren(地址英文)", "bemp(空位數量)", "act(全站禁用狀態)", "srcUpdateTime", "updateTime", "infoTime", "infoDate")

ubikeData |>
  dplyr::select("sna(場站中文名稱)", "tot(場站總停車格)", "sbi(場站目前車輛數量)", "bemp(空位數量)") -> bikeData
DT::datatable(
  bikeData,
  escape = F,
  elementId = "chart1",
  fillContainer = T,
  style = "bootstrap",
  class = "table-hover",
  callback = DT::JS("dt = table;"),
  options = list(
    dom = "t",
    autoWidth = TRUE,
    pageLength = 2000,
    columns = list(orderable=F)
  )
) -> chart1
saveRDS(chart1, file = "chart1.Rds")


library(leaflet)
Map <- leaflet(data = ubikeData) |>
  addProviderTiles(providers$Jawg.Sunny) |>
  addMarkers(
    lng = ~lng, lat = ~lat,
    clusterOptions = markerClusterOptions()
    )
Map <- leaflet(data = ubikeData) |>
  addTiles() |>
  addMarkers(
    lng = ~lng, lat = ~lat,
    clusterOptions = markerClusterOptions()
  )
Map
saveRDS(Map, file = "chart2.Rds")

