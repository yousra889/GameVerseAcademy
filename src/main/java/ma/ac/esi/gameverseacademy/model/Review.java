package ma.ac.esi.gameverseacademy.model;

import java.sql.Timestamp;

public class Review {
    private int id;
    private int modId;
    private int userId;
    private int rating;
    private String comment;
    private Timestamp createdAt;
    private String userLogin;
    private String modTitle;

    public Review() {}

    public Review(int id, int modId, int userId, int rating, String comment, Timestamp createdAt, String userLogin, String modTitle) {
        this.id = id;
        this.modId = modId;
        this.userId = userId;
        this.rating = rating;
        this.comment = comment;
        this.createdAt = createdAt;
        this.userLogin = userLogin;
        this.modTitle = modTitle;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getModId() { return modId; }
    public void setModId(int modId) { this.modId = modId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }
    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public String getUserLogin() { return userLogin; }
    public void setUserLogin(String userLogin) { this.userLogin = userLogin; }
    public String getModTitle() { return modTitle; }
    public void setModTitle(String modTitle) { this.modTitle = modTitle; }
}