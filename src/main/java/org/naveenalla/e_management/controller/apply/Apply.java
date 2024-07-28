package org.naveenalla.e_management.controller.apply;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.naveenalla.e_management.model.Application; // Assuming this is your entity class
import org.naveenalla.e_management.model.User; // Import the User class

@MultipartConfig
public class Apply extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("StudentPersistence"); // Ensure the persistence unit name matches

    private static final Logger logger = Logger.getLogger(Apply.class.getName()); // For logging

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String fullName = request.getParameter("fullName");
        String dob = request.getParameter("dob");
        String contact = request.getParameter("contact");
        String address = request.getParameter("address");
        String schoolName = request.getParameter("schoolName");
        String grades = request.getParameter("grades");
        String completionYear = request.getParameter("completionYear");
        String examScores = request.getParameter("examScores");
        String personalStatement = request.getParameter("personalStatement");
        String stream = request.getParameter("stream");
        String educationLevel = request.getParameter("educationLevel");

        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("user"); // Retrieve the logged-in user

        if (loggedInUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        EntityManager em = emf.createEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            // Begin transaction
            transaction.begin();

            // Create new Application entity
            Application application = new Application();
            application.setFullName(fullName);
            application.setDob(LocalDate.parse(dob));
            application.setContact(contact);
            application.setAddress(address);
            application.setSchoolName(schoolName);
            application.setGrades(grades);
            application.setCompletionYear(Integer.valueOf(completionYear));
            application.setExamScores(examScores);
            application.setPersonalStatement(personalStatement);
            application.setStream(stream);
            application.setEducationLevel(educationLevel);
            application.setStatus("pending");

            // Set the user in the application entity
            application.setUser(loggedInUser);

            // Persist entity
            em.persist(application);

            // Commit transaction
            transaction.commit();

            // Redirect or respond
            response.sendRedirect("success.jsp");
        } catch (Exception e) {
            // Handle exception
            if (transaction.isActive()) {
                transaction.rollback();
            }
            logger.log(Level.SEVERE, "Error while processing application", e);
            response.sendRedirect("error.jsp");
        } finally {
            // Close EntityManager
            em.close();
        }
    }
}
