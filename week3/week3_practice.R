big_mac_raw_index |>
  dplyr::mutate(
    color = ifelse(USD>0, "blue", "red")
  ) -> big_mac_raw_index

library(ggplot2)
gg3Point = econDV2::Plot()
gg3Point$ggplot = ggplot(data = big_mac_raw_index)
gg3Point$geom = list(
  geom_point(
    mapping = aes(
      x = date,
      y = USD*100,
      alpha = 0.1,
      color = color
    ),
    shape = 16
  ),
  geom_hline(
    yintercept = 0,
    color = "grey"
    )
)

gg3Point$scale = list(
  scale_color_manual(
    limits = c("blue", "red"),
    values = c("#3ebcd2", "#db444b")
  ),
  scale_y_continuous(
    breaks = c(-100, -50, 0, 50, 100, 150),
    labels = c(
      "-100", "-50", "0", "50", "100", "150%"),
    position = "right"
    )
)

gg3Point$theme = list(
  theme_classic(),
  theme(
    axis.line = element_blank(),
    axis.title = element_blank(),
    axis.ticks.y = element_blank(),
    axis.ticks.x = element_line(color = "grey"),
    legend.position = "none"
    #panel.grid.major.y = element_line()
  ))

gg3Point$make()


library(plotly)
plotly::ggplotly(gg3Point$make()) -> prototype3
prototype3

trace1 = prototype3$x$data[[1]]
trace2 = prototype3$x$data[[2]]
trace3 = prototype3$x$data[[3]]

trace1$hoverinfo = "skip"
trace2$hoverinfo = "skip"
trace3$hoverinfo = "skip"
plot_ly() |>
  econIDV::do_add_trace(trace1) |>
  econIDV::do_add_trace(trace2) |>
  econIDV::do_add_trace(trace3)

bigMac3 = list()
big_mac_raw_index |>
  split(big_mac_raw_index$name) -> bigMac3$split$byCountry

big_mac_tw = bigMac3$split$byCountry$Taiwan
gg3Line = econDV2::Plot()
gg3Line$ggplot = ggplot(data = big_mac_tw)
gg3Line$geom = list(
  geom_line(
    mapping = aes(
      x = date,
      y = USD*100
    ),
    color = "#006ba2",
    size = 1.2
  ),
  geom_hline(
    yintercept = 0,
    color = "grey"
  )
)
gg3Line$theme = list(
  theme_classic(),
  theme(
    axis.line = element_blank(),
    axis.title = element_blank(),
    axis.ticks.y = element_blank(),
    axis.ticks.x = element_line(color = "grey"),
    legend.position = "none"
    #panel.grid.major.y = element_line()
  ))

gg3Line$make()

plotly::ggplotly(gg3Line$make()) -> prototype3Line
prototype3Line


trace1 = prototype3$x$data[[1]]
trace2 = prototype3$x$data[[2]]
trace3 = prototype3$x$data[[3]]
trace1$hoverinfo = "skip"
trace2$hoverinfo = "skip"
trace3$hoverinfo = "skip"
plot_ly() |>
  econIDV::do_add_trace(trace1) |>
  econIDV::do_add_trace(trace2) |>
  econIDV::do_add_trace(trace3)


trace4 = prototype3Line$x$data[[1]]
trace4$text = "Taiwan"
plot_ly() |>
  econIDV::do_add_trace(trace4)

plot_ly() |>
  econIDV::do_add_trace(trace1) |>
  econIDV::do_add_trace(trace2) |>
  econIDV::do_add_trace(trace3) |>
  econIDV::do_add_trace(trace4)
