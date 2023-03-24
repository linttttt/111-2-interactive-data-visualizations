big_mac <- readr::read_csv("https://raw.githubusercontent.com/TheEconomist/big-mac-data/master/output-data/big-mac-raw-index.csv")
library(ggplot2)
library(plotly)
gg4Line = econDV2::Plot()
gg4Line$ggplot = ggplot(data = big_mac)
gg4Line$geom = list(
  geom_line(
    mapping = aes(
      x = date,
      y = USD*100,
      group = name
    ),
    color = "#006ba2",
    size = 1.2
  )
)

# gg4Line$scale = list(
#   scale_color_manual(
#     limits = "Taiwan",
#     values = "blue",
#     na.value = "grey"
#   )
# )

gg4Line$theme = list(
  theme_classic(),
  theme(
    axis.line = element_blank(),
    axis.title = element_blank(),
    axis.ticks.y = element_blank(),
    axis.ticks.x = element_line(color = "grey"),
    legend.position = "none"
    #panel.grid.major.y = element_line()
  ))

gg4Line$make()

plotly::ggplotly(gg4Line$make()) |>
  plotly::plotly_build() -> prototype4Line
prototype4Line
traces = prototype4Line$x$data[[1]]
# for (i in seq_along(traces)) {
#   traces[[i]]$text |>
#     stringr::str_extract(
#       "(?<=(name:\\s))[^<]+"
#     ) -> traces[[i]]$text
# }
traces$text |>
  stringr::str_extract(
    "(?<=(name:\\s))[^<]+"
  ) -> traces$text
plot_ly() |>
  econIDV::do_add_trace(
    traces
  )-> p4
p4

big_mac |>
  plotly::highlight_key(~name) -> big_mac_highlighted
class(big_mac_highlighted)

plot_ly(
  data = big_mac_highlighted,
  x = ~date, y = ~USD, name = ~name
) |>
  add_trace(
    #x = traces$x,
    #y = traces$y,
    #text = traces$text,
    type = traces$type,
    mode = traces$mode,
    line = traces$line,
    hoveron = traces$hoveron,
    showlegend = traces$showlegend,
    xaxis = traces$xaxis,
    yaxis = traces$yaxis,
    hoverinfo = traces$hoverinfo,
    frame = traces$frame
  ) |>
  highlight(
    on = "plotly_hover",
    off = "plotly_doubleclick",
    opacityDim = 0
  )-> p44
p44
