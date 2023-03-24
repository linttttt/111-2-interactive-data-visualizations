library(readr)

#saving container
bigMac2 = list()
big_mac_raw_index <- readr::read_csv("https://raw.githubusercontent.com/TheEconomist/big-mac-data/master/output-data/big-mac-raw-index.csv")

# split by date for later convenience
big_mac_raw_index |>
  split(big_mac_raw_index$date) -> bigMac2$split$byDate

# targetDF
targetDF = bigMac2$split$byDate$`2022-07-01`

# check column names
targetDF |> names()

# Ensure country names are ordered correctly
targetDF |>
  dplyr::arrange(USD) |>
  dplyr::pull("name") -> levelsCountryNames
targetDF$name = factor(targetDF$name, levels=levelsCountryNames)

# ggplot
library(ggplot2)
gg0 = econDV2::Plot()

gg0$ggplot <- {
  targetDF |>
    ggplot(
      mapping=aes(x=name, y=USD*100)
    )
}
gg0$geom <- list(
  geom_col(width = 0.2, mapping=aes(text=name))
)

gg0$theme = list(
  theme_classic(),
  theme(
    axis.line = element_blank(),
    axis.title = element_blank(),
    axis.ticks = element_blank(),
    axis.text.x = element_blank(),
    panel.grid.major.y = element_line()
  ))

gg0$make()

# plotly prototype
library(plotly)
plotly::ggplotly(gg0$make()) -> prototype
prototype

trace1 = prototype$x$data[[1]]

#
plot_ly() |>
  add_trace(
  )

#equivalent to
trace1 = prototype$x$data[[1]]
tt = append(list(plot_ly()),trace1)
#append(list(plot_ly()), trace1)
do.call("add_trace", tt)

View(trace1)
trace1$text = targetDF$name
tt = append(list(plot_ly()),trace1)
do.call("add_trace", tt)


#Plotly Tools
pt = econIDV::PlotlyTools()

pt$query_trace$Scatter() -> qq
qq("hover")
