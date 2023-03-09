import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="trip-map"
export default class extends Controller {
  static values = {
      apiKey: String,
      markers: Array
    }

  connect() {
    this.routes = []
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/ddlire/clerc593f00i801lk3homtmek"
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
      let i = 1
      let geojsons = [];
      trip.forEach((marker, index) => {
        const start = coords[index]
        const end = coords[index + 1]
        // console.log(`start: ${start}, end: ${end}`)
        if (end !== undefined) {
          geojsons.push(this.getRoute(start, end, i, trip.length))
          i += 1
        }
        // routes.forEach((route) => consoleLog(route));
      })
      // console.log(routes)
      // this.#addLayer(geojsons, i);
    })
  }


  async getRoute(start, end, i, length) {
    console.log(i)
    // console.log(`https://api.mapbox.com/directions/v5/mapbox/cycling/${start[1]},${start[0]};${end[1]},${end[0]}?steps=true&geometries=geojson&access_token=${mapboxgl.accessToken}`)
    const query = await fetch(
      `https://api.mapbox.com/directions/v5/mapbox/driving/${start[1]},${start[0]};${end[1]},${end[0]}?steps=true&geometries=geojson&access_token=${mapboxgl.accessToken}`
    );
    const json = await query.json();
    const data = json.routes[0];
    const route = data.geometry.coordinates;
    // console.log(route)
    if (i === 1) {
      this.routes = []
    }

    this.routes.push(route)
    console.log("ok")
    const geojson = {
      type: 'Feature',
      properties: {},
      geometry: {
        type: 'LineString',
        coordinates: this.routes.flat()
      }
    };
    console.log(length - 1  )
    if (i === (length - 1)) {

      if (this.map.getSource(`route${i}`)) {
        this.map.getSource(`route${i}`).setData(geojson);
      }
      // otherwise, we'll make a new request
      else {
        this.map.addLayer({
          id: `route${i}`,
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
    }
  }

   #addLayer (geojsons, i) {
    // const routex = routes.flat(2)
    // routes = routes.flat()
    // console.log(routes)
    // const geojson = {
    //   type: 'Feature',
    //   properties: {},
    //   geometry: {
    //     type: "MultiLineString",
    //     coordinates: routes
    //   }
    // };
    // console.log(geojson)
    if (this.map.getSource(`route${i}`)) {
      this.map.getSource(`route${i}`).setData(geojsons);
    }
    // otherwise, we'll make a new request
    else {
      this.map.addLayer({
        id: `route${i}`,
      type: 'line',
      source: {
        type: 'geojson',
        data: geojsons
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
  }
}
