# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  init = ()->
    $locationAddress = $("#location_address")

    if $locationAddress.length
      options =
        zoom: 7
        map: '#map'
        details: "#new_location, #edit_location"
        detailsAttribute: "data-geo"
        mapTypeId: google.maps.MapTypeId.ROADMAP
        mapOptions: { scrollwheel: true }
        markerOptions: {
          draggable: true
        }

      $locationAddress.geocomplete(options)

      $locationAddress.on "geocode:dragged", (event, latLng)->
        $("input[data-geo='lat']").val(latLng.lat())
        $("input[data-geo='lng']").val(latLng.lng())
        geocoder = new google.maps.Geocoder()
        lat = latLng.lat()
        lng = latLng.lng()
        latlng = new google.maps.LatLng(lat, lng)
        geocoder.geocode({ 'latLng': latlng }, (results, status)->
          result = results[0]
          if result.formatted_address
            $locationAddress.val(result.formatted_address)
        )

      $locationAddress.on 'geocode:click', (event, latLng)->
        $locationAddress.geocomplete("find", latLng.toString())

      if $locationAddress.val().length > 0
        lat = $("input[data-geo='lat']").val()
        lng = $("input[data-geo='lng']").val()
        lat_and_long = "#{lat}, #{lng}"
        $locationAddress.geocomplete("find", lat_and_long)
      else if navigator.geolocation
        navigator.geolocation.getCurrentPosition (position)->
          lat_and_long = "#{position.coords.latitude}, #{position.coords.longitude}"
          $locationAddress.geocomplete("find", lat_and_long)

  $('#modal-lg').on 'shown.bs.modal', ->
    init()

  $('#modal-lg').on 'hidden.bs.modal', ()->
    $(this).removeData('bs.modal')

  init()