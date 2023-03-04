package com.jcg.hibernate.crud.operations;

import org.apache.log4j.Logger;

import com.jcg.hibernate.crud.operations.models.Contact;

public class App {

  public static final Logger logger = Logger.getLogger(App.class);

  public static void main(String[] args) {
    logger.info("Hibernate Crud Operations Example");

    read();

    create();

    read();

    update();

    read();

    delete();

    read();
  }

  static void create() {
    logger.info("======= CREATE RECORDS");

    DbOperations.createRecord(Contact.builder().build());
  }

  static void read() {
    logger.info("======= READ RECORDS");

    for (final var contatoObj : DbOperations.displayRecords()) {
      logger.info(contatoObj.toString());
    }
  }

  static void update() {
    logger.info("======= UPDATE RECORDS");

    DbOperations.updateRecord(Contact.builder().id(1).build());
  }

  static void delete() {
    logger.info("======= DELETE RECORD");

    DbOperations.deleteRecord(1);
  }
}
