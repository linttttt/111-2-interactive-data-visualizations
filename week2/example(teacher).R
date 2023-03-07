data.frame(
  x=sample(1:500, 10, replace = F),
  y=sample(1:500, 10, replace = F),
  z=sample(1:500, 10, replace = F)
) -> mydata
dplyr::glimpse(mydata)

# linear combination
mymodel <- ~ x + y + z + x:y + x:z + y:z + x:y:z

model.matrix(mymodel, mydata) |> View()

model.matrix(~x*y*z, mydata) |> View()

tx5 <- jsonlite::fromJSON("https://www.dropbox.com/s/9yxq2g1a5vdywu6/tx5.json?dl=1")
library(plotly)
plot_plt <- function() {
  plot_ly(tx5, x = ~date, y = ~median) %>%
    add_lines(linetype = ~city) -> plt
  plt
}





library(ggplot2)
ggplot(tx5, aes(x=date, y=median)) +
  geom_line(aes(linetype=city, color=city)) -> gplt

plot_plt() -> plt

plot_plt()$x |> listviewer::jsonedit()
# or
plot_plt() |> econIDV::showX()

pt <- econIDV::PlotlyTools()
pt$query_trace$Scatter() -> sc
sc()
