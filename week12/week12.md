
# leaflet

## Manuals 

  * R: <https://rstudio.github.io/leaflet/>
  * JS: <https://leafletjs.com/examples/quick-start/>

## leaflet for R

### Basic Usage

```r
library(leaflet)
m = leaflet() %>% setView(lng=121.5, lat=25.05, zoom=13) %>% addTiles()

m
```

### Add Markers

```r  
m %>% addMarkers(lng=121.5, lat=25.05, popup="Taipei")
```

## leaflet for JS

### init

```js
var leaflet = {}
```

### Basic Usage

Assume there is a `div` with id `map` in the html file.

```html
<div id="map"></div>
```

```js
var map = L.map('map').setView([25.05, 121.5], 13);
```

  * `L.map('map')` creates a map object and binds it to the `div` with id `map`.
  * setView: `[lat, lng], zoom` 

`L` is a global variable defined by the leaflet library.

### Add tiles

```js
L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: 19,
    attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
}).addTo(map);
```

### Add Provider Tiles 

  * <https://leaflet-extras.github.io/leaflet-providers/preview/>

  
```js
var CartoDB_Positron = L.tileLayer('https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png', {
	attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>',
	subdomains: 'abcd',
	maxZoom: 20
});
CartoDB_Positron.addTo(map)
```

### Add Markers

```js
let currentMarker = L.marker([25.05, 121.5]).addTo(map);
marker.bindPopup("Taipei");
```

### Add circle markers

   * https://leafletjs.com/reference.html#circlemarker

### popup 

   * Use `<a>` tag: https://www.w3schools.com/tags/tag_a.asp


# User GPS


```js
function successCallback(position){
  console.log(position);
  currentLocation = [position.coords.latitude, position.coords.longitude];
};

function errorCallback(error){
  console.log(error);
};

navigator.geolocation.getCurrentPosition(successCallback, errorCallback);
```

  * Reference: <https://developer.mozilla.org/en-US/docs/Web/API/Geolocation_API/Using_the_Geolocation_API>
  * in `init.js`


# Youbike 2.0

  * [新北市API](https://data.ntpc.gov.tw/openapi/swagger-ui/index.html?configUrl=%2Fapi%2Fv1%2Fopenapi%2Fswagger%2Fconfig&urls.primaryName=%E6%96%B0%E5%8C%97%E5%B8%82%E6%94%BF%E5%BA%9C%E4%BA%A4%E9%80%9A%E5%B1%80(80))
    * Youbike2.0 500 obs: <https://data.ntpc.gov.tw/api/datasets/010e5b15-3823-4b20-b401-b1cf000550c5/json?size=500>

  * [台北市API](https://tcgbusfs.blob.core.windows.net/dotapp/youbike/v2/youbike_immediate.json)

## data merge

To pass merged data to the flexdashboard, add the following code:
```r
ubikeMap = readRDS("ubikeMap.Rds")
htmltools::tags$script(
  id="youbike-data",
  type="application/json",
  ubikeMap$dataMerged[,c("lat","lng")] |> jsonlite::toJSON(auto_unbox = T)
)
```

# Github Desktop

  * copy the url of the repo
  * launch Github Desktop
  * Under `File` menu, choose `Clone repository`
  * Choose tab `URL`, paste the url, and choose the local path
  * click `Clone`
  

# JS knowledge

```js
if(leaflet.map){
  ...
}
```

  * `leaflet.map` is `true` if `leaflet.map` is not `undefined` or `null` or `false` or `0` or `NaN` or `""` (empty string)

```js
if(!leaflet.map){
  ...
}
```

  * `!leaflet.map` is `true` if `leaflet.map` is `undefined` or `null` or `false` or `0` or `NaN` or `""` (empty string)