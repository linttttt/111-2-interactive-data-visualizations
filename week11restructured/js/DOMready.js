document.addEventListener('DOMContentLoaded', function () {

  let chartBMap = document.getElementById("chartB-tracemap")
  app.chartB.tracemap = JSON.parse(chartBMap.textContent)

  let chartCMap = document.getElementById("chartC-tracemap")
  app.chartC.tracemap = JSON.parse(chartCMap.textContent)
  // var chartCtracemap = JSON.parse(chartCMap.textContent)

  let chartBxJson = document.getElementById("chartB-x")
  app.chartB.dataLayoutConfig = JSON.parse(chartBxJson.textContent)
  // var chartBdataLayoutConfig = JSON.parse(chartBxJson.textContent)

  // chart B's graph DOM object
  app.chartB.DOM = {}
  app.chartB.DOM.plotly = document.getElementById("widget-chartB")

  // chart B's dropdown menu DOM object
  app.chartB.DOM.dropdownMenu = document.getElementById("plotly-select")

  // chart C's graph DOM object
  app.chartC.DOM = {}
  app.chartC.DOM.plotly = document.getElementById("widget-chartC")


  let chartATemplate = document.getElementById("chartA-template")
  app.chartA.templateData = JSON.parse(chartATemplate.textContent)
  // chart A's graph DOM object
  let chartA = document.getElementById("widget-chartA")

  app.chartA.DOM = {}
  app.chartA.DOM.trs = chartA.querySelectorAll("tbody tr")
  //interactions
  // chart A graph

  // chart B's dropdown on change, then do chartBredraw
  app.chartB.DOM.dropdownMenu.onchange = handleDropdownMenuChange

  // chart B click highlight
  app.chartB.DOM.plotly.on("plotly_click", handleChartBPlotlyClick)

  // chart C click highlight
  app.chartC.DOM.plotly.on("plotly_click", handleChartCPlotlyClick)

  //app.chartC.DOM.plotly.onmouseleave = handleChartCHoverCancel

}
  , false);

app.chartC.DOM.plotly.onmouseleave = handleChartCHoverCancel

