getNewTaipeiJSON <- function(page) {
  urlAPI$`New Taipei` |>
    paste0("&page=", page) |>
    jsonlite::fromJSON()
}
