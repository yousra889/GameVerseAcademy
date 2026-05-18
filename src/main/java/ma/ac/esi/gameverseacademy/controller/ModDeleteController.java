package ma.ac.esi.gameverseacademy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ma.ac.esi.gameverseacademy.service.ModService;

import java.io.IOException;

/**
 * Servlet implementation class ModDeleteController
 */
@WebServlet("/ModDeleteController")
public class ModDeleteController extends HttpServlet {

    private ModService modService = new ModService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Vérifier la session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/index.html");
            return;
        }

        // 2. Récupérer l'id
        int id = Integer.parseInt(request.getParameter("id"));

        // 3. Appeler le service
        modService.deleteMod(id);

        // 4. Rediriger vers la liste
        response.sendRedirect(request.getContextPath() + "/mods");
    }
    
    @Override
    public void init() {
        System.out.println("ModDeleteController LOADED");
    }

}