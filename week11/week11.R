#bigMacData = readRDS("../week10/bigMacData.Rds")
#chartB = readRDS("../week10/chartB.Rds")
bigMacData = readRDS("./bigMacData.Rds")
chartB = readRDS("./chartB.Rds")
# helper functions
source("./R/helpers.R")

# chartB----
chartB$dropdownMenu = dropdownMenu(names(bigMacData$splitByDate),
                                   id = "plotly-select",
                                   label = "Show index at",
                                   selectedDate = "2022-07-01")

#saveRDS(chartB, file="chartB.Rds")

dataComponent = chartB$allYears$`2000-04-01`$data

getTraceMapping <- function(dataComponent) {
  traceNumbers = seq_along(dataComponent)
  traceNumbers |>
      purrr::map(~{
      dataComponent[[.x]]$name
    }) -> traceNames
  traceNumbers |> as.list() |> setNames(traceNames) -> traceMapping
  traceMapping
}

chartB$allYears$`2000-04-01`$data[[11]]$name

saveRDS(chartB, file="chartB.Rds")
