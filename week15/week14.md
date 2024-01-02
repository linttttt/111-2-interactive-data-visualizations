
# Task

  * Find the closest **five** youbike stations to your current location

## Find current location

```js
// Given two points, compute the distance between them
function distance(p1, p2) {
  return Math.sqrt(
    Math.pow(p1.lat - p2.lat, 2) + Math.pow(p1.lng - p2.lng, 2)
  );
}
```

## Compute station distance from current location

```js
distance(currentLocation,positionX)
```

Compute each distance from an array of stations

```js
var stationDistances = stations.map(function(x){
  return distance(currentLocation,x);
});
```
This is the same as using the following for loop:
  
  ```js
  var stationDistances = [];
  for(var i=0; i<stations.length; i++){
    // in R
    // stationDistances[i] = distance(currentLocation,stations[i]);
    // in JS/Python
    stationDistances.push(distance(currentLocation,stations[i]));
  }
  ```

To find the closest station, we need to find the minimum distance from the array of distances.

```js
var minDistance = Math.min(...stationDistances);
```

Then we need to find the index of the minimum distance.

```js
var minIndex = stationDistances.indexOf(minDistance);
```

## Find the closest 5 stations


### Method 1: for loop

  ```js
  var min5 = [];
  for(var i=0; i<5; i++){
    var minDistance = Math.min(...stationDistances);
    var minIndex = stationDistances.indexOf(minDistance);
    min5.push(stations[minIndex]);
    stationDistances.splice(minIndex,1);
    stations.splice(minIndex,1);
  }
  ```

### Method 2: sort

  ```js
  var sorted = stationDistances.toSorted();
  var min5 =  [0,1,2,3,4].map(function(x){
    let stationIndex = 
     stationDistances.indexOf(sorted[x]);
    return stations[stationIndex];
  })
  ``` 

## Find the closest station

```js
