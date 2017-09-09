<!DOCTYPE html>
<html>
<head>

    <meta name="viewport" content="width=device-width, initial-scale=1.0" charset="utf-8">
    <title>Practica 8</title>

    <link rel="stylesheet" href="/CSS/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/CSS/font-awesome.min.css">
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300,600|Raleway:600,300|Josefin+Slab:400,700,600italic,600,400italic' rel='stylesheet' type='text/css'>

    <script href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/js/bootstrap-select.min.js"></script>
    <script href="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-form-validator/2.3.26/jquery.form-validator.min.js"></script>
    <script  src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>


    <script src="/JS/jquery.min.js"></script>
    <script href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

    <script src="/JS/bootstrap.min.js"></script>

    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDO4AfhhN--MvSiUlJKWvxaCOcqOx-nSEk&callback=initMap"
            type="text/javascript"></script>
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=true"></script>

    <style>
        #mapdiv {
            margin: 0;
            padding: 0;
            width: 500px;
            height: 500px;
        }
    </style>
</head>
<body onload="geoloc()">
    <div class="row col-sm-12">
        <div class="panel panel-info" style="margin: 0 auto; width: 50%; margin-top: 20px;">
            <div class="panel-heading">Encuesta OP</div>
            <div class="panel-body">
                <div class="row">
                   <div class="col-sm-6">
                       <div class="form-group">
                           <label>Nombre</label>
                           <input type="text">
                       </div>
                       <div class="form-group">
                           <label>Sector</label>
                           <input type="text">
                       </div>
                       <div class="form-group">
                           <label>Nivel Escolar</label>
                           <select>
                               <option>Basico</option>
                               <option>Medio</option>
                               <option>Grado</option>
                               <option>Universitario</option>
                               <option>Postgrado</option>
                               <option>Doctorado</option>
                           </select>
                       </div>
                       <div class="form-group">
                           <p id = 'mapdiv'></p>
                       </div>
                   </div>
                </div>
            </div>
        </div>
    </div>
</body>



<script>
    var watchId = null;
    function geoloc() {
        if (navigator.geolocation) {
            var optn = {
                enableHighAccuracy : true,
                timeout : Infinity,
                maximumAge : 0
            };
            watchId = navigator.geolocation.watchPosition(showPosition, showError, optn);
        } else {
            alert('Geolocation is not supported in your browser');
        }
    }

    function showPosition(position) {
        var googlePos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);


        var latlng = String(position.coords.latitude)+","+String(position.coords.longitude);

        var url = "http://maps.googleapis.com/maps/api/geocode/json?latlng=" + latlng + "&sensor=false";
        $.getJSON(url, function (data) {

                    var adress = data.results[1].formatted_address;
                    document.getElementById("lugar").value = adress;
                }
        )

        var mapOptions = {
            zoom : 12,
            center : googlePos,
            mapTypeId : google.maps.MapTypeId.ROADMAP
        };
        var mapObj = document.getElementById('mapdiv');
        var googleMap = new google.maps.Map(mapObj, mapOptions);
        var markerOpt = {
            map : googleMap,
            position : googlePos,
            title : 'Hi , I am here',
            animation : google.maps.Animation.DROP
        };
        var googleMarker = new google.maps.Marker(markerOpt);
        var geocoder = new google.maps.Geocoder();
        geocoder.geocode({
            'latLng' : googlePos
        }, function(results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                if (results[1]) {
                    var popOpts = {
                        content : results[1].formatted_address,
                        position : googlePos
                    };
                    var popup = new google.maps.InfoWindow(popOpts);
                    google.maps.event.addListener(googleMarker, 'click', function() {
                        popup.open(googleMap);
                    });
                } else {
                    alert('No results found');
                }
            } else {
                alert('Geocoder failed due to: ' + status);
            }
        });
    }



    function showError(error) {
        var err = document.getElementById('mapdiv');
        switch(error.code) {
            case error.PERMISSION_DENIED:
                err.innerHTML = "User denied the request for Geolocation."
                break;
            case error.POSITION_UNAVAILABLE:
                err.innerHTML = "Location information is unavailable."
                break;
            case error.TIMEOUT:
                err.innerHTML = "The request to get user location timed out."
                break;
            case error.UNKNOWN_ERROR:
                err.innerHTML = "An unknown error occurred."
                break;
        }
    }

</script>
</html>