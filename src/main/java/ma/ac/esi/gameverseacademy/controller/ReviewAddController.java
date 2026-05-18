package ma.ac.esi.gameverseacademy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import ma.ac.esi.gameverseacademy.model.Review;
import ma.ac.esi.gameverseacademy.service.ReviewService;
import ma.ac.esi.gameverseacademy.repository.ModRepository;
import java.io.IOException;

@WebServlet("/ReviewAddController")
public class ReviewAddController extends HttpServlet {
    private final ReviewService service = new ReviewService();
    private final ModRepository modRepo = new ModRepository();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("mods", modRepo.getAllMods());
        req.getRequestDispatcher("review-form.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        Review r = new Review();
        r.setModId(Integer.parseInt(req.getParameter("modId")));
        r.setUserId(Integer.parseInt(req.getParameter("userId")));
        r.setRating(Integer.parseInt(req.getParameter("rating")));
        r.setComment(req.getParameter("comment"));
        service.addReview(r);
        res.sendRedirect(req.getContextPath() + "/reviews");
    }
}