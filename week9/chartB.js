function(e){
  chartB = e //a DOM node object to control chart B

  chartB.on("plotly_click",function(ev){
    console.log(ev)
    let countryPicked = ev.points[0].x
    let countryTrace = chartBtracemap[countryPicked][0]
    styleChangeInB = clickHighlight(chartB, countryTrace-1, styleChangeInB)
    styleChangeInC = clickHighlight(chartC, chartCtracemap[countryPicked][0]-1, styleChangeInC)
  })
}
