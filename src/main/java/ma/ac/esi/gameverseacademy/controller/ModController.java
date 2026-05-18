// ================================================================
// PACKAGE : ma.ac.esi.gameverseacademy.controller
// FICHIER  : ModController.java
// ================================================================
package ma.ac.esi.gameverseacademy.controller;

import ma.ac.esi.gameverseacademy.model.Mod;
import ma.ac.esi.gameverseacademy.service.ModService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/mods")
public class ModController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

    	HttpSession session = request.getSession(false);
    	 
    	if (session == null || session.getAttribute("user") == null) {
    	    response.sendRedirect(request.getContextPath() + "/index.html");
    	    return;
    	}

        ModService modService = new ModService();

        // Lire le paramètre optionnel ?category=...
        String category = request.getParameter("category");

        List<Mod> mods;
        if (category != null && !category.trim().isEmpty()) {
            // Filtrer par catégorie si paramètre présent
            mods = modService.getModsByCategory(category);
        } else {
            // Sinon retourner tous les mods
            mods = modService.getAllMods();
        }

        // Transmettre la liste à la JSP via les attributs de requête
        request.setAttribute("mods",     mods);
        request.setAttribute("category", category);

        // Forward vers la vue JSP (l'URL ne change pas)
        request.getRequestDispatcher("/mods.jsp")
               .forward(request, response);
    }
}
