package ma.ac.esi.gameverseacademy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import ma.ac.esi.gameverseacademy.service.ReviewService;
import java.io.IOException;

@WebServlet("/reviews")
public class ReviewListController extends HttpServlet {
    private final ReviewService service = new ReviewService();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("reviews", service.getAllReviews());
        req.getRequestDispatcher("reviews.jsp").forward(req, res);
    }
}