package org.naveenalla.e_management;


import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import org.naveenalla.e_management.model.User;


public class HelloServlet {
    public static void main(String[] args) {
        try {
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("StudentPersistence");
            EntityManager em = emf.createEntityManager();
            EntityTransaction et = em.getTransaction();
            et.begin();
            User student = new User();
            student.setUsername("user2");
            student.setPassword("user2");
            student.setRole("user");
            em.persist(student);
            System.out.println("Student is saved");
            et.commit();
            em.close();
            emf.close();
        }
        catch (Exception e) {
            System.out.println(e.getMessage());
        }

    }
}