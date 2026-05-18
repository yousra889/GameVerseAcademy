package ma.ac.esi.gameverseacademy.service;

import ma.ac.esi.gameverseacademy.model.Review;
import ma.ac.esi.gameverseacademy.repository.ReviewRepository;
import java.util.List;

public class ReviewService {
    private final ReviewRepository repo = new ReviewRepository();

    public List<Review> getAllReviews() { return repo.getAllReviews(); }
    public Review getReviewById(int id) { return repo.getReviewById(id); }
    public boolean addReview(Review r)  { return repo.insertReview(r); }
    public boolean editReview(Review r) { return repo.updateReview(r); }
    public boolean removeReview(int id) { return repo.deleteReview(id); }
}