import freemarker.template.Configuration;

import spark.ModelAndView;
import spark.Spark;
import spark.template.freemarker.FreeMarkerEngine;

import java.util.HashMap;
import java.util.Map;

import static spark.Spark.get;

import static spark.Spark.staticFiles;


/**
 * Created by darle on 9/5/2017.
 */
public class Main {

    public static void main(String[] args) {

        staticFiles.location("/");

        Configuration configuration = new Configuration(Configuration.VERSION_2_3_23);
        configuration.setClassForTemplateLoading(Main.class, "/Templates");
        FreeMarkerEngine freeMarkerEngine = new FreeMarkerEngine(configuration);


        get("/Formulario", (request, response) -> {

            Map<String, Object> attributes = new HashMap<>();
            return new ModelAndView(attributes, "Form.ftl");

        }, freeMarkerEngine);

    }

}
