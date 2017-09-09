<!DOCTYPE html>
<html>
<head>

    <meta name="viewport" content="width=device-width, initial-scale=1.0" charset="utf-8">
    <title>Practica 8</title>


    <link rel="stylesheet" href="/CSS/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/CSS/font-awesome.min.css">
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300,600|Raleway:600,300|Josefin+Slab:400,700,600italic,600,400italic' rel='stylesheet' type='text/css'>
    <script src="/JS/jquery.min.js"></script>
    <script href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/js/bootstrap-select.min.js"></script>

    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-form-validator/2.3.26/jquery.form-validator.min.js"></script>




    <script href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

    <script src="/JS/bootstrap.min.js"></script>

    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDO4AfhhN--MvSiUlJKWvxaCOcqOx-nSEk"
            type="text/javascript"></script>


    <style>
        #mapdiv {
            margin: 0;
            padding: 0;
            width: 200px;
            height: 200px;
        }
    </style>
</head>
<body onload="geoloc()">
    <div class="row col-sm-12">
        <div class="panel panel-info" style="margin: 0 auto; width: 50%; margin-top: 20px;">
            <div class="panel-heading">Encuesta OP</div>
            <div class="panel-body">
                <form action="/nuevoRegistro" method="post" id="form">
                    <div class="row">
                       <div class="col-sm-4">
                           <div class="form-group">
                               <label>Nombre</label>
                               <input type="text" class="input-sm" name="nombre">
                           </div>
                           <div class="form-group">
                               <label>Sector</label>
                               <input type="text" class="input-sm" name="sector">
                           </div>
                           <div class="form-group">
                               <label>Nivel Escolar</label>
                               <select name="educacion">
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
                               <input type="text" id="lugar" name="lugar" hidden>

                           </div>
                           <div class="form-group">
                               <input type="submit" id="btnSubmit" class="form-control" value="Registrar">
                           </div>
                       </div>
                    </div>
                </form>
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

    function initMap() {console.log("ok");}

    function showPosition(position) {
        var googlePos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);

        var latlng = String(position.coords.latitude)+","+String(position.coords.longitude);

        document.getElementById("lugar").value = latlng;

        var url = "http://maps.googleapis.com/maps/api/geocode/json?latlng=" + latlng + "&sensor=false";
        $.getJSON(url, function (data) {


                    //document.getElementById("lugar").value = data.results[1].formatted_address;
                }
        );

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