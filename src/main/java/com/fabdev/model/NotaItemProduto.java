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
@Table(name="nota_item_produto")
@SequenceGenerator( name = "seq_nota_item_produto",sequenceName ="seq_nota_item_produto",initialValue = 1,allocationSize = 1 )
public class NotaItemProduto implements Serializable {
   private static final long serialVersionUID = 1L;
    
   @Id @EqualsAndHashCode.Include
   @GeneratedValue(strategy = GenerationType.SEQUENCE,generator = "seq_nota_item_produto")
   private Long id;
    @Column(nullable = false)
    private Double quantidade;
   
    @ManyToOne
    @JoinColumn(name = "nota_fiscal_compra_id",nullable = false,
    foreignKey =@ForeignKey(value = ConstraintMode.CONSTRAINT, name="nota_fiscal_fk") )
    private NotaFiscalCompra notaFiscalCompra;
    
    @ManyToOne
    @JoinColumn(name = "produto_id",nullable = false,
    foreignKey =@ForeignKey(value = ConstraintMode.CONSTRAINT, name="produto_fk") )
    private Produto produto;
	
	
}
