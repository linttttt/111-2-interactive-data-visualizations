function handleChartCHoverCancel() {

    // resume original styleChange
    Plotly.restyle(
        app.chartC.DOM.plotly,
        app.chartC.styleChange.original
    )

}

function graphChartA() {
    let $tr = app.chartA.DOM.trs
    for (let i = 0; i < $tr.length; i++) {
        let targetTds = $tr[i].querySelectorAll("td")

        let countryName = targetTds[1].innerText
        let targetGraphDOM = targetTds[2]

        Plotly.react(
            targetGraphDOM,
            app.chartA.templateData.data[countryName],
            app.chartA.templateData.layout,
            app.chartA.templateData.config
        )
    }
}

function handleChartBPlotlyClick(ev) {
    console.log(ev)
    let countryPicked = ev.points[0].x
    let countryTrace = app.chartB.tracemap[countryPicked]

    app.chartB.styleChange = clickHighlight_B(
        app.chartB.DOM.plotly,
        countryTrace - 1,
        app.chartB.styleChange)
    app.chartC.styleChange = clickHighlight(
        app.chartC.DOM.plotly,
        app.chartC.tracemap[countryPicked] - 1,
        app.chartC.styleChange)
}
function handleChartCPlotlyClick(ev) {
    console.log(ev)
    let countryPicked = ev.points[0].data.name
    let countryTrace = app.chartC.tracemap[countryPicked]

    if (app.chartB.tracemap[countryPicked]) {

        app.chartC.styleChange = clickHighlight(
            app.chartC.DOM.plotly,
            countryTrace - 1,
            app.chartC.styleChange)
        app.chartB.styleChange = clickHighlight_B(
            app.chartB.DOM.plotly,
            app.chartB.tracemap[countryPicked] - 1,
            app.chartB.styleChange)
    }

}
function clickHighlight(chart, trace, styleChange) {

    if (styleChange.targetTrace) {
        Plotly.restyle(
            chart,
            styleChange.original,
            styleChange.targetTrace
        )
    }

    styleChange.targetTrace = trace

    Plotly.restyle(
        chart,
        styleChange.new,
        styleChange.targetTrace
    )
    return (styleChange)
}
function clickHighlight_B(chart, trace, styleChange) {

    if (styleChange.targetTrace && styleChange.pointY <= 0) {

        Plotly.restyle(
            chart,
            styleChange.originalNegative,
            styleChange.targetTrace
        )
    } else if (styleChange.targetTrace && styleChange.pointY > 0) {

        Plotly.restyle(
            chart,
            styleChange.originalPositive,
            styleChange.targetTrace
        )
    }

    styleChange.targetTrace = trace
    styleChange.pointY = app.chartB.DOM.plotly.getElementsByClassName("trace scatter trace")[styleChange.targetTrace].__data__[0].y
    //console.log(styleChange.pointY)    

    Plotly.restyle(
        chart,
        styleChange.new,
        styleChange.targetTrace
    )
    return (styleChange)
}

function chartBredraw(date) {
    Plotly.react(app.chartB.DOM.plotly,
        app.chartB.dataLayoutConfig[date].data,
        app.chartB.dataLayoutConfig[date].layout,
        app.chartB.dataLayoutConfig[date].config)
}

function handleDropdownMenuChange(ev) {
    console.log(ev)
    let date = ev.target.value
    updateChartBTraceMap(date)
    chartBredraw(date)
}
function updateChartBTraceMap(date) {

    const traceData = app.chartB.dataLayoutConfig[date].data

    var traceMap = {}
    traceData.forEach((d, t) => {
        traceMap[d.name] = t + 1
    })
    app.chartB.tracemap = traceMap
}
