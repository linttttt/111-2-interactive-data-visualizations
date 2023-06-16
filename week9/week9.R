bigMacData = readRDS("../week8/bigMacData.Rds")
chartC=readRDS("../week8/chartC.Rds")
chartB=readRDS("../week8/chartB.Rds")
library(plotly)
# section A ----
# ChartB -----
## highlight -------
{


  plot_ly() |>
    add_segments(
      data=bigMacData$oneYear,
      x = ~name, xend=~name,
      y = 0, yend= ~USD,
      type="scattergl"
    ) |>
    add_trace(
      data = bigMacData$oneYearUSDneg |> plotly::highlight_key(~name, group="bigMac2"),
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
      marker = #chartB$traces[[2]]$marker,
        list(
          autocolorscale = chartB$traces[[2]]$marker$autocolorscale,
          color = chartB$traces[[2]]$marker$color,
          opacity = chartB$traces[[2]]$marker$opacity,
          size = 8, #chartB$traces[[2]]$marker$size,
          symbol = chartB$traces[[2]]$marker$symbol,
          line = #chartB$traces[[2]]$marker$line
            list(
              width = 0 #chartB$traces[[2]]$marker$line$width,
              # color = chartB$traces[[2]]$marker$line$color
            )
        ),
      hoveron = chartB$traces[[2]]$hoveron,
      name = chartB$traces[[2]]$name,
      legendgroup = chartB$traces[[2]]$legendgroup,
      showlegend = chartB$traces[[2]]$showlegend,
      xaxis = chartB$traces[[2]]$xaxis,
      yaxis = chartB$traces[[2]]$yaxis,
      hoverinfo = chartB$traces[[2]]$hoverinfo
    ) |>
    add_trace(
      data = bigMacData$oneYearUSDPos |> plotly::highlight_key(~name, group="bigMac2"),
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
      marker = #chartB$traces[[3]]$marker,
        list(
          autocolorscale = chartB$traces[[3]]$marker$autocolorscale,
          color = chartB$traces[[3]]$marker$color,
          opacity = chartB$traces[[3]]$marker$opacity,
          size = 8, #chartB$traces[[3]]$marker$size,
          symbol = chartB$traces[[3]]$marker$symbol,
          line = #chartB$traces[[3]]$marker$line
            list(
              width = 0 #chartB$traces[[3]]$marker$line$width,
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
    )  |>
    layout(
      yaxis=list(
        fixedrange=T, # stop y being zoomable.
        range=list(-0.7,0.5) # set fixed range even after each filter re-drawals.
      )
    ) |>
    hide_legend() |>
    config(displayModeBar=F) |>
    highlight(
      on="plotly_hover",
      opacityDim = 1,
      color="#a2b0b9") -> chartB$highlightWithSplit

  chartB$highlightWithSplit
}
## Restyle ------
### trace 40 ----
{
  chartB$highlightWithSplit |> plotly::plotly_build() -> chartBBuild
  trace40 = chartBBuild$x$data[[40]]

  trace40 |> econIDV::getAttributeListPairs(names(trace40))
}
{
  trace40$marker$color
  trace40$marker$line$color
}
### trace 40 attributes ----
{

  {
    trace40 = list(
      x = chartBBuild$x$data[[40]]$x,
      y = chartBBuild$x$data[[40]]$y,
      # text = chartBBuild$x$data[[40]]$text,
      # name = chartBBuild$x$data[[40]]$name,
      type = chartBBuild$x$data[[40]]$type,
      mode = chartBBuild$x$data[[40]]$mode,
      marker = #chartBBuild$x$data[[40]]$marker
        list(
          color = "blue", #chartBBuild$x$data[[40]]$marker$color,
          autocolorscale = chartBBuild$x$data[[40]]$marker$autocolorscale,
          opacity = chartBBuild$x$data[[40]]$marker$opacity,
          size = chartBBuild$x$data[[40]]$marker$size,
          symbol = chartBBuild$x$data[[40]]$marker$symbol,
          line = #chartBBuild$x$data[[40]]$marker$line
            list(
              color = "blue",
              width = chartBBuild$x$data[[40]]$marker$line$width
            )
        )
      # hoveron = chartBBuild$x$data[[40]]$hoveron,
      # legendgroup = chartBBuild$x$data[[40]]$legendgroup,
      # showlegend = chartBBuild$x$data[[40]]$showlegend,
      # xaxis = chartBBuild$x$data[[40]]$xaxis,
      # yaxis = chartBBuild$x$data[[40]]$yaxis,
      # hoverinfo = chartBBuild$x$data[[40]]$hoverinfo,
      # key = chartBBuild$x$data[[40]]$key,
      # set = chartBBuild$x$data[[40]]$set,
      # error_y = chartBBuild$x$data[[40]]$error_y,
      # error_x = chartBBuild$x$data[[40]]$error_x,
      # line = chartBBuild$x$data[[40]]$line,
      # _isSimpleKey = chartBBuild$x$data[[40]]$_isSimpleKey,
      # _isNestedKey = chartBBuild$x$data[[40]]$_isNestedKey,
      # frame = chartBBuild$x$data[[40]]$frame
    )
  }
  chartB$highlightWithSplit |>
    plotly::style(
      marker = #chartBBuild$x$data[[40]]$marker
        list(
          color = "blue", #chartBBuild$x$data[[40]]$marker$color,
          autocolorscale = chartBBuild$x$data[[40]]$marker$autocolorscale,
          opacity = chartBBuild$x$data[[40]]$marker$opacity,
          size = chartBBuild$x$data[[40]]$marker$size,
          symbol = chartBBuild$x$data[[40]]$marker$symbol,
          line = #chartBBuild$x$data[[40]]$marker$line
            list(
              color = "blue",
              width = chartBBuild$x$data[[40]]$marker$line$width
            )
        ), traces=40
    )
}

# ChartC ----
## highlight ----
#### use scatterGL -------
{
  bigMac2 = readRDS("../week7/bigMac2.Rds")
  traces = bigMac2$traces

  traces[[1]]$marker$opacity <- 0.3
  traces[[2]]$marker$opacity <- 0.3
  plot_ly() |>
    add_trace(
      data=bigMacData$allYearsWithNAUSDNeg,
      x = ~date,
      y = ~USD,
      # x = traces[[1]]$x,
      # y = traces[[1]]$y,
      # text = traces[[1]]$text,
      type = "scattergl", #traces[[1]]$type,
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
    ) |> #plotly_build() |> View()
    add_trace(
      data = bigMacData$allYearsWithNAUSDPos,
      x = ~date,
      y = ~USD,
      # x = traces[[2]]$x,
      # y = traces[[2]]$y,
      # text = traces[[2]]$text,
      type = "scattergl", #traces[[2]]$type,
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
      data = bigMacData$allYearsWithNA |> plotly::highlight_key(~name, group="bigMac"),
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
    )  |>
    layout(
      yaxis=list(
        # fixedrange=T, # stop y being zoomable.
        range=list(-1,2) # set fixed range even after each filter re-drawals.
      ),
      xaxis = list(
        range=list(lubridate::ymd("2000-04-01"), lubridate::ymd("2022-07-01"))
      )
    ) |>
    hide_legend() |>
    config(displayModeBar=F)  |>
    highlight(
      on="plotly_hover",
      opacityDim = 1,
      color="#a2b0b9") -> chartC$complete$trace4highlight$withScatterGL_highlightGrey

  chartC$complete$trace4highlight$withScatterGL_highlightGrey
}

## Restyle ----
{
  chartC$complete$trace4highlight$withScatterGL_highlightGrey |>
    plotly::plotly_build() -> chartCBuild
  chartCBuild$x$data |> length()
  chartCBuild$x$data[[20]]
  {
  list(
    x = chartCBuild$x$data[[20]]$x,
    y = chartCBuild$x$data[[20]]$y,
    text = chartCBuild$x$data[[20]]$text,
    type = chartCBuild$x$data[[20]]$type,
    mode = chartCBuild$x$data[[20]]$mode,
    line = #chartCBuild$x$data[[20]]$line,
      list(
        color = chartCBuild$x$data[[20]]$line$color,
        width = chartCBuild$x$data[[20]]$line$width,
        dash = chartCBuild$x$data[[20]]$line$dash
      ),
    hoveron = chartCBuild$x$data[[20]]$hoveron,
    showlegend = chartCBuild$x$data[[20]]$showlegend,
    xaxis = chartCBuild$x$data[[20]]$xaxis,
    yaxis = chartCBuild$x$data[[20]]$yaxis,
    hoverinfo = chartCBuild$x$data[[20]]$hoverinfo,
    frame = chartCBuild$x$data[[20]]$frame,
    key = chartCBuild$x$data[[20]]$key,
    set = chartCBuild$x$data[[20]]$set,
    name = chartCBuild$x$data[[20]]$name,
    marker = #chartCBuild$x$data[[20]]$marker,
      list(
        color = chartCBuild$x$data[[20]]$marker$color,
        line = chartCBuild$x$data[[20]]$marker$line
      ),
    error_y = chartCBuild$x$data[[20]]$error_y,
    error_x = chartCBuild$x$data[[20]]$error_x #,
    # _isSimpleKey = chartCBuild$x$data[[20]]$_isSimpleKey,
    # _isNestedKey = chartCBuild$x$data[[20]]$_isNestedKey
   )
  }
  chartC$complete$trace4highlight$withScatterGL_highlightGrey |>
    plotly::style(
      # line = list(color="blue"),
      opacity = 1,
      marker = list(
        line = list(
          color="red"
        )
      ),
      traces = 20
    )
}
# traceMapping ---------
{
  chartB$highlightWithSplit |> econIDV::get_traceInfo() -> chartBtraceInfo
  chartBtraceInfo$trace |> as.list() |>
    setNames(chartBtraceInfo$name) -> chartB$tracemap
}
{
  chartC$complete$trace4highlight$withScatterGL_highlightGrey |>
    econIDV::get_traceInfo() -> chartCtraceInfo
  chartCtraceInfo$trace |> as.list() |>
    setNames(chartCtraceInfo$name) -> chartC$tracemap
}
# Chart A ----
chartA = list()
{
  DT::datatable(bigMacData$oneYear |>
                  dplyr::arrange(desc(USD)) |>
                  dplyr::select(name, USD)
                  ) -> chartA$tb0
}
saveRDS(chartA, file="chartA.Rds")
saveRDS(chartB, file="chartB.Rds")
saveRDS(chartC, file="chartC.Rds")
