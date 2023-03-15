import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="trip-map"
export default class extends Controller {
  static values = {
      apiKey: String,
      markers: Array,
      currentMarkers: Array,
      photos: Array
    }

  connect() {
    console.log('coucuo je suis la trip map')
    this.routes = []
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/wissamlib/cleb8e6p1001501kn8vu764b6"
    })
    global.map = this.map
    this.map.on('load', () => {
      console.log('loaded map')
      this.#addMarkersToMap()
      this.#fitMapToMarkers()
      this.#setRoutes()
      this.#addPhotos()
      this.map.resize();
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

  #addPhotos() {
    this.photosValue.forEach((trip) => {
      trip.forEach((marker) => {
        const customMarker = document.createElement("div")
        customMarker.innerHTML = marker.photo_html
        new mapboxgl.Marker(customMarker)
          .setLngLat([ marker.lng, marker.lat ])
          .addTo(this.map)
      })
    })
    console.log('photos')
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.currentMarkersValue.forEach((marker) => {
      bounds.extend([ marker.lng, marker.lat ])
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
        if (end !== undefined) {
          geojsons.push(this.getRoute(start, end, i, trip.length))
          i += 1
        }
      })
    })
  }


  async getRoute(start, end, i, length) {
    const query = await fetch(
      `https://api.mapbox.com/directions/v5/mapbox/driving/${start[1]},${start[0]};${end[1]},${end[0]}?steps=true&geometries=geojson&access_token=${mapboxgl.accessToken}`
    );
    const json = await query.json();
    const data = json.routes[0];
    const route = data.geometry.coordinates;
    if (i === 1) {
      this.routes = []
    }

    this.routes.push(route)
    const geojson = {
      type: 'Feature',
      properties: {},
      geometry: {
        type: 'LineString',
        coordinates: this.routes.flat()
      }
    };
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

}
