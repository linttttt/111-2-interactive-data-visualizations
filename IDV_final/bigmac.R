bigMacData <- readRDS("./bigMacData.Rds")
chartC <- readRDS("./chartC.Rds")
chartB <- readRDS("./chartB.Rds")
source("R/helpers.R")
# data ----

bigMacData$allYearsWithNA |>
  split(~date) -> bigMacData$splitByDate

correctNameLevels <- function(DFwhole) {
  DFwhole$USD |>
    is.na() |>
    which() -> USDnaRows
  DFwhole[-USDnaRows, ] -> DFwhole

  DFwhole |>
    dplyr::arrange(USD) |>
    dplyr::pull(name) -> nameLevels
  DFwhole$name <- factor(DFwhole$name, levels = nameLevels)

  return(DFwhole)
}
bigMacData$splitByDate |>
  purrr::map(correctNameLevels) |>
  setNames(names(bigMacData$splitByDate)) -> bigMacData$splitByDate

bigMacData$splitByDate |>
  purrr::map(
    ~ {
      list(
        USDpos = .x |> dplyr::filter(USD >= 0),
        USDneg = .x |> dplyr::filter(USD < 0)
      )
    }
  ) |>
  setNames(names(bigMacData$splitByDate)) -> bigMacData$USDPosNegSplitByDate

## Dropdown menu -----
dropdownMenu <- function(nameList, id, label) {
  createOptions <- function(.x) {
    htmltools::tags$option(.x)
  }
  nameList |>
    purrr::map(createOptions) -> listOptions

  library(htmltools)
  div(
    class = "form-group",
    tags$label(
      `for` = "exampleSelect2", class = "form-label mt-4",
      label
    ),
    tags$select(
      class = "form-select", id = id,
      listOptions
    )
  )
}
{
  bigMacData$splitByDate |>
    names() |>
    dropdownMenu(id = "plotly-select", label = "Show index at") -> chartB$dropdownMenu
}


saveRDS(bigMacData, file = "bigMacData.Rds")
# Chart A ----
## datatable ----
chartA <- list()
{
  bigMacData$oneYear |>
    dplyr::arrange(desc(USD)) |>
    dplyr::select(name, USD) |>
    dplyr::mutate(graph="") |>
    dplyr::select(name, graph, USD)-> dfOneYear
  DT::datatable(
    dfOneYear,
    escape = F,
    elementId = "chartA",
    fillContainer = T,
    style = "bootstrap",
    class = "table-hover",
    # autoHideNavigation =TRUE,
    callback = DT::JS("dt = table;"),
    options = list(
      dom = "t",
      autoWidth = TRUE,
      pageLength = 100,
      columns = list(orderable=F)
    )
  ) -> chartA$tb0
chartA$tb0
}
## area graph -------
{
bigMacData$allYearsWithNA |> split(~name) -> dfSplitByCountries
bigMacData$splideByCountries <- bigMacData$splideByCountries

bigMacData$splideByCountries$Argentina |>
  plotArea() -> bb
bb

bigMacData$splideByCountries |>
  purrr::map(
    ~{
      .x |> plotArea() -> bb
      bb$x$data
    }
  ) -> chartA$plotlyTemplate$data
}
## static svg ------
{
  bb |>
    plotly::api_create(filename="svgTemplate", fileopt="overwrite")

  plotly::api_download_plot(id="350", username="tpemartin") -> template

  template |>
    plotly::config(
      displayModebar=F,
      staticPlot=TRUE
    ) -> template

  bb$x$layout <- template$x$layout
  bb$x$config <- template$x$config
  bb

  plotly::api_download_plot(id="344", username = "tpemartin") -> pp2

  pp2 |>
    config(displayModeBar=F, staticPlot=TRUE) |>
    plotly::style(hoverinfo="none") -> pp2

  pp2 |> plotly::plotly_build() -> bb2

  bb2$x$layout$yaxis$range <- NULL
  bb2$x$layout$yaxis$autorange <- TRUE

  chartA$plotlyTemplate$layout <- bb2$x$layout
  chartA$plotlyTemplate$config <- bb2$x$config
}


saveRDS(chartA, file = "chartA.Rds")

# Chart B ----
library(plotly)

## highlight -------
getDataLayoutConfig <- function(bigMacData, date, chartB) {
  bigMacData$splitByDate[[date]] -> DFwhole

  bigMacData$USDPosNegSplitByDate[[date]]$USDpos -> DFpos
  bigMacData$USDPosNegSplitByDate[[date]]$USDneg -> DFneg

  plot_ly() |>
    add_segments(
      data = DFwhole,
      x = ~name, xend = ~name,
      y = 0, yend = ~USD,
      type = "scattergl"
    ) |>
    add_trace(
      data = DFneg |> plotly::highlight_key(~name, group = "bigMac2"),
      x = ~name,
      y = ~USD,
      text = ~name,
      split = ~name,
      name = ~name,
      # x = chartB$traces[[2]]$x,
      # y = chartB$traces[[2]]$y,
      # text = chartB$traces[[2]]$text,
      type = chartB$traces[[2]]$type,
      mode = chartB$traces[[2]]$mode,
      marker = # chartB$traces[[2]]$marker,
        list(
          autocolorscale = chartB$traces[[2]]$marker$autocolorscale,
          color = chartB$traces[[2]]$marker$color,
          opacity = chartB$traces[[2]]$marker$opacity,
          size = 8, # chartB$traces[[2]]$marker$size,
          symbol = chartB$traces[[2]]$marker$symbol,
          line = # chartB$traces[[2]]$marker$line
            list(
              width = 0 # chartB$traces[[2]]$marker$line$width,
              # color = chartB$traces[[2]]$marker$line$color
            )
        ),
      hoveron = chartB$traces[[2]]$hoveron,
      name = chartB$traces[[2]]$name,
      legendgroup = chartB$traces[[2]]$legendgroup,
      showlegend = chartB$traces[[2]]$showlegend,
      # xaxis = chartB$traces[[2]]$xaxis,
      yaxis = chartB$traces[[2]]$yaxis,
      hoverinfo = chartB$traces[[2]]$hoverinfo
    ) |>
    add_trace(
      data = DFpos |> plotly::highlight_key(~name, group = "bigMac2"),
      x = ~name,
      y = ~USD,
      text = ~name,
      split = ~name,
      name = ~name,
      # x = chartB$traces[[3]]$x,
      # y = chartB$traces[[3]]$y,
      # text = chartB$traces[[3]]$text,
      type = chartB$traces[[3]]$type,
      mode = chartB$traces[[3]]$mode,
      # marker = chartB$traces[[3]]$marker,
      marker = # chartB$traces[[3]]$marker,
        list(
          autocolorscale = chartB$traces[[3]]$marker$autocolorscale,
          color = chartB$traces[[3]]$marker$color,
          opacity = chartB$traces[[3]]$marker$opacity,
          size = 8, # chartB$traces[[3]]$marker$size,
          symbol = chartB$traces[[3]]$marker$symbol,
          line = # chartB$traces[[3]]$marker$line
            list(
              width = 0 # chartB$traces[[3]]$marker$line$width,
              # color = chartB$traces[[3]]$marker$line$color
            )
        ),
      hoveron = chartB$traces[[3]]$hoveron,
      name = chartB$traces[[3]]$name,
      legendgroup = chartB$traces[[3]]$legendgroup,
      showlegend = chartB$traces[[3]]$showlegend,
      xaxis = chartB$traces[[3]]$xaxis,
      yaxis = chartB$traces[[3]]$yaxis,
      hoverinfo = chartB$traces[[3]]$hoverinfo
    ) |>
    # layout(
    #   yaxis=list(
    #     fixedrange=T, # stop y being zoomable.
    #     range=list(-0.7,0.5) # set fixed range even after each filter re-drawals.
    #   )
    # ) |>
    hide_legend() |>
    config(displayModeBar = F) |>
    highlight(
      on = "plotly_hover",
      opacityDim = 1,
      color = "#a2b0b9"
    ) -> p0
  p0

  ## build ----

  p0 |> plotly::plotly_build() -> buildP0
  buildP0$x[c("data", "layout", "config")]
}
{
  names(bigMacData$splitByDate) |>
    purrr::map(~ {
      getDataLayoutConfig(bigMacData, .x, chartB)
    }) |>
    setNames(names(bigMacData$splitByDate)) -> chartB$allYears


  chartB$allYears$`2000-04-01`
}

saveRDS(chartB, file = "chartB.Rds")

# ChartC -----------

## highlight ----
#### use scatterGL -------
{
  bigMac2 <- readRDS("./bigMac2.Rds")
  traces <- bigMac2$traces

  traces[[1]]$marker$opacity <- 0.3
  traces[[2]]$marker$opacity <- 0.3
  plot_ly() |>
    add_trace(
      data = bigMacData$allYearsWithNAUSDNeg,
      x = ~date,
      y = ~USD,
      # x = traces[[1]]$x,
      # y = traces[[1]]$y,
      # text = traces[[1]]$text,
      type = "scattergl", # traces[[1]]$type,
      mode = traces[[1]]$mode,
      marker = traces[[1]]$marker,
      # hoveron = traces[[1]]$hoveron,
      name = traces[[1]]$name,
      legendgroup = traces[[1]]$legendgroup,
      showlegend = traces[[1]]$showlegend,
      xaxis = traces[[1]]$xaxis,
      yaxis = traces[[1]]$yaxis,
      hoverinfo = traces[[1]]$hoverinfo,
      frame = traces[[1]]$frame
    ) |> # plotly_build() |> View()
    add_trace(
      data = bigMacData$allYearsWithNAUSDPos,
      x = ~date,
      y = ~USD,
      # x = traces[[2]]$x,
      # y = traces[[2]]$y,
      # text = traces[[2]]$text,
      type = "scattergl", # traces[[2]]$type,
      mode = traces[[2]]$mode,
      marker = traces[[2]]$marker,
      # hoveron = traces[[2]]$hoveron,
      name = traces[[2]]$name,
      legendgroup = traces[[2]]$legendgroup,
      showlegend = traces[[2]]$showlegend,
      xaxis = traces[[2]]$xaxis,
      yaxis = traces[[2]]$yaxis,
      hoverinfo = traces[[2]]$hoverinfo,
      frame = traces[[2]]$frame
    ) |>
    add_trace(
      data = bigMacData$allYearsWithNA |> plotly::highlight_key(~name, group = "bigMac"),
      x = ~date,
      y = ~USD,
      split = ~name,
      text = ~name,
      name = ~name,
      # x = traces[[4]]$x,
      # y = traces[[4]]$y,
      # text = traces[[4]]$text,
      type = traces[[4]]$type,
      mode = traces[[4]]$mode,
      line = traces[[4]]$line,
      hoveron = traces[[4]]$hoveron,
      showlegend = traces[[4]]$showlegend,
      xaxis = traces[[4]]$xaxis,
      yaxis = traces[[4]]$yaxis,
      hoverinfo = traces[[4]]$hoverinfo,
      frame = traces[[4]]$frame
    ) |>
    layout(
      yaxis = list(
        # fixedrange=T, # stop y being zoomable.
        range = list(-1, 2) # set fixed range even after each filter re-drawals.
      ),
      xaxis = list(
        range = list(lubridate::ymd("2000-04-01"), lubridate::ymd("2022-07-01"))
      )
    ) |>
    hide_legend() |>
    config(displayModeBar = F) |>
    highlight(
      on = "plotly_hover",
      opacityDim = 1,
      color = "#a2b0b9"
    ) -> chartC$complete$trace4highlight$withScatterGL_highlightGrey

  chartC$complete$trace4highlight$withScatterGL_highlightGrey
}
#saveRDS(chartC, file = "chartC2.Rds")

