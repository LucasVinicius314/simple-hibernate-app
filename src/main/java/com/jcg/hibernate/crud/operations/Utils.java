package com.jcg.hibernate.crud.operations;

public class Utils {

  private Utils() {
  }

  public static final String CONNECTION_URL = System.getenv("CONNECTION_URL");
  public static final String CONNECTION_USERNAME = System.getenv("CONNECTION_USERNAME");
  public static final String CONNECTION_PASSWORD = System.getenv("CONNECTION_PASSWORD");
}
