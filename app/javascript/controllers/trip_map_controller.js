import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="trip-map"
export default class extends Controller {
  static values = {
      apiKey: String,
      markers: Array
    }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/wissamlib/cleb8e6p1001501kn8vu764b6"
    })
    global.map = this.map
    this.map.on('load', () => {
      this.#addMarkersToMap()
      this.#fitMapToMarkers()
      this.#setRoutes()
    })
  }

  #addMarkersToMap() {
    this.markersValue.forEach((trip) => {
      trip.forEach((marker) => {
        const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)
        new mapboxgl.Marker()
          .setLngLat([ marker.lng, marker.lat ])
          .setPopup(popup)
          .addTo(this.map)
      })
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach((trip) => {
      trip.forEach((marker) => {
        bounds.extend([ marker.lng, marker.lat ])
      })
    })
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 3 })
  }

  #setRoutes() {
      // create a function to make a directions request
    this.markersValue.forEach((trip) => {
      let coords = [];
      trip.forEach((marker) => {
        coords.push([marker.lat, marker.lng])
      })
      console.log(coords)
      trip.forEach((marker, index) => {
        const start = coords[index]
        const end = coords[index + 1]
        console.log(`start: ${start}, end: ${end}`)
        this.getRoute(start, end)
      })
    })
  }


  async getRoute(start, end) {
    // make a directions request using cycling profile
    // an arbitrary start will always be the same
    // only the end or destination will change
    console.log(`https://api.mapbox.com/directions/v5/mapbox/cycling/${start[1]},${start[0]};${end[1]},${end[0]}?steps=true&geometries=geojson&access_token=${mapboxgl.accessToken}`)
    const query = await fetch(
      `https://api.mapbox.com/directions/v5/mapbox/driving/${start[1]},${start[0]};${end[1]},${end[0]}?steps=true&geometries=geojson&access_token=${mapboxgl.accessToken}`
    );
    const json = await query.json();
    const data = json.routes[0];
    const route = data.geometry.coordinates;
    console.log(route)
    const geojson = {
      type: 'Feature',
      properties: {},
      geometry: {
        type: 'LineString',
        coordinates: route
      }
    };
    // if the route already exists on the map, we'll reset it using setData
    if (this.map.getSource('route')) {
      this.map.getSource('route').setData(geojson);
    }
    // otherwise, we'll make a new request
    else {
      this.map.addLayer({
        id: 'route',
        type: 'line',
        source: {
          type: 'geojson',
          data: geojson
        },
        layout: {
          'line-join': 'round',
          'line-cap': 'round'
        },
        paint: {
          'line-color': '#3887be',
          'line-width': 5,
          'line-opacity': 0.75
        }
      });
    }
    // add turn instructions here at the end
  }
}

// -------------------------------------------------------------

// #setRoutes() {
//       // create a function to make a directions request
//     this.markersValue.forEach((trip) => {
//       let coord = "";
//       trip.forEach((marker, index) => {
//         coord += marker.lat + ',' + marker.lng + ';'
//         // if (trip[index + 1] !== null) {
//         //   const start = [marker.lat, marker.lng]
//         //   const end = [trip[index + 1].lat, trip[index + 1].lng]
//         //   this.getRoute(start, end)
//         // }
//       })
//     coord = coord.slice(0, -1)
//     this.getRoute(coord)
//     })
//   }


//   async getRoute(coord) {
//     // make a directions request using cycling profile
//     // an arbitrary start will always be the same
//     console.log(coord)
//     // only the end or destination will change
//     const query = await fetch(
//       `https://api.mapbox.com/directions/v5/mapbox/cycling/${coord}?steps=true&geometries=geojson&access_token=${mapboxgl.accessToken}`
//       // `https://api.mapbox.com/directions/v5/mapbox/cycling/${start[0]},${start[1]};${end[0]},${end[1]}?steps=true&geometries=geojson&access_token=${mapboxgl.accessToken}`
//     );
//     const json = await query.json();
//     const data = json.routes[0];
//     const route = data.geometry.coordinates;
//     console.log(route)
//     const geojson = {
//       type: 'Feature',
//       properties: {},
//       geometry: {
//         type: 'LineString',
//         coordinates: route
//       }
//     };
//     // if the route already exists on the map, we'll reset it using setData
//     if (this.map.getSource('route')) {
//       this.map.getSource('route').setData(geojson);
//     }
//     // otherwise, we'll make a new request
//     else {
//       this.map.addLayer({
//         id: 'route',
//         type: 'line',
//         source: {
//           type: 'geojson',
//           data: geojson
//         },
//         layout: {
//           'line-join': 'round',
//           'line-cap': 'round'
//         },
//         paint: {
//           'line-color': '#3887be',
//           'line-width': 5,
//           'line-opacity': 0.75
//         }
//       });
//     }
//     // add turn instructions here at the end
//   }
