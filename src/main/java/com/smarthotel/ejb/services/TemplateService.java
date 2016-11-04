package com.smarthotel.ejb.services;

import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;
import org.apache.velocity.runtime.RuntimeConstants;
import org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader;

import java.io.StringWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Properties;
import java.util.Set;

public class TemplateService {

    private String templateName;
    private HashMap<String, Object> params;
    private String templatePath = "./tmpl/";

    public TemplateService(String templateName) {
        this.templateName = templateName;
    }

    public TemplateService(String templateName, HashMap<String, Object> params) {
        this.templateName = templateName;
        this.params = params;
    }

    public String renderTemplate(){
        VelocityEngine velocityEngine = new VelocityEngine();

        Properties velocityProperties = new Properties();
        velocityProperties.setProperty(RuntimeConstants.RESOURCE_LOADER, "classpath");
        velocityProperties.setProperty("classpath.resource.loader.class", ClasspathResourceLoader.class.getName());
        velocityProperties.put("class.resource.loader.description", "Velocity Classpath Resource Loader");
        velocityProperties.put("class.resource.loader.class",
                "org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader");
        velocityEngine.init(velocityProperties);

        Template t = velocityEngine.getTemplate(getTemplatePath() + this.templateName);
        VelocityContext context = new VelocityContext();


        if(this.params != null){
            Set<String> paramsSet = this.params.keySet();
            Iterator<String> iterator = paramsSet.iterator();
            while (iterator.hasNext()){
                String key = iterator.next();
                context.put(key, this.params.get(key));
            }
        }

        StringWriter writer = new StringWriter();
        t.merge( context, writer );

        return writer.toString();
    }

    public static void main(String[] args) {
        HashMap<String, Object> params = new HashMap<String, Object>(){
            {
                put("name","Alexey Chusta");
            }
        };
        TemplateService templateService = new TemplateService("helloworld.vm", params);
        System.out.println(templateService.renderTemplate());
//        /*  first, get and initialize an engine  */
//        VelocityEngine ve = new VelocityEngine();
//        ve.init();
//        /*  next, get the Template  */
//        Template t = ve.getTemplate( "/src/resources/tmpl/helloworld.vm" );
//        /*  create a context and add data */
//        VelocityContext context = new VelocityContext();
//        context.put("name", "Volodymyr Mordas");
//        /* now render the template into a StringWriter */
//        StringWriter writer = new StringWriter();
//        t.merge( context, writer );
//        /* show the World */
//        System.out.println( writer.toString() );
    }

    public String getTemplatePath() {
        return templatePath;
    }

    public void setTemplatePath(String templatePath) {
        this.templatePath = templatePath;
    }
}
