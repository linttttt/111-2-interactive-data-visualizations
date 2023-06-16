//chartBMap = document.getElementById("chartB-tracemap")
//var chartBtracemap = JSON.parse(chartBMap.textContent)
var app = Object()
// initiate chart A, B, C interfaces
app.chartA = Object()
app.chartB = Object()
app.chartC = Object()

//chart C
// chartC-tracemap
chartCMap = document.getElementById("chartC-tracemap")
var chartCtracemap = JSON.parse(chartCMap.textContent)
app.chartC.tracemap = chartCtracemap

//chart B
// dataLayoutConfig
chartBxJson = document.getElementById("chartB-x")
var chartBdataLayoutConfig = JSON.parse(chartBxJson.textContent)
app.chartB.dataLayoutConfig = chartBdataLayoutConfig
// trace map
app.chartB.tracemap = Object()
allDates = Object.keys(app.chartB.dataLayoutConfig)
allDates.forEach(date =>{
    app.chartB.tracemap[date] = createTraceMapForADate(date)
})

function createTraceMapForADate(date){
    var chartData = app.chartB.dataLayoutConfig[date].data
    var chartMapping = Object()

    // Global environment object is mutable within a function in JS
    chartData.forEach((x, i)=>{
        chartMapping[x.name] = i
    })
    return chartMapping
}

// styleChange
/* chart B */
app.chartB.styleChange = {
    "original": {
          "marker.color": "rgba(248,118,109,1)",
          "marker.size": 8,
          "marker.line.color": "rgba(248,118,109,1)",
          "marker.line.width": 0
      },
    "new": {
              "marker.color": "#006ba2",
              "marker.size": 10,
              "marker.line.color": "#006ba2",
              "marker.line.width": 1.8
      },
    "targetTrace": null
}

/* chart C */
app.chartC.styleChange = {
    "original": {
      "line.color": "rgba(204,204,204,0.3)"},
    "new": {
      "line.color": "#006ba2"},
    "targetTrace": null
}


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
    //return(styleChange)
}

function chartBredraw(date){
  Plotly.react(chartBelement,
             chartBdataLayoutConfig[date].data,
             chartBdataLayoutConfig[date].layout,
             chartBdataLayoutConfig[date].config)
}

document.addEventListener('DOMContentLoaded', function () {
  // do something here ...
  // chart B's graph DOM object
  chartBelement = document.getElementById("widget-chartB")
  // chart B's dropdown menu DOM object
  chartBSelect = document.getElementById("plotly-select")
  // chart B's dropdown on change, then do chartBredraw
  chartBSelect.onchange=function(){
    createChartBMapping(chartBdataLayoutConfig[chartBSelect.value].data)
    chartBredraw(chartBSelect.value)
  };


  chartB.on("plotly_click",function(ev){
    console.log(ev)
    let countryPicked = ev.points[0].x
    // new trace map does not require [0] at the end
    //let countryTrace = chartBtracemap[countryPicked][0]
    let countryTrace = app.chartB.tracemap[countryPicked]
    console.log([countryPicked, countryTrace])
    clickHighlight(chartB, countryTrace-1, app.chartB.styleChange)
    clickHighlight(chartC, app.chartC.tracemap[countryPicked]-1, app.chartC.styleChange)
  })


}, false);


function createTracemap(chartData){
  var tracemap = Object();

  // Object is mutable within a function in JS
  chartData.map((x, i)=>{
    tracemap[x.name] = i
  })
  return(tracemap)
}
