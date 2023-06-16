# Flexdashboard

## Theme

-   <https://pkgs.rstudio.com/flexdashboard/articles/using.html#appearance>

Support several themes from bootswatch:

-   [bootswatch website](https://bootswatch.com/)

    -   [default cosmo theme](https://bootswatch.com/cosmo/)

## Dropdown menu

1.  Use Chrome right click your mouse \> inspect

2.  Click ![inspect element](inspect-element.png) , then select the drop down menu in the web page,

## Include dropdown menu

-   `htmltools::includeHTML("….")`

-   write you own R version of dropdown menu code using **htmltools** package

### formula

```         
purrr::map(~{tags$option(.x)})
```

create a temporary function as

```         
function(.x){
  tags$option(.x)
}
```

### Custom dropdown menu creator function

```         
dropDownMenu <- function(nameList, id) {
  createOptions = function(.x){ htmltools::tags$option(.x)}
  nameList |>
    purrr::map(createOptions) -> listOptions
  
  library(htmltools)
  div(class="form-group",
      tags$label(
        `for`="exampleSelect2", class="form-label mt-4",
        "Example select"
      ),
      tags$select(
         class="form-select", id=id,
          listOptions
      )
      )
}
```

### Dropdown menu events

-   User select a date: use **change** event.

-   Retrieve the date value the user selected.

    ```         
    var chartBSelect = document.getElementById("plotly-select")

    chartBSelect.value // show the current dropdown value
    ```

# Plotly JS

-   <https://plotly.com/javascript/>

```         
<div class="datatables html-widget html-fill-item-overflow-hidden html-fill-item" id="widget-chartA" style="width:100%;height:auto;"></div>
```

# Datatable

## style

```         
style="bootstrap", class="..."
```

For available class, see:

-   [bootstrap](https://getbootstrap.com/docs/3.4/css/#tables)

## the instance

We can use `callback = DT::JS("dt = table")` option to create a `dt` in JS environment to represent the datable widget.

-   [callback](https://rstudio.github.io/DT/#the-callback-argument)

## select

-   <https://datatables.net/extensions/select/examples/api/select>

## events

-   <https://hyp.is/VXSo1OCTEe21nF-_gaH0Kw/datatables.net/manual/events>

```{r}

```
