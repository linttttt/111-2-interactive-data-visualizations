function(e){
  chartC = e //a DOM node object to control chart C
  app.chartC.DOMelement = chartC
  chartC.on("plotly_click",function(ev){
    console.log(ev)
    let country_name = ev.points[0].data.name
    let countryTrace = app.chartC.tracemap[country_name]
    clickHighlight(chartC, countryTrace-1, app.chartC.styleChange)
    clickHighlight(chartB, chartBtracemap[country_name]-1, app.chartB.styleChange)
    highlightTable(chartA, rowNumber)
    })
}

