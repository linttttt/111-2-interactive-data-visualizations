# Restyle

```{r}
source("week9.R")
```

## Motivation

In Big Mac Index, hover creates dynamic effect on trace colors, which can be easily achieved by **highlight** in Plotly. However, in BMI click will change some trace's color. To achieve that, we need to

-   attach a click event listener.

-   create its handler that can change a given trace's color given the click event data.

## Change some traces

-   [trace 40 in `chartB$highlightWithSplit`]()

```{r}
chartB$highlightWithSplit |> plotly::plotly_build() -> chartBBuild
trace40 = chartBBuild$x$data[[40]]
```

When trace 40 is drawn it goes through:

```         
... |>
  add_trace(
    x = trace40$x,
    y = trace40$y,
    text = trace40$text,
    name = trace40$name,
    type = trace40$type,
    mode = trace40$mode,
    marker = trace40$marker,
    hoveron = trace40$hoveron,
    legendgroup = trace40$legendgroup,
    showlegend = trace40$showlegend,
    xaxis = trace40$xaxis,
    yaxis = trace40$yaxis,
    hoverinfo = trace40$hoverinfo,
    key = trace40$key,
    set = trace40$set,
    error_y = trace40$error_y,
    error_x = trace40$error_x,
    line = trace40$line,
    _isSimpleKey = trace40$_isSimpleKey,
    _isNestedKey = trace40$_isNestedKey,
    frame = trace40$frame
  ) |>
  ...
```

Suppose we want to change its color to 'blue'

```{r}
# current color
trace40$marker$color

chartB$highlightWithSplit |>
  plotly::style(
    marker = list(
      color="blue"
    ),
    traces = 40
  )
```

`plotly::style` in R is helpful for us to check if we get the right attributes. To implement it in a web framework, we need to do that in JS.

In JS, we can change its color through

-   [`Plotly.restyle function`](https://plotly.com/javascript/plotlyjs-function-reference/#plotlyrestyle)

```{js}
Plotly.restyle(
  chartB, 
  {
    "marker.color": "blue"
  },
  40
)
```

-   The nested element names ("marker" \> "color") are flattened into one single string ("marker.color").

## Set of values in JS

In R, set of values is vector, such as \`c(...)\` (atomic vector), `list(...)` (list vector). Atomic vector has to have all values of **THE SAME** type.

### Array and list

In JS, set of values is not required to have the same type of elements inside.

-   Array

```         
var arrayExample = [value1, value2, value3]
```

-   Object: set of **features** or **interfaces** or **key**

```         
var person = { name: "Henry", age: 32, married: false}
```

-   like `list` in R with element names.

### Retrieval

JS does not support multiple retrieval like R as `a[c(1,5,7)]`, but does use `[.]` for single retrieval where `.` can be an integer or an element name as in R. However,

> Array elements have **positions**, but not object elements. Object elements have **element names** (keys), but not array elements.

```         
arrayExample[1] # get value2
person[1] # get Error
person["name"] # get Henry
```

Like list in R has a special `$` retrieval, list in JS has a special `.` retrieval:

```         
person.name # get Henry
```

## Plotly js functions

Its usage involved with arguments whose type can be:

-   DOM node or string id of a DOM node

-   Object

-   Array

## Design thinking

### Use specific senario

1.  [first click on trace 20] -\> [trace 20 turns blue]
2.  [click trace 30] -\> [trace 20 resumes original color, trace 30 turns blue]

```{js}
// 1.
// trace 20 turns blue
Plotly.restyle(
  chartB, {"marker.color": "blue"}, 20)

// 2.
// trace 20 resumes original color, 
Plotly.restyle(
  chartB, {"marker.color": originalColor}, 20)
// trace 30 turns blue
Plotly.restyle(
  chartB, {"marker.color": "blue"}, 30
)
```

### create helper function

In JS, functions can be created either `funname = function(...){...}` or `function funname(...){...}`. The latter is preferred.

```{js}
function handleClick(originalColor, prevTrace, targetTrace){

  // previously-clicked trace resumes original color,
  if(
   // there is a previously-clicked trace
  ){
    Plotly.restyle(
    chartB, {"marker.color": originalColor}, prevTrace)
  }

  //  trace 30 turns blue
  Plotly.restyle(
    chartB, {"marker.color": "blue"}, targetTrace
  )
}

handleClick(originalColor, 20, 30)
```

In [helper.js](), we see:

```{js}
/* chart B */
originalStyle = {
    "marker.color": "rgba(248,118,109,1)",
    "marker.size": 8,
    "marker.line.color": "rgba(248,118,109,1)",
    "marker.line.width": 0
}
newStyle = {
        "marker.color": "#006ba2",
        "marker.size": 10,
        "marker.line.color": "#006ba2",
        "marker.line.width": 1.8
}

styleChangeInB = {
    "original": originalStyle,
    "new": newStyle,
    "targetTrace": null
}
```

and

```{js}
function clickHighlight(chart,trace, styleChange){

    if(styleChange.targetTrace){
        Plotly.restyle(
            chart,
            styleChange.original,
            styleChange.targetTrace
        )
    }

    styleChange.targetTrace=trace

    Plotly.restyle(
        chart,
        styleChange.new,
        styleChange.targetTrace
    )
    return(styleChange)
}
```

-   In JS `null` value can serve as a false flag.

------------------------------------------------------------------------

The following command will:

-   change trace 20 in `chartB` to the new style color; and

-   if `styleChangeInB.targetTrace` is not null, will resume that trace's style color; then

-   update `styleChangeInB.targetTrace` to 20.

```{js}
styleChangeInB = clickHighlight(chartB, 20 ,styleChangeInB)
```

### include helpers

```{r}
htmltools::includeScript("./js/helper.js")
```

### figure out click event trace

When `chartB` is clicked, we need to know which trace is clicked from the event data.

Through experiment, the event data say `ev` will give us country name through:

```{js}
ev.points[0].x
```

It would be good that we have a mapping object like:

```{js}
mappingObject = {
  "Taiwan": 30, "Japan": 44, ...
}
```

So that

```{js}
mappingObject["Taiwan"]
```

gives us its trace number 30.

#### trace mapping

Use `econIDV::get_traceInfo()` will give us a trace mapping data frame:

```{r}
chartB$highlightWithSplit |>
  econIDV::get_traceInfo() 
```

```{r}
  chartB$highlightWithSplit |> econIDV::get_traceInfo() -> chartBtraceInfo
  chartBtraceInfo$trace |> as.list() |>
    setNames(chartBtraceInfo$name)  -> chartBtracemapping
View(chartBtracemapping)
```

#### pass data to html

```{r}
htmltools::tags$script(
  id="chartB-tracemap",
  type="application/json",
  chartB$tracemap |> jsonlite::toJSON()
)
htmltools::tags$script(
  id="chartC-tracemap",
  type="application/json",
  chartC$tracemap |> jsonlite::toJSON()
)

```


