package com.jcg.hibernate.crud.operations;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;

public class DbOperations {

  private DbOperations() {
  }

  static SessionFactory sessionFactoryObj;

  public static final Logger logger = Logger.getLogger(DbOperations.class);

  private static SessionFactory buildSessionFactory() {
    final var configObj = new Configuration();

    final var connectionUrl = System.getenv("CONNECTION_URL");
    final var connectionUsername = System.getenv("CONNECTION_USERNAME");
    final var connectionPassword = System.getenv("CONNECTION_PASSWORD");

    configObj.setProperty("hibernate.dialect", "org.hibernate.dialect.MySQLDialect");
    configObj.setProperty("hibernate.connection.driver_class", "com.mysql.jdbc.Driver");
    configObj.setProperty("hibernate.connection.url", connectionUrl);
    configObj.setProperty("hibernate.connection.username", connectionUsername);
    configObj.setProperty("hibernate.connection.password", connectionPassword);
    configObj.setProperty("show_sql", "true");
    configObj.setProperty("hibernate.current_session_context_class",
        "org.hibernate.context.internal.ThreadLocalSessionContext");

    sessionFactoryObj = configObj
        .buildSessionFactory(new StandardServiceRegistryBuilder().applySettings(configObj.getProperties())
            .build());

    return sessionFactoryObj;
  }

  public static void createRecord() {
    int count = 0;
    Contato contatoObj = null;

    final var sessionObj = buildSessionFactory().openSession();

    try {

      sessionObj.beginTransaction();

      for (int j = 101; j <= 105; j++) {
        count = count + 1;
        contatoObj = new Contato();
        contatoObj.setEndereco("RUA XXXXX, 999");
        contatoObj.setNome("aluno " + j);
        contatoObj.setTelefone("(31)9999-8877");
        sessionObj.save(contatoObj);
      }

      sessionObj.getTransaction().commit();

      logger.info("\nSuccessfully Created '" + count + "' Records In The Database!\n");
    } catch (Exception sqlException) {
      sqlException.printStackTrace();
    } finally {
      sessionObj.close();
    }
  }

  @SuppressWarnings("unchecked")
  public static List<Contato> displayRecords() {
    final var sessionObj = buildSessionFactory().openSession();

    try {
      sessionObj.beginTransaction();

      return sessionObj.createQuery("FROM Contato").list();
    } catch (Exception sqlException) {
      if (null != sessionObj.getTransaction()) {
        logger.info("\n.......Transaction Is Being Rolled Back.......\n");

        sessionObj.getTransaction().rollback();
      }

      sqlException.printStackTrace();
    } finally {
      sessionObj.close();
    }

    return new ArrayList<Contato>();
  }

  public static void updateRecord(int id) {
    final var sessionObj = buildSessionFactory().openSession();

    try {
      sessionObj.beginTransaction();

      final var contatObj = (Contato) sessionObj.get(Contato.class, id);

      contatObj.setNome("Jose");
      contatObj.setEndereco("AV AAA, 777");

      sessionObj.getTransaction().commit();
      logger.info("\nContato With Id?= " + id + " Is Successfully Updated In The Database!\n");
    } catch (Exception sqlException) {
      if (null != sessionObj.getTransaction()) {
        logger.info("\n.......Transaction Is Being Rolled Back.......\n");
        sessionObj.getTransaction().rollback();
      }

      sqlException.printStackTrace();
    } finally {
      sessionObj.close();
    }
  }

  public static void deleteRecord(Integer id) {
    final var sessionObj = buildSessionFactory().openSession();

    try {
      sessionObj.beginTransaction();

      final var contatoObj = findRecordById(id);
      sessionObj.delete(contatoObj);

      sessionObj.getTransaction().commit();

      logger.info("\nContato With Id?= " + id + " Is Successfully Deleted From The Database!\n");
    } catch (Exception sqlException) {
      if (null != sessionObj.getTransaction()) {
        logger.info("\n.......Transaction Is Being Rolled Back.......\n");

        sessionObj.getTransaction().rollback();
      }

      sqlException.printStackTrace();
    } finally {
      sessionObj.close();
    }
  }

  public static Contato findRecordById(Integer id) {
    final var sessionObj = buildSessionFactory().openSession();

    try {
      sessionObj.beginTransaction();

      return (Contato) sessionObj.load(Contato.class, id);
    } catch (Exception sqlException) {
      if (null != sessionObj.getTransaction()) {
        logger.info("\n.......Transaction Is Being Rolled Back.......\n");
        sessionObj.getTransaction().rollback();
      }

      sqlException.printStackTrace();
    }
    return null;
  }

  public static void deleteAllRecords() {
    final var sessionObj = buildSessionFactory().openSession();

    try {
      sessionObj.beginTransaction();

      final var queryObj = sessionObj.createQuery("DELETE FROM Contato");
      queryObj.executeUpdate();

      sessionObj.getTransaction().commit();
      logger.info("\nSuccessfully Deleted All Records From The Database Table!\n");
    } catch (Exception sqlException) {
      if (null != sessionObj.getTransaction()) {
        logger.info("\n.......Transaction Is Being Rolled Back.......\n");
        sessionObj.getTransaction().rollback();
      }

      sqlException.printStackTrace();
    } finally {
      sessionObj.close();
    }
  }
}
