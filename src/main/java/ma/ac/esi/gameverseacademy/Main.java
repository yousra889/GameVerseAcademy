package ma.ac.esi.gameverseacademy;

import ma.ac.esi.gameverseacademy.controller.LoginController;
import ma.ac.esi.gameverseacademy.controller.LogoutController;
import ma.ac.esi.gameverseacademy.controller.ModController;
import ma.ac.esi.gameverseacademy.controller.ModSubmitController;
import ma.ac.esi.gameverseacademy.controller.ModDeleteController;
import ma.ac.esi.gameverseacademy.controller.ModEditController;
import ma.ac.esi.gameverseacademy.controller.ReviewAddController;
import ma.ac.esi.gameverseacademy.controller.ReviewDeleteController;
import ma.ac.esi.gameverseacademy.controller.ReviewEditController;
import ma.ac.esi.gameverseacademy.controller.ReviewListController;


import org.apache.catalina.Context;
import org.apache.catalina.startup.Tomcat;
import java.io.File;

public class Main {

    public static void main(String[] args) throws Exception {

        Tomcat tomcat = new Tomcat();
        tomcat.setPort(8080);
        tomcat.getConnector();

        String webappDir = new File("src/main/webapp").getAbsolutePath();
        Context ctx = tomcat.addWebapp("/GameVerseAcademy", webappDir);
        ctx.setParentClassLoader(Main.class.getClassLoader());

        Tomcat.addServlet(ctx, "LoginController", new LoginController()).setLoadOnStartup(1);
        ctx.addServletMappingDecoded("/LoginController", "LoginController");

        Tomcat.addServlet(ctx, "LogoutController", new LogoutController()).setLoadOnStartup(1);
        ctx.addServletMappingDecoded("/LogoutController", "LogoutController");
        
        Tomcat.addServlet(ctx, "ModController", new ModController()).setLoadOnStartup(1);
        ctx.addServletMappingDecoded("/mods", "ModController");
        
        Tomcat.addServlet(ctx, "ModSubmitController", new ModSubmitController()).setLoadOnStartup(1);
        ctx.addServletMappingDecoded("/ModSubmitController", "ModSubmitController");
        
        Tomcat.addServlet(ctx, "ModDeleteController", new ModDeleteController()).setLoadOnStartup(1);
        ctx.addServletMappingDecoded("/ModDeleteController", "ModDeleteController");

        Tomcat.addServlet(ctx, "ModEditController", new ModEditController()).setLoadOnStartup(1);
        ctx.addServletMappingDecoded("/ModEditController", "ModEditController");
        
        Tomcat.addServlet(ctx, "ReviewAddController", new ReviewAddController()).setLoadOnStartup(1);
        ctx.addServletMappingDecoded("/ReviewAddController", "ReviewAddController");

        Tomcat.addServlet(ctx, "ReviewDeleteController", new ReviewDeleteController()).setLoadOnStartup(1);
        ctx.addServletMappingDecoded("/ReviewDeleteController", "ReviewDeleteController");

        Tomcat.addServlet(ctx, "ReviewEditController", new ReviewEditController()).setLoadOnStartup(1);
        ctx.addServletMappingDecoded("/ReviewEditController", "ReviewEditController");

        Tomcat.addServlet(ctx, "ReviewListController", new ReviewListController()).setLoadOnStartup(1);
        ctx.addServletMappingDecoded("/reviews", "ReviewListController");

        
        tomcat.start();
        System.out.println(">>> http://localhost:8080/GameVerseAcademy");

        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            try { tomcat.stop(); tomcat.destroy(); }
            catch (Exception e) { e.printStackTrace(); }
        }));

        tomcat.getServer().await();
    }
}
