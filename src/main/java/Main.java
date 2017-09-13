import Entidades.Registro;
import freemarker.template.Configuration;

import spark.ModelAndView;
import spark.Spark;
import spark.template.freemarker.FreeMarkerEngine;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static spark.Spark.get;

import static spark.Spark.post;
import static spark.Spark.staticFiles;


/**
 * Created by darle on 9/5/2017.
 */
public class Main {

    private static ArrayList<Registro> registros = new ArrayList<>();

    public static void main(String[] args) {

        staticFiles.location("/");

        Configuration configuration = new Configuration(Configuration.VERSION_2_3_23);
        configuration.setClassForTemplateLoading(Main.class, "/Templates");
        FreeMarkerEngine freeMarkerEngine = new FreeMarkerEngine(configuration);


        get("/Formulario", (request, response) -> {

            Map<String, Object> attributes = new HashMap<>();
            return new ModelAndView(attributes, "Form.ftl");

        }, freeMarkerEngine);

        get("/infoServidor", (request, response) -> {

            Map<String, Object> attributes = new HashMap<>();
            return new ModelAndView(attributes, "infoServidor.ftl");

        }, freeMarkerEngine);

        get("/Sincronizar", (request, response) -> {

            Map<String, Object> attributes = new HashMap<>();
            return new ModelAndView(attributes, "sincronizarConServidor.ftl");

        }, freeMarkerEngine);


        get("/Editar/:id", (request, response) -> {

            Map<String, Object> attributes = new HashMap<>();
            int id = Integer.parseInt(request.params("id"));
            attributes.put("id", id);
            return new ModelAndView(attributes, "editar.ftl");

        }, freeMarkerEngine);




    }

}
