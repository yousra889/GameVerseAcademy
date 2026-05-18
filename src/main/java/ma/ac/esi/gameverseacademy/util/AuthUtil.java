package ma.ac.esi.gameverseacademy.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import ma.ac.esi.gameverseacademy.model.User;

public class AuthUtil {

    public static boolean isAuthenticated(HttpServletRequest request) {

        HttpSession session = request.getSession(false);

        if (session == null) {
            return false;
        }

        User user = (User) session.getAttribute("user");

        return user != null;
    }
}