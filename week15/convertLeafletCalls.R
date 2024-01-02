m$x$calls[[2]]$method
callx = m$x$calls[[2]]
callx$method <- ""
switch(
  callx$method,
  "addCircleMarkers"={
    "hi"
  },
  "addMarkers"={
    "hi2"
  },
  {
    "unsupported"
  }
)
