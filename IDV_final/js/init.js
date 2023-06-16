/* create global object: app */
var app = {};

/* chart A */
app.chartA = {}

/* chart B */
app.chartB = {}
app.chartB.styleChange = {
  "originalPositive": {
    "marker.color": "rgba(0,191,196,1)",
    "marker.size": 8,
    "marker.line.color": "rgba(0,191,196,1)",
    "marker.line.width": 0
  },
  "originalNegative": {
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
  targetTrace: null,
  pointY: null
}


/* chart C */
app.chartC = {}
app.chartC.styleChange = {
  "original": {
    "line.color": "rgba(204,204,204,0.3)"
  },
  "new": {
    "line.color": "#006ba2"
  },
  "targetTrace": null
}
