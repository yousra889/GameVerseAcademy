package ma.ac.esi.gameverseacademy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import ma.ac.esi.gameverseacademy.model.Review;
import ma.ac.esi.gameverseacademy.service.ReviewService;
import java.io.IOException;

@WebServlet("/ReviewEditController")
public class ReviewEditController extends HttpServlet {
    private final ReviewService service = new ReviewService();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        req.setAttribute("review", service.getReviewById(id));
        req.getRequestDispatcher("review-edit.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        Review r = new Review();
        r.setId(Integer.parseInt(req.getParameter("id")));
        r.setRating(Integer.parseInt(req.getParameter("rating")));
        r.setComment(req.getParameter("comment"));
        service.editReview(r);
        res.sendRedirect(req.getContextPath() + "/reviews");
    }
}