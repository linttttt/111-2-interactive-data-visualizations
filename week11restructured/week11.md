
# Datatable

## Initiation
  
  * [Usage](https://rstudio.github.io/DT/#usage)
  
  ```{r}
  DT::datatable(
      {
        bigMacData$oneYear |>
          dplyr::arrange(desc(USD)) |>
          dplyr::select(name, USD)
        },
      elementId = "chartA",
      fillContainer = T,
      style = "bootstrap",
      class = "table-hover",
      callback = DT::JS("dt = table"),
      options = list(
        dom = "t",
        autoWidth = TRUE,
        pageLength = 100
      )
    ) 

  ``` 
### style

```         
style="bootstrap", class="..."
```

For available class, see:

-   [bootstrap](https://getbootstrap.com/docs/3.4/css/#tables)

### callback

Callbacks are JavaScript functions that are executed after the table is initialized.

The argument callback takes the body of a JavaScript function as a string. The function will be evaluated after the table is initialized. The table instance can be accessed via the variable `table`. In our example, `callback = DT::JS("dt = table")` means a callback function as

```{js}
function(table){
  dt = table
}
```

### options

#### columns > orderable

  * <https://datatables.net/reference/option/columns.orderable>

```
options = list(
   :
  columns = list(orderable=F)
)
```


## the instance

We can use `callback = DT::JS("dt = table")` option to create a `dt` in JS environment to represent the datable widget.

-   [callback](https://rstudio.github.io/DT/#the-callback-argument)

## select

-   <https://datatables.net/extensions/select/examples/api/select>

## events

-   <https://hyp.is/VXSo1OCTEe21nF-_gaH0Kw/datatables.net/manual/events>

# CSS selector

```
let chartA = document.getElementById("widget-chartA")
chartA.querySelectorAll("tbody tr")
```

# R leaflet

  * R version: <https://rstudio.github.io/leaflet/>
  * js version: <https://leafletjs.com/>