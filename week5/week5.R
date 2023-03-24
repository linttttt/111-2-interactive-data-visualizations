bigMac = readRDS("bigMac.Rds")

x = bigMac$build$`2022-07-01`$x

# save three components in a list
graphInfo = list(
  traces=x$data,
  layout=x$layout,
  config=x$config
)

library(plotly)
plot_ly() |>
  econIDV::do_add_trace(graphInfo$traces[[1]]) |>
  econIDV::do_add_trace(graphInfo$traces[[2]]) |>
  econIDV::do_add_trace(graphInfo$traces[[3]]) -> plt0

plt0 |>
  econIDV::do_layout(
    graphInfo$layout
  )

trace1 = graphInfo$traces[[1]]
trace1 |> names()
trace1Attributes = names(trace1)
trace1 |>
  econIDV::getAttributeListPairs(trace1Attributes)

plotly::plot_ly() |>
  plotly::add_trace(
    orientation = trace1$orientation,
    width = trace1$width,
    base = trace1$base,
    x = trace1$x,
    y = trace1$y,
    text = trace1$text,
    type = trace1$type,
    textposition = trace1$textposition,
    marker = trace1$marker,
    showlegend = trace1$showlegend,
    xaxis = trace1$xaxis,
    yaxis = trace1$yaxis,
    hoverinfo = trace1$hoverinfo,
    frame = trace1$frame
  )

plot_ly() |>
  add_trace(
    orientation = graphInfo$traces[[1]]$orientation,
    width = graphInfo$traces[[1]]$width,
    base = graphInfo$traces[[1]]$base,
    x = graphInfo$traces[[1]]$x,
    y = graphInfo$traces[[1]]$y,
    text = graphInfo$traces[[1]]$text,
    type = graphInfo$traces[[1]]$type,
    textposition = graphInfo$traces[[1]]$textposition,
    marker = graphInfo$traces[[1]]$marker,
    showlegend = graphInfo$traces[[1]]$showlegend,
    xaxis = graphInfo$traces[[1]]$xaxis,
    yaxis = graphInfo$traces[[1]]$yaxis,
    hoverinfo = graphInfo$traces[[1]]$hoverinfo,
    frame = graphInfo$traces[[1]]$frame
  ) |>
  add_trace(
    x = graphInfo$traces[[2]]$x,
    y = graphInfo$traces[[2]]$y,
    text = graphInfo$traces[[2]]$text,
    type = graphInfo$traces[[2]]$type,
    mode = graphInfo$traces[[2]]$mode,
    marker = graphInfo$traces[[2]]$marker,
    hoveron = graphInfo$traces[[2]]$hoveron,
    name = graphInfo$traces[[2]]$name,
    legendgroup = graphInfo$traces[[2]]$legendgroup,
    showlegend = graphInfo$traces[[2]]$showlegend,
    xaxis = graphInfo$traces[[2]]$xaxis,
    yaxis = graphInfo$traces[[2]]$yaxis,
    hoverinfo = graphInfo$traces[[2]]$hoverinfo,
    frame = graphInfo$traces[[2]]$frame
  ) |>
  add_trace(
    x = graphInfo$traces[[3]]$x,
    y = graphInfo$traces[[3]]$y,
    text = graphInfo$traces[[3]]$text,
    type = graphInfo$traces[[3]]$type,
    mode = graphInfo$traces[[3]]$mode,
    marker = graphInfo$traces[[3]]$marker,
    hoveron = graphInfo$traces[[3]]$hoveron,
    name = graphInfo$traces[[3]]$name,
    legendgroup = graphInfo$traces[[3]]$legendgroup,
    showlegend = graphInfo$traces[[3]]$showlegend,
    xaxis = graphInfo$traces[[3]]$xaxis,
    yaxis = graphInfo$traces[[3]]$yaxis,
    hoverinfo = graphInfo$traces[[3]]$hoverinfo,
    frame = graphInfo$traces[[3]]$frame
  )

#trace1
dd = bigMac$split$byDate$`2022-07-01`
dd |>
  dplyr::arrange(USD) |>
  dplyr::pull(name) -> nameLevels

dd$name |> factor(levels = nameLevels) -> dd$name
plot_ly(
  data = dd,
  x = ~name,
  y = ~USD,
  text = ~name,
  width =  0.2
) |>
  add_trace(
    orientation = graphInfo$traces[[1]]$orientation,
    #width = graphInfo$traces[[1]]$width,
    #base = graphInfo$traces[[1]]$base,
    #x = graphInfo$traces[[1]]$x,
    #y = graphInfo$traces[[1]]$y,
    #text = graphInfo$traces[[1]]$text,
    type = graphInfo$traces[[1]]$type,
    textposition = graphInfo$traces[[1]]$textposition,
    marker = graphInfo$traces[[1]]$marker,
    showlegend = graphInfo$traces[[1]]$showlegend,
    xaxis = graphInfo$traces[[1]]$xaxis,
    yaxis = graphInfo$traces[[1]]$yaxis,
    hoverinfo = graphInfo$traces[[1]]$hoverinfo,
    frame = graphInfo$traces[[1]]$frame
  )

dd |>
  plotly::highlight_key(
    ~name) -> dd_highlight

plot_ly() |>
  add_trace(
    data = dd_highlight,
    x = ~name, y = ~USD, text = ~name,
    width =  0.2,
    orientation = graphInfo$traces[[1]]$orientation,
    #width = graphInfo$traces[[1]]$width,
    #base = graphInfo$traces[[1]]$base,
    #x = graphInfo$traces[[1]]$x,
    #y = graphInfo$traces[[1]]$y,
    #text = graphInfo$traces[[1]]$text,
    type = graphInfo$traces[[1]]$type,
    textposition = graphInfo$traces[[1]]$textposition,
    marker = graphInfo$traces[[1]]$marker,
    showlegend = graphInfo$traces[[1]]$showlegend,
    xaxis = graphInfo$traces[[1]]$xaxis,
    yaxis = graphInfo$traces[[1]]$yaxis,
    hoverinfo = graphInfo$traces[[1]]$hoverinfo,
    frame = graphInfo$traces[[1]]$frame
  ) |>
  plotly::layout(
    barmode = "overlay"
  )

pt = econIDV::PlotlyTools()
pt$query_trace$Bar() -> qq
qq()

dd |> split(~USD > 0) -> ddSplit

dd |>
  highlight_key(
    ~name, group = "bigMac") -> dd_highlight
ddSplit$`FALSE` |>
  highlight_key(
    ~name, group = "bigMac") -> ddpt1_highlight
ddSplit$`TRUE` |>
  highlight_key(
    ~name, group = "bigMac") -> ddpt2_highlight


plot_ly() |>
  add_trace(
    data = dd_highlight,
    x = ~name, y = ~USD, text = ~name,
    width =  0.2,
    orientation = graphInfo$traces[[1]]$orientation,
    type = graphInfo$traces[[1]]$type,
    textposition = graphInfo$traces[[1]]$textposition,
    marker = graphInfo$traces[[1]]$marker,
    showlegend = graphInfo$traces[[1]]$showlegend,
    xaxis = graphInfo$traces[[1]]$xaxis,
    yaxis = graphInfo$traces[[1]]$yaxis,
    hoverinfo = graphInfo$traces[[1]]$hoverinfo,
    frame = graphInfo$traces[[1]]$frame
  ) |>
  plotly::layout(
    barmode = "overlay"
  ) |>
  add_trace(
    data = ddpt1_highlight,
    x = ~name, y = ~USD, text = ~name,
    # x = graphInfo$traces[[2]]$x,
    # y = graphInfo$traces[[2]]$y,
    # text = graphInfo$traces[[2]]$text,
    type = graphInfo$traces[[2]]$type,
    mode = graphInfo$traces[[2]]$mode,
    marker = graphInfo$traces[[2]]$marker,
    hoveron = graphInfo$traces[[2]]$hoveron,
    name = graphInfo$traces[[2]]$name,
    legendgroup = graphInfo$traces[[2]]$legendgroup,
    showlegend = graphInfo$traces[[2]]$showlegend,
    xaxis = graphInfo$traces[[2]]$xaxis,
    yaxis = graphInfo$traces[[2]]$yaxis,
    hoverinfo = graphInfo$traces[[2]]$hoverinfo,
    frame = graphInfo$traces[[2]]$frame
  ) |>
  add_trace(
    data = ddpt2_highlight,
    x = ~name, y = ~USD, text = ~name,
    # x = graphInfo$traces[[3]]$x,
    # y = graphInfo$traces[[3]]$y,
    # text = graphInfo$traces[[3]]$text,
    type = graphInfo$traces[[3]]$type,
    mode = graphInfo$traces[[3]]$mode,
    marker = graphInfo$traces[[3]]$marker,
    hoveron = graphInfo$traces[[3]]$hoveron,
    name = graphInfo$traces[[3]]$name,
    legendgroup = graphInfo$traces[[3]]$legendgroup,
    showlegend = graphInfo$traces[[3]]$showlegend,
    xaxis = graphInfo$traces[[3]]$xaxis,
    yaxis = graphInfo$traces[[3]]$yaxis,
    hoverinfo = graphInfo$traces[[3]]$hoverinfo,
    frame = graphInfo$traces[[3]]$frame
  ) |>
  highlight(
    on = "plotly_hover",
    off = "plotly_doubleclick"
  ) |>
  layout(
    margin = graphInfo$layout$margin,
    plot_bgcolor = graphInfo$layout$plot_bgcolor,
    paper_bgcolor = graphInfo$layout$paper_bgcolor,
    font = graphInfo$layout$font,
    # xaxis = graphInfo$layout$xaxis,
    # yaxis = graphInfo$layout$yaxis,
    shapes = graphInfo$layout$shapes,
    showlegend = graphInfo$layout$showlegend,
    legend = graphInfo$layout$legend,
    hovermode = graphInfo$layout$hovermode,
    barmode = "overlay"
  ) -> bigMac$highlight

# graphInfo$layout |> names() -> layoutAttrs
# layoutAttrs |>
#   econIDV::getAttributeListPairs()





bigMac$highlight |>
  plotly::api_create() -> link
