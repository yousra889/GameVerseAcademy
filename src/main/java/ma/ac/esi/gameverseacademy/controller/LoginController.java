package ma.ac.esi.gameverseacademy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import jakarta.servlet.http.HttpSession;


import java.sql.SQLException;                   
import ma.ac.esi.gameverseacademy.service.UserService; 
 


/**
 * Servlet implementation class LoginController
 */
@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	// LoginController.java — méthode doPost
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    String login = request.getParameter("login");
	    String password = request.getParameter("password");

	    UserService userService = new UserService();

	    try {

	        if (userService.finUserByCredentials(login, password)) {

	            HttpSession session = request.getSession();
	            session.setAttribute("user", login);

	            response.sendRedirect(request.getContextPath() + "/mods");

	        } else {

	            response.sendRedirect(request.getContextPath() + "/error.html");

	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}

}
