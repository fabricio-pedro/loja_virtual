package com.fabdev.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data @EqualsAndHashCode(onlyExplicitlyIncluded = true)
@Entity
@Table(name = "produto")
@SequenceGenerator(name = "seq_produto", sequenceName = "seq_produto", allocationSize = 1, initialValue = 1)
public class Produto implements Serializable {
	
private static final long serialVersionUID = 1L;

 @EqualsAndHashCode.Include
 @Id @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_produto")
 private Long id;

 private String tipoUnidade;
 
 private String nome;
 
 @Column(columnDefinition = "text", length = 2000)
 private String descricao;
 
 private Double peso;
 
 private Double altura;
 
 private Double profundidade;
 
 private BigDecimal valorVenda;
 
 private Integer qtdEstoque;
 
 private Integer qtdAlertaEstoque;
 
 private String linkYoutube;
 
 private Boolean alertaEstoque=false;
 
 private Boolean ativo=true;
 
 private Integer qtdClicks;
 
 
 
 


}
