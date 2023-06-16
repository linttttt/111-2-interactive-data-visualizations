library(dplyr)
library(ggplot2)
library(plotly)
getAreaGraphDataLayoutConfig <- function(df) {
  bb$x[c("data", "layout", "config")]
}
plotArea = function(df){

  df |>
    dplyr::mutate(
      lagUSD = dplyr::lag(USD),
      changeFromPrevious = sign(dplyr::lag(USD)) != sign(USD),
      prevDate = dplyr::lag(date)
    ) |>
    dplyr::select(date, USD, lagUSD, changeFromPrevious, prevDate) -> dfTemp
  dfTemp |>
    dplyr::filter(
      changeFromPrevious
    ) |>
    dplyr::mutate(
      propUSD = abs(USD/(USD-lagUSD)),
      breakdate = date - (date-prevDate)*propUSD
    ) |>
    dplyr::pull(breakdate) -> breakdates

  if(length(breakdates) !=0){
    breakDateDF = data.frame(
      date=breakdates,
      USD=0
    )

    df |>
      dplyr::bind_rows(
        breakDateDF
      ) |>
      dplyr::arrange(date) -> df2
    ggplot() +
      geom_area(
        df2 |> dplyr::filter(USD >=0),
        mapping=aes(x=date, y=USD), fill = "#03bfc4"
      )+
      geom_area(
        df2 |> dplyr::filter(USD <= 0),
        mapping=aes(x=date, y=USD), fill = "#f8766d"
      ) -> gg
  } else {
    df2 = df
    ggplot() +
      geom_area(
        df2,
        mapping=aes(x=date, y=USD, fill=USD>=0)
      ) -> gg
  }


   gg +
    theme_void()+
    theme(legend.position = "none") -> gg

  gg |> plotly::ggplotly() |>
    hide_legend() |>
    config(displayModeBar=F) -> pp

  pp |>
    plotly::style(
      hoverinfo="none"
    )
  pp |> plotly::plotly_build()
}
getChartAData <- function(df) {
  df |>
    plotArea() -> bb
  bb |>
    config(displayModeBar=F) |>
    plotly::style(hoverinfo="none") -> bb

  bb$x$data
}
