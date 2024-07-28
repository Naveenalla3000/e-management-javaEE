package org.naveenalla.e_management.controller.apply;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.naveenalla.e_management.model.Application;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class GetAllApps extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("StudentPersistence"); // Ensure the persistence unit name matches
    private static final Logger logger = Logger.getLogger(GetAllApps.class.getName()); // For logging

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EntityManager em = emf.createEntityManager();
        EntityTransaction transaction = em.getTransaction();
        List<Application> applications = null;

        try {
            transaction.begin();
            applications = em.createQuery("SELECT a FROM Application a", Application.class).getResultList();
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            logger.log(Level.SEVERE, "Error while fetching applications", e);
            response.sendRedirect("error.jsp"); // Redirect to an error page or handle it appropriately
            return; // Ensure to return after redirection
        } finally {
            em.close();
        }

        request.setAttribute("applications", applications);
        request.getRequestDispatcher("applications.jsp").forward(request, response);
    }

    public void destroy() {
        emf.close();
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
