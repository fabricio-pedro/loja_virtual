package com.fabdev.model;

import java.io.Serializable;
import java.math.BigDecimal;

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
@Table(name = "imagem_produto")
@SequenceGenerator(name = "seq_imagem_produto", sequenceName = "seq_imagem_produto", allocationSize = 1, initialValue = 1)
public class ImagemProduto implements Serializable {
	private static final long serialVersionUID = 1L;
	
   @Id @EqualsAndHashCode.Include
   @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_imagem_produto") 
	private Long id;
   
   @Column(columnDefinition = "text", nullable = false)
   private String imagemOriginal;
   
   @Column(columnDefinition = "text",nullable = false)
   private String imagemMiniatura;


   @ManyToOne
   @JoinColumn(name="produto_id", nullable = false, 
   foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "pessoa_fk"))
   private Produto produto;
   

}
