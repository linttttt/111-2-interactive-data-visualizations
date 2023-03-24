plotly::ggplotly(gg3Point$make()) |>
  plotly::plotly_build() -> prototype3point
plotly::ggplotly(gg4Line$make()) |>
  plotly::plotly_build() -> prototype4Line
library(plotly)
graph5Info = list(
  point = list(
  traces = prototype3point$x$data,
  layout = prototype3point$x$layout,
  config = prototype3point$x$config
    ),
  line = list(
    traces = prototype4Line$x$data,
    layout = prototype4Line$x$layout,
    config = prototype4Line$x$config
    )
  ) |> saveRDS("graph5Info.Rds")

graph5Info = readRDS("graph5Info.Rds")

plot_ly() |>
  econIDV::do_add_trace(graph5Info$point$traces[[1]]) |>
  econIDV::do_add_trace(graph5Info$point$traces[[2]]) |>
  econIDV::do_add_trace(graph5Info$point$traces[[3]]) |>
  econIDV::do_add_trace(graph5Info$line$traces[[1]]) |>
  econIDV::do_layout(graph5Info$point$layout) |>
  econIDV::do_layout(graph5Info$line$layout)


graph5Info$line$traces[[1]] |>
  names() -> trace1Attributes
graph5Info$line$traces[[1]] |>
  econIDV::getAttributeListPairs(trace1Attributes)

#conbine line and point(no highlight)
{plotly::plot_ly() |>
  plotly::add_trace(
    x = graph5Info$point$traces[[1]]$x,
    y = graph5Info$point$traces[[1]]$y,
    text = graph5Info$point$traces[[1]]$text,
    type = graph5Info$point$traces[[1]]$type,
    mode = graph5Info$point$traces[[1]]$mode,
    marker = graph5Info$point$traces[[1]]$marker,
    hoveron = graph5Info$point$traces[[1]]$hoveron,
    name = graph5Info$point$traces[[1]]$name,
    legendgroup = graph5Info$point$traces[[1]]$legendgroup,
    showlegend = graph5Info$point$traces[[1]]$showlegend,
    xaxis = graph5Info$point$traces[[1]]$xaxis,
    yaxis = graph5Info$point$traces[[1]]$yaxis,
    hoverinfo = graph5Info$point$traces[[1]]$hoverinfo,
    frame = graph5Info$point$traces[[1]]$frame
  ) |>
  plotly::add_trace(
    x = graph5Info$point$traces[[2]]$x,
    y = graph5Info$point$traces[[2]]$y,
    text = graph5Info$point$traces[[2]]$text,
    type = graph5Info$point$traces[[2]]$type,
    mode = graph5Info$point$traces[[2]]$mode,
    marker = graph5Info$point$traces[[2]]$marker,
    hoveron = graph5Info$point$traces[[2]]$hoveron,
    name = graph5Info$point$traces[[2]]$name,
    legendgroup = graph5Info$point$traces[[2]]$legendgroup,
    showlegend = graph5Info$point$traces[[2]]$showlegend,
    xaxis = graph5Info$point$traces[[2]]$xaxis,
    yaxis = graph5Info$point$traces[[2]]$yaxis,
    hoverinfo = graph5Info$point$traces[[2]]$hoverinfo,
    frame = graph5Info$point$traces[[2]]$frame
  ) |>
  plotly::add_trace(
    x = graph5Info$point$traces[[3]]$x,
    y = graph5Info$point$traces[[3]]$y,
    text = graph5Info$point$traces[[3]]$text,
    type = graph5Info$point$traces[[3]]$type,
    mode = graph5Info$point$traces[[3]]$mode,
    line = graph5Info$point$traces[[3]]$line,
    hoveron = graph5Info$point$traces[[3]]$hoveron,
    showlegend = graph5Info$point$traces[[3]]$showlegend,
    xaxis = graph5Info$point$traces[[3]]$xaxis,
    yaxis = graph5Info$point$traces[[3]]$yaxis,
    hoverinfo = graph5Info$point$traces[[3]]$hoverinfo,
    frame = graph5Info$point$traces[[3]]$frame
  ) |>
  plotly::add_trace(
    x = graph5Info$line$traces[[1]]$x,
    y = graph5Info$line$traces[[1]]$y,
    text = graph5Info$line$traces[[1]]$text,
    type = graph5Info$line$traces[[1]]$type,
    mode = graph5Info$line$traces[[1]]$mode,
    line = graph5Info$line$traces[[1]]$line,
    hoveron = graph5Info$line$traces[[1]]$hoveron,
    showlegend = graph5Info$line$traces[[1]]$showlegend,
    xaxis = graph5Info$line$traces[[1]]$xaxis,
    yaxis = graph5Info$line$traces[[1]]$yaxis,
    hoverinfo = graph5Info$line$traces[[1]]$hoverinfo,
    frame = graph5Info$line$traces[[1]]$frame
  )
  }

#line
{plotly::plot_ly(
  data = big_mac,
  x = ~date, y = ~USD,
  split = ~name, text = ~name
) |>
  plotly::add_trace(
    # x = graph5Info$line$traces[[1]]$x,
    # y = graph5Info$line$traces[[1]]$y,
    # text = graph5Info$line$traces[[1]]$text,
    type = graph5Info$line$traces[[1]]$type,
    mode = graph5Info$line$traces[[1]]$mode,
    line = graph5Info$line$traces[[1]]$line,
    hoveron = graph5Info$line$traces[[1]]$hoveron,
    showlegend = graph5Info$line$traces[[1]]$showlegend,
    xaxis = graph5Info$line$traces[[1]]$xaxis,
    yaxis = graph5Info$line$traces[[1]]$yaxis,
    hoverinfo = graph5Info$line$traces[[1]]$hoverinfo,
    frame = graph5Info$line$traces[[1]]$frame
  )
  }

big_mac |> split(~USD > 0) -> bigMac_pointSplit

big_mac |>
  plotly::highlight_key(
    ~name) -> bigMac_line_highlight

graph5Info$line$layout |>
  names() -> layoutAttrs
graph5Info$line$layout |>
  econIDV::getAttributeListPairs(layoutAttrs)

#line highlight
{
plotly::plot_ly() |>
  plotly::add_trace(
    data = bigMac_line_highlight,
    x = ~date, y = ~(USD*100),
    split = ~name, text = ~name,
    type = graph5Info$line$traces[[1]]$type,
    mode = graph5Info$line$traces[[1]]$mode,
    line = graph5Info$line$traces[[1]]$line,
    hoveron = graph5Info$line$traces[[1]]$hoveron,
    showlegend = graph5Info$line$traces[[1]]$showlegend,
    xaxis = graph5Info$line$traces[[1]]$xaxis,
    yaxis = graph5Info$line$traces[[1]]$yaxis,
    hoverinfo = graph5Info$line$traces[[1]]$hoverinfo,
    frame = graph5Info$line$traces[[1]]$frame
  ) |>
  plotly::highlight(
    on = "plotly_hover",
    off = "plotly_doubleclick",
    opacityDim = 0
  ) |>
  plotly::layout(
    margin = graph5Info$line$layout$margin,
    plot_bgcolor = graph5Info$line$layout$plot_bgcolor,
    paper_bgcolor = graph5Info$line$layout$paper_bgcolor,
    font = graph5Info$line$layout$font,
    # xaxis = graph5Info$line$layout$xaxis,
    # yaxis = graph5Info$line$layout$yaxis,
    shapes = graph5Info$line$layout$shapes,
    showlegend = graph5Info$line$layout$showlegend,
    legend = graph5Info$line$layout$legend,
    hovermode = graph5Info$line$layout$hovermode,
    barmode = graph5Info$line$layout$barmode
    )
  }

#conbine line and point(line highlight)
plotly::plot_ly() |>
  plotly::add_trace(
    data = bigMac_pointSplit$`TRUE`,
    x = ~date, y = ~(USD*100),
    type = graph5Info$point$traces[[1]]$type,
    mode = graph5Info$point$traces[[1]]$mode,
    marker = graph5Info$point$traces[[1]]$marker,
    hoveron = graph5Info$point$traces[[1]]$hoveron,
    name = graph5Info$point$traces[[1]]$name,
    legendgroup = graph5Info$point$traces[[1]]$legendgroup,
    showlegend = graph5Info$point$traces[[1]]$showlegend,
    xaxis = graph5Info$point$traces[[1]]$xaxis,
    yaxis = graph5Info$point$traces[[1]]$yaxis,
    hoverinfo = "skip",
    frame = graph5Info$point$traces[[1]]$frame
   ) |>
  plotly::add_trace(
    data = bigMac_pointSplit$`FALSE`,
    x = ~date, y = ~(USD*100),
    type = graph5Info$point$traces[[2]]$type,
    mode = graph5Info$point$traces[[2]]$mode,
    marker = graph5Info$point$traces[[2]]$marker,
    hoveron = graph5Info$point$traces[[2]]$hoveron,
    name = graph5Info$point$traces[[2]]$name,
    legendgroup = graph5Info$point$traces[[2]]$legendgroup,
    showlegend = graph5Info$point$traces[[2]]$showlegend,
    xaxis = graph5Info$point$traces[[2]]$xaxis,
    yaxis = graph5Info$point$traces[[2]]$yaxis,
    hoverinfo = "skip",
    frame = graph5Info$point$traces[[2]]$frame
  ) |>
  plotly::add_trace(
    data = bigMac_line_highlight,
    x = ~date, y = ~(USD*100),
    split = ~name, text = ~name,
    type = graph5Info$line$traces[[1]]$type,
    mode = graph5Info$line$traces[[1]]$mode,
    line = graph5Info$line$traces[[1]]$line,
    hoveron = graph5Info$line$traces[[1]]$hoveron,
    showlegend = graph5Info$line$traces[[1]]$showlegend,
    xaxis = graph5Info$line$traces[[1]]$xaxis,
    yaxis = graph5Info$line$traces[[1]]$yaxis,
    hoverinfo = graph5Info$line$traces[[1]]$hoverinfo,
    frame = graph5Info$line$traces[[1]]$frame
  ) |>
  plotly::highlight(
    on = "plotly_hover",
    off = "plotly_doubleclick",
    opacityDim = 0
  ) |>
  plotly::layout(
    margin = graph5Info$point$layout$margin,
    plot_bgcolor = graph5Info$point$layout$plot_bgcolor,
    paper_bgcolor = graph5Info$point$layout$paper_bgcolor,
    font = graph5Info$point$layout$font,
    # xaxis = graph5Info$point$layout$xaxis,
    # yaxis = graph5Info$point$layout$yaxis,
    shapes = graph5Info$point$layout$shapes,
    showlegend = graph5Info$point$layout$showlegend,
    legend = graph5Info$point$layout$legend,
    hovermode = graph5Info$point$layout$hovermode,
    barmode = graph5Info$point$layout$barmode
  ) -> graph5Info$highlight

graph5Info$highlight |>
  plotly::api_create() -> link
