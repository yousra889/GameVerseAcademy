package ma.ac.esi.gameverseacademy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ma.ac.esi.gameverseacademy.model.Mod;
import ma.ac.esi.gameverseacademy.service.ModService;

import java.io.IOException;


@WebServlet("/ModEditController")
public class ModEditController extends HttpServlet {

    private ModService modService = new ModService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/index.html");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));
        Mod mod = modService.getModById(id);
        request.setAttribute("mod", mod);
        request.getRequestDispatcher("/editMod.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/index.html");
            return;
        }

        Mod mod = new Mod();
        mod.setId(Integer.parseInt(request.getParameter("id")));
        mod.setTitle(request.getParameter("title"));
        mod.setCategory(request.getParameter("category"));
        mod.setAuthor(request.getParameter("author"));
        mod.setDescription(request.getParameter("description"));

        boolean success = modService.updateMod(mod);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/mods");
        } else {
            request.setAttribute("error", "Erreur lors de la modification.");
            request.setAttribute("mod", mod);
            request.getRequestDispatcher("/editMod.jsp").forward(request, response);
        }
    }
}