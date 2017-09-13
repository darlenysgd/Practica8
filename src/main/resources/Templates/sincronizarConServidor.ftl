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
    <script src="/JS/everest.min.js"></script>


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
<div class="row col-sm-12">
    <div class="panel panel-info" style="margin: 0 auto; width: 50%; margin-top: 20px;">
        <div class="panel-heading">Sincronizar</div>
        <div class="panel-body">
            <div id="listArea">

            </div>


        </div>
        <button id="sync" class="form-control btn btn-primary">Sincronizar</button>
    </div>

</div>
</body>
<script>

    $(document).ready(function(){

        var db = new Dexie('MyDatabase');
        var ul=document.createElement('ul');
        ul.className = "list-group"


        db.version(1)
                .stores({
                    encuesta: '++id, nombre, sector, educacion, lugar'
                });


        db.open()
                .catch(function (error) {
                    alert('Oh no! : ' + error);
                });


        db.encuesta.orderBy("id")
                .toArray()
                .then(function (results) {
                    console.log(JSON.stringify(results));
                    for(var i = 0; i < results.length; i++){

                        var li=document.createElement('li');
                        li.className = "list-group-item";
                        var botonEliminar = document.createElement('button');
                        botonEliminar.innerHTML="Eliminar";
                        botonEliminar.id = results[i].id;
                        botonEliminar.className = 'eliminar btn btn-danger';
                        var botonEditar = document.createElement('button');
                        botonEditar.innerHTML = "Editar";
                        botonEditar.id = results[i].id;
                        botonEditar.className = 'editar btn btn-success';
                        var texto = document.createElement('p');
                        texto.innerHTML=results[i].nombre+ " " + results[i].sector+ " " + results[i].educacion+ " " + results[i].lugar;
                        li.id= results[i].id;
                        li.appendChild(texto);
                        li.appendChild(botonEliminar);
                        li.appendChild(botonEditar);

                        ul.appendChild(li);


                    }

                    document.getElementById('listArea').appendChild(ul);
                    //parsear datos y mostrarlos en la pagina
                });



        if (!navigator.onLine) {

              alert("No hay internet disponible para sincronizar");

            }


        $(document).on('click', '.eliminar', function(){
            var esto = this;

            db.encuesta.delete(this.id);

             db.encuesta.where("id").equals(this.id).delete();


            var list = document.getElementById(this.id);   // Get the <ul> element with id="myList"
            list.parentNode.removeChild(list);



        });

        $(document).on('click', '.editar', function(){
            window.location.replace("http://localhost:4567/Editar/"+this.id);


        });

        var restClient = ê.createRestClient({
            host: "localhost:1234"

        });

        $(document).on('click', '#sync', function(){
            db.encuesta.orderBy("id")
                    .toArray()
                    .then(function (results) {
                        restClient.create("/listadoBD", results).done(function (response) {
                            alert("Sincronizado Correctamente");
                            Dexie.delete('MyDatabase');
                            location.reload();

                            }).fail(function () {
                           alert("Error al sincronizar");
                        });


                    });


        });





    });
</script>

</html>