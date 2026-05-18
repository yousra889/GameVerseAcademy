package ma.ac.esi.gameverseacademy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import ma.ac.esi.gameverseacademy.service.ReviewService;
import java.io.IOException;

@WebServlet("/ReviewDeleteController")
public class ReviewDeleteController extends HttpServlet {
    private final ReviewService service = new ReviewService();

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        service.removeReview(id);
        res.sendRedirect(req.getContextPath() + "/reviews");
    }
}