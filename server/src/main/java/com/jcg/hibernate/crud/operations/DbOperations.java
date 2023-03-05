package com.jcg.hibernate.crud.operations;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.dieselpoint.norm.Database;
import com.jcg.hibernate.crud.operations.models.Contact;

public class DbOperations {

  private DbOperations() {
  }

  public static final Logger logger = Logger.getLogger(DbOperations.class);

  static Database getConnection() {
    final var db = new Database();

    db.setJdbcUrl(Utils.CONNECTION_URL);
    db.setUser(Utils.CONNECTION_USERNAME);
    db.setPassword(Utils.CONNECTION_PASSWORD);

    return db;
  }

  public static void create(Contact contact) {
    final var db = getConnection();

    try {
      db.insert(contact);
    } catch (Exception sqlException) {
      sqlException.printStackTrace();
    } finally {
      db.close();
    }
  }

  public static List<Contact> list() {
    final var db = getConnection();

    try {
      return db.results(Contact.class);
    } catch (Exception sqlException) {
      sqlException.printStackTrace();

      return new ArrayList<>();
    } finally {
      db.close();
    }
  }

  public static void update(Contact contact) {
    final var db = getConnection();

    try {
      db.update(contact);
    } catch (Exception sqlException) {
      sqlException.printStackTrace();
    } finally {
      db.close();
    }
  }

  public static void delete(Contact contact) {
    final var db = getConnection();

    try {

      db.delete(contact);
    } catch (Exception sqlException) {
      sqlException.printStackTrace();
    } finally {
      db.close();
    }
  }
}
