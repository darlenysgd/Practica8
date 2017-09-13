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

    <script src="https://unpkg.com/dexie@latest/dist/dexie.js"></script>


    <script href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

    <script src="/JS/bootstrap.min.js"></script>

    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDO4AfhhN--MvSiUlJKWvxaCOcqOx-nSEk"
            type="text/javascript"></script>



</head>
<body>
<div id="custom-bootstrap-menu" class="navbar navbar-default " role="navigation">
    <div class="container-fluid">

        <div class="collapse navbar-collapse navbar-menubuilder">
            <ul class="nav navbar-nav navbar-left">
                <li><a href="/Formulario">Encuesta</a>
                </li>
                <li><a href="/Sincronizar">Sincronizar</a>
                </li>
                <li><a href="/infoServidor">Datos servidor</a>
            </ul>
        </div>
    </div>
</div>
<div class="row col-sm-18">
    <div class="panel panel-info" style="margin: 0 auto; width: 50%; margin-top: 20px;">
        <div class="panel-heading">Editar Entrada</div>
        <div class="panel-body">
            <form action="/nuevoRegistro" method="post" id="form">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label>Nombre</label>
                            <input type="text" class="input-sm form-control" id="nombre" name="nombre">
                        </div>
                        <div class="form-group">
                            <label>Sector</label>
                            <input type="text" class="input-sm form-control" id="sector" name="sector">
                        </div>
                        <div class="form-group">
                            <label>Nivel Escolar</label>
                            <select class="form-control" id="educacion" name="educacion">
                                <option>Basico</option>
                                <option>Medio</option>
                                <option>Grado</option>
                                <option>Universitario</option>
                                <option>Postgrado</option>
                                <option>Doctorado</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <input type="submit" id="btnSubmit" class="form-control" value="Editar">
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>

<script>

    $(document).ready(function(){



        //Dexie.delete('MyDatabase');

        var db = new Dexie('MyDatabase');
        var nombre;
        var sector;
        var lugar;
        var educacion;


        db.version(1)
                .stores({
                    encuesta: '++id, nombre, sector, educacion, lugar'
                });

        db.open()
                .catch(function (error) {
                    alert('Oh no! : ' + error);
                });

        db.encuesta.get(${id}, function (result) {
            document.getElementById('nombre').value  =  result.nombre;
            document.getElementById('sector').value = result.sector;

        });



        $("#form").on('submit', function (e) {
            e.preventDefault();

            nombre = $("#nombre").val();
            sector = $("#sector").val();
            educacion = $("#educacion").val();


            db.encuesta.update(${id}, {nombre: nombre, sector : sector, educacion : educacion }).then(function (updated) {
                if (updated)
                    alert("Editado correctamente");
                else
                    alert("Hubo un error al editar la entrada");
            });

            window.location.replace("http://localhost:4567/Sincronizar");

        });







    });
</script>


</html>