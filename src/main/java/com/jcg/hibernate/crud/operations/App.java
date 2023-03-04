package com.jcg.hibernate.crud.operations;

import java.util.List;

import org.apache.log4j.Logger;

public class App {

  public static final Logger logger = Logger.getLogger(App.class);

  public static void main(String[] args) {
    logger.info(".......Hibernate Crud Operations Example.......\n");

    logger.info("\n=======CREATE RECORDS=======\n");
    DbOperations.createRecord();

    logger.info("\n=======READ RECORDS=======\n");
    List<Contato> viewContatos = DbOperations.displayRecords();
    if (viewContatos != null && !viewContatos.isEmpty()) {
      for (Contato contatoObj : viewContatos) {
        logger.info(contatoObj.toString());
      }
    }

    logger.info("\n=======UPDATE RECORDS=======\n");
    int updateId = 1;
    DbOperations.updateRecord(updateId);

    logger.info("\n=======READ RECORDS AFTER UPDATION=======\n");
    List<Contato> updateContato = DbOperations.displayRecords();
    if (updateContato != null && !updateContato.isEmpty()) {
      for (Contato contatoObj : updateContato) {
        logger.info(contatoObj.toString());
      }
    }

    logger.info("\n=======DELETE RECORD=======\n");
    int deleteId = 5;
    DbOperations.deleteRecord(deleteId);
    logger.info("\n=======READ RECORDS AFTER DELETION=======\n");
    List<Contato> deleteContatoRecord = DbOperations.displayRecords();
    for (Contato contatoObj : deleteContatoRecord) {
      logger.info(contatoObj.toString());
    }

    System.exit(0);
  }
}
