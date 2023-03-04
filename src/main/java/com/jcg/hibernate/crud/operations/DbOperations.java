package com.jcg.hibernate.crud.operations;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;

import com.jcg.hibernate.crud.operations.models.Contact;

public class DbOperations {

  private DbOperations() {
  }

  static SessionFactory sessionFactoryObj;

  public static final Logger logger = Logger.getLogger(DbOperations.class);

  private static SessionFactory buildSessionFactory() {
    final var configObj = new Configuration();

    configObj.setProperty("hibernate.dialect", "org.hibernate.dialect.MySQLDialect");
    configObj.setProperty("hibernate.connection.driver_class", "com.mysql.jdbc.Driver");
    configObj.setProperty("hibernate.connection.url", Utils.CONNECTION_URL);
    configObj.setProperty("hibernate.connection.username", Utils.CONNECTION_USERNAME);
    configObj.setProperty("hibernate.connection.password", Utils.CONNECTION_PASSWORD);
    configObj.setProperty("show_sql", "true");
    configObj.setProperty("hibernate.current_session_context_class",
        "org.hibernate.context.internal.ThreadLocalSessionContext");

    sessionFactoryObj = configObj
        .buildSessionFactory(new StandardServiceRegistryBuilder().applySettings(configObj.getProperties())
            .build());

    return sessionFactoryObj;
  }

  public static void createRecord(Contact contact) {
    final var sessionObj = buildSessionFactory().openSession();

    try {

      sessionObj.beginTransaction();

      sessionObj.persist(contact);

      sessionObj.getTransaction().commit();
    } catch (Exception sqlException) {
      sqlException.printStackTrace();
    } finally {
      sessionObj.close();
    }
  }

  public static List<Contact> displayRecords() {
    final var sessionObj = buildSessionFactory().openSession();

    try {
      sessionObj.beginTransaction();

      return sessionObj
          .createQuery("FROM CONTATOS_731506", Contact.class)
          .list();
    } catch (Exception sqlException) {
      if (null != sessionObj.getTransaction()) {
        sessionObj.getTransaction().rollback();
      }

      sqlException.printStackTrace();
    } finally {
      sessionObj.close();
    }

    return new ArrayList<>();
  }

  public static void updateRecord(Contact contact) {
    final var sessionObj = buildSessionFactory().openSession();

    try {
      sessionObj.beginTransaction();

      final var contactObj = sessionObj.get(Contact.class, contact.getId());

      contactObj.setNome(contact.getNome());
      contactObj.setAddress(contact.getAddress());
      contactObj.setPhoneNumber(contact.getPhoneNumber());

      sessionObj.getTransaction().commit();
    } catch (Exception sqlException) {
      if (null != sessionObj.getTransaction()) {
        sessionObj.getTransaction().rollback();
      }

      sqlException.printStackTrace();
    } finally {
      sessionObj.close();
    }
  }

  public static void deleteRecord(int id) {
    final var sessionObj = buildSessionFactory().openSession();

    try {
      sessionObj.beginTransaction();

      sessionObj.remove(findRecordById(id));

      sessionObj.getTransaction().commit();
    } catch (Exception sqlException) {
      if (null != sessionObj.getTransaction()) {
        sessionObj.getTransaction().rollback();
      }

      sqlException.printStackTrace();
    } finally {
      sessionObj.close();
    }
  }

  public static Contact findRecordById(int id) {
    final var sessionObj = buildSessionFactory().openSession();

    try {
      sessionObj.beginTransaction();

      return sessionObj.get(Contact.class, id);
    } catch (Exception sqlException) {
      if (null != sessionObj.getTransaction()) {
        sessionObj.getTransaction().rollback();
      }

      sqlException.printStackTrace();
    } finally {
      sessionObj.close();
    }

    return null;
  }

  public static void deleteAllRecords() {
    final var sessionObj = buildSessionFactory().openSession();

    try {
      sessionObj.beginTransaction();

      sessionObj.createQuery("DELETE FROM CONTATOS_731506", Contact.class).executeUpdate();

      sessionObj.getTransaction().commit();
    } catch (Exception sqlException) {
      if (null != sessionObj.getTransaction()) {
        sessionObj.getTransaction().rollback();
      }

      sqlException.printStackTrace();
    } finally {
      sessionObj.close();
    }
  }
}
