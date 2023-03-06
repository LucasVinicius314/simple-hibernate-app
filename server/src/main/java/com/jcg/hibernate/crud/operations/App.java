package com.jcg.hibernate.crud.operations;

import com.google.gson.Gson;
import com.jcg.hibernate.crud.operations.models.Contact;

import static spark.Spark.*;

import java.util.HashMap;
import java.util.UUID;

public class App {

  public static void main(String[] args) {

    final var gson = new Gson();

    port(80);

    path("/api", () -> {
      get(Utils.CONTACT_PATH, (req, res) -> {
        res.type(Utils.CONTENT_TYPE);
        return DbOperations.list();
      }, gson::toJson);

      post(Utils.CONTACT_PATH, (req, res) -> {
        final var id = UUID.randomUUID().toString();

        final var name = req.queryParams("name");
        final var address = req.queryParams("address");
        final var phoneNumber = req.queryParams("phoneNumber");

        DbOperations.create(Contact.builder()
            .id(id)
            .name(name)
            .address(address)
            .phoneNumber(phoneNumber)
            .build());

        res.type(Utils.CONTENT_TYPE);
        return new HashMap<>();
      }, gson::toJson);

      patch(String.format("%s/:id", Utils.CONTACT_PATH), (req, res) -> {
        final var id = req.params("id");

        final var name = req.queryParams("name");
        final var address = req.queryParams("address");
        final var phoneNumber = req.queryParams("phoneNumber");

        DbOperations.update(Contact.builder()
            .id(id)
            .name(name)
            .address(address)
            .phoneNumber(phoneNumber)
            .build());

        res.type(Utils.CONTENT_TYPE);
        return new HashMap<>();
      }, gson::toJson);

      delete(String.format("%s/:id", Utils.CONTACT_PATH), (req, res) -> {
        final var id = req.params("id");

        DbOperations.delete(Contact.builder()
            .id(id)
            .build());

        res.type(Utils.CONTENT_TYPE);
        return new HashMap<>();
      }, gson::toJson);
    });
  }
}
