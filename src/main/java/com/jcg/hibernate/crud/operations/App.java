package com.jcg.hibernate.crud.operations;

import org.apache.log4j.Logger;

import com.google.gson.Gson;
import com.jcg.hibernate.crud.operations.models.Contact;

import static spark.Spark.*;

import java.util.UUID;

public class App {

  public static final Logger logger = Logger.getLogger(App.class);

  public static void main(String[] args) {

    final var gson = new Gson();

    DbOperations.list();

    DbOperations.create(Contact.builder()
        .id(UUID.randomUUID().toString())
        .name("aaaaaaaa")
        .address("aaaa")
        .phoneNumber("aaaaaaa")
        .build());

    port(80);

    path("/api", () -> {
      get("/contact", (req, res) -> {
        return DbOperations.list();
      }, gson::toJson);

      post("/contact", (req, res) -> {
        DbOperations.create(Contact.builder()
            // TODO: fix
            .build());

        return "{}";
      }, gson::toJson);

      patch("/contact", (req, res) -> {
        DbOperations.update(Contact.builder()
            // TODO: fix
            .build());

        return "{}";
      }, gson::toJson);

      delete("/contact/:id", (req, res) -> {
        DbOperations.delete(Integer.valueOf(req.params("id")));

        return "{}";
      }, gson::toJson);
    });
  }
}
