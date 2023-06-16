dropdownMenu <- function(nameList, id, label, selectedDate=NULL) {

  createOptions <- function(.x) {
    if(!is.null(selectedDate) && .x==selectedDate){
      htmltools::tags$option(.x, selected=NA)
    } else {
      htmltools::tags$option(.x)
    }
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
