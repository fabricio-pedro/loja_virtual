package com.fabdev.model;
import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.ConstraintMode;
import jakarta.persistence.Entity;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;


@Data @EqualsAndHashCode(onlyExplicitlyIncluded = true)
@Entity
@Table(name = "avaliacao_produto")
@SequenceGenerator(name = "seq_avaliacao_produto",sequenceName = "seq_avaliacao_produto",allocationSize = 1,initialValue = 1 )
public class AvaliacaoProduto implements Serializable {
 private static final long serialVersionUID = 1L;
 
 @Id  @EqualsAndHashCode.Include 
 @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_avaliacao_produto")
 private Long id;
 @Column(nullable = false)
 private Integer nota;
 
 @Column(nullable = false)
 private String descricao;
 
 @ManyToOne
 @JoinColumn(name = "pessoa_id", nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT,name = "pessoa_fk"))	   
 private Pessoa pessoa;
 
 @ManyToOne
 @JoinColumn(name = "produto_id", nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT,name = "produto_fk"))	  
 private Produto produto;
}
