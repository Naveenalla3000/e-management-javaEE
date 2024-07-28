package org.naveenalla.e_management.controller.apply;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.naveenalla.e_management.model.Application;
import org.naveenalla.e_management.model.User;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class MyApps extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("StudentPersistence"); // Ensure the persistence unit name matches
    private static final Logger logger = Logger.getLogger(MyApps.class.getName()); // For logging

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("user"); // Retrieve the logged-in user

        if (loggedInUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        EntityManager em = emf.createEntityManager();

        try {
            // Query to find all applications for the logged-in user
            TypedQuery<Application> query = em.createQuery(
                    "SELECT a FROM Application a WHERE a.user.id = :userId", Application.class);
            query.setParameter("userId", loggedInUser.getId());
            List<Application> applications = query.getResultList();

            // Set applications as a request attribute
            request.setAttribute("applications", applications);

            // Forward to the JSP page to display applications
            request.getRequestDispatcher("myapplications.jsp").forward(request, response);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error while retrieving applications", e);
            response.sendRedirect("error.jsp"); // Redirect to an error page or handle it appropriately
        } finally {
            em.close();
        }
    }
}
