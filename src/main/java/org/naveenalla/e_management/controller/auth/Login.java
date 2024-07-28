package org.naveenalla.e_management.controller.auth;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Persistence;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.naveenalla.e_management.model.User;

import java.io.IOException;

public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("StudentPersistence");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();
        RequestDispatcher rd = null;

        EntityManager em = null;

        try {
            em = emf.createEntityManager(); // Ensure emf is properly initialized
            User user = em.createQuery(
                            "SELECT u FROM User u WHERE u.username = :username AND u.password = :password", User.class)
                    .setParameter("username", username)
                    .setParameter("password", password) // Hash and compare passwords in production
                    .getSingleResult();

            session.setAttribute("name", username);
            session.setAttribute("role", user.getRole());
            session.setAttribute("user", user);
            rd = request.getRequestDispatcher("apply.jsp");
        } catch (NoResultException e) {
            request.setAttribute("error", "Invalid username or password");
            rd = request.getRequestDispatcher("login.jsp");
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception properly
            request.setAttribute("error", "An error occurred while processing your request");
            rd = request.getRequestDispatcher("login.jsp");
        } finally {
            if (em != null) {
                em.close();
            }
        }

        if (rd != null) {
            rd.forward(request, response);
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        if (session.getAttribute("name") != null) {
            response.sendRedirect("apply.jsp");
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    @Override
    public void destroy() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}
