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

public class Reject extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("StudentPersistence");

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long appLId = Long.parseLong(request.getParameter("id"));
        EntityManager em = emf.createEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();
            Application application = em.find(Application.class, appLId);
            if (application != null) {
                application.setStatus("Rejected");
                transaction.commit();
            } else {
                // Handle case where application is not found
            }
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            // Handle exception (e.g., log the error)
        } finally {
            em.close(); // Close EntityManager after use
        }

        request.setAttribute("message", "Application rejected successfully");
        request.getRequestDispatcher("mailSend.jsp").forward(request, response);
    }

    @Override
    public void destroy() {
        emf.close(); // Close EntityManagerFactory when the servlet is destroyed
    }
}
