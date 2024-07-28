package org.naveenalla.e_management.repo;

import jakarta.persistence.*;
import org.hibernate.NonUniqueResultException;
import org.naveenalla.e_management.model.User;

public class UserRepo {
    private EntityManager em;

    public UserRepo() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("StudentPersistence");
        this.em = emf.createEntityManager();
    }

    public User registerUser(String username, String password) {
        User user = new User(username, password);
        em.getTransaction().begin();
        em.persist(user);
        em.getTransaction().commit();
        return user;
    }

    public User login(String username, String password) {
        try {
            return em.createQuery("SELECT u FROM User u WHERE u.username = :username AND u.password = :password", User.class)
                    .setParameter("username", username)
                    .setParameter("password", password)
                    .getSingleResult();
        } catch (NoResultException e) {
            // No user found with the provided credentials
            System.out.println("No user found with username: " + username);
        } catch (NonUniqueResultException e) {
            // More than one user found with the provided credentials (this should not happen if username is unique)
            System.out.println("More than one user found with username: " + username);
        } catch (PersistenceException e) {
            // Handle other database-related exceptions
            System.out.println("An error occurred while accessing the database: " + e.getMessage());
        } catch (Exception e) {
            // Catch any other unexpected exceptions
            System.out.println("An unexpected error occurred: " + e.getMessage());
        }
        return null;
    }

}
