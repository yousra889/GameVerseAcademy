package ma.ac.esi.gameverseacademy.repository;

import ma.ac.esi.gameverseacademy.model.Review;
import ma.ac.esi.gameverseacademy.util.DBUtil;
import java.sql.*;
import java.util.*;

public class ReviewRepository {

    // READ ALL
    public List<Review> getAllReviews() {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT r.*, u.login, m.title as mod_title " +
                     "FROM reviews r " +
                     "JOIN users u ON r.user_id = u.id " +
                     "JOIN mods m ON r.mod_id = m.id " +
                     "ORDER BY r.created_at DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(new Review(
                    rs.getInt("id"),
                    rs.getInt("mod_id"),
                    rs.getInt("user_id"),
                    rs.getInt("rating"),
                    rs.getString("comment"),
                    rs.getTimestamp("created_at"),
                    rs.getString("login"),
                    rs.getString("mod_title")
                ));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // READ ONE
    public Review getReviewById(int id) {
        String sql = "SELECT r.*, u.login, m.title as mod_title " +
                     "FROM reviews r " +
                     "JOIN users u ON r.user_id = u.id " +
                     "JOIN mods m ON r.mod_id = m.id " +
                     "WHERE r.id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Review(
                        rs.getInt("id"),
                        rs.getInt("mod_id"),
                        rs.getInt("user_id"),
                        rs.getInt("rating"),
                        rs.getString("comment"),
                        rs.getTimestamp("created_at"),
                        rs.getString("login"),
                        rs.getString("mod_title")
                    );
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    // CREATE
    public boolean insertReview(Review review) {
        String sql = "INSERT INTO reviews (mod_id, user_id, rating, comment) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, review.getModId());
            stmt.setInt(2, review.getUserId());
            stmt.setInt(3, review.getRating());
            stmt.setString(4, review.getComment());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    // UPDATE
    public boolean updateReview(Review review) {
        String sql = "UPDATE reviews SET rating=?, comment=? WHERE id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, review.getRating());
            stmt.setString(2, review.getComment());
            stmt.setInt(3, review.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    // DELETE
    public boolean deleteReview(int id) {
        String sql = "DELETE FROM reviews WHERE id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }
}