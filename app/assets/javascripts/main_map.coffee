$ ->

  initialize = ()->

    console.log()
    mapElement = document.getElementById('main-map')
    if mapElement
      mapOptions =
        zoom: 6

      map = new google.maps.Map(mapElement, mapOptions)

      addMarker = (item)->
        marker = new google.maps.Marker
          position: new google.maps.LatLng(item.latitude, item.longitude)
          map: map
          title: item.address
        google.maps.event.addListener marker, 'click', ()->
          console.log(item)
          $('#show-note').attr('href', "locations/#{item.id}")
          $('#edit-note').attr('href', "locations/#{item.id}/edit")
          $('#destroy-note').attr('href', "locations/#{item.id}")
          $('#modal-sm').modal()

      if navigator.geolocation
        navigator.geolocation.getCurrentPosition (position)->
         map.setCenter(new google.maps.LatLng(position.coords.latitude, position.coords.longitude))

      $.ajax(
        url: '/locations'
        dataType: 'json'
        success: (items)->
          for item in items
            addMarker(item)
        error: (err)->
          console.log(err)
      )


  initialize()
