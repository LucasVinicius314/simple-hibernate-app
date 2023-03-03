package com.jcg.hibernate.crud.operations;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "CONTATOS_731506")
public class Contato implements Serializable {

  private static final long serialVersionUID = 1L;

  @Id
  @Column(name = "codigo")
  @GeneratedValue(strategy = GenerationType.AUTO)
  private int id;

  @Column(name = "nome")
  private String nome;

  @Column(name = "endereco")
  private String endereco;

  @Column(name = "telefone")
  private String telefone;

  @Override
  public String toString() {
    return "Contato Details?= Id: " + this.id + ", Nome: " + this.nome + ", REndereco: " + this.endereco
        + ", Telefone: " + this.telefone;
  }
}
