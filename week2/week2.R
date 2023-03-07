data.frame(
  x=sample(1:500, 10, replace = F),
  y=sample(1:500, 10, replace = F),
  z=sample(1:500, 10, replace = F)
) -> mydata
dplyr::glimpse(mydata)

#linear combination
mymodel <- ~ x + y + z + x:y + x:z + y:z + x:y:z

model.matrix(mymodel, mydata) |> View()
model.matrix(~x*y*z, mydata) |> View()


plt <- function() {
  plot_ly(tx5, x = ~date, y = ~median) %>%
    add_lines(linetype = ~city) -> plt
  plt
}

plt()$x |> listviewer::jsonedit() 
# or
plt() |> econIDV::showX()