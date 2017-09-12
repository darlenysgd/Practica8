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
<div class="row col-sm-12">
    <div class="panel panel-info" style="margin: 0 auto; width: 50%; margin-top: 20px;">
        <div class="panel-heading">Sincronizar</div>
        <div class="panel-body">
            <div id="listArea">

            </div>


        </div>
    </div>
</div>
</body>
<script>

    $(document).ready(function(){

        var db = new Dexie('MyDatabase');
        var ul=document.createElement('ul');

        db.version(1)
                .stores({
                    encuesta: '++id, nombre, sector, educacion, lugar'
                });


        db.open()
                .catch(function (error) {
                    alert('Oh no! : ' + error);
                });

      /*  db.encuesta.get(1, function (firstFriend) {
            alert ("Encuesta with id 1: " + JSON.stringify(firstFriend));
        });*/

        db.encuesta.orderBy("id")
                .reverse()
                .limit(3)
                .toArray()
                .then(function (results) {
                    console.log(JSON.stringify(results));
                    for(var i = 0; i < results.length; i++){

                        var li=document.createElement('li');
                        var botonEliminar = document.createElement('button');
                        botonEliminar.innerHTML="Eliminar";
                        botonEliminar.id = results[i].id;
                        botonEliminar.className = 'eliminar';
                        var botonEditar = document.createElement('button');
                        botonEditar.innerHTML = "Editar";
                        botonEditar.id = results[i].id;
                        botonEditar.className = 'editar';
                        var texto = document.createElement('h5');
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










    });
</script>

</html>