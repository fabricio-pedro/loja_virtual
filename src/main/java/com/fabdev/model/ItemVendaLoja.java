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
@Table(name = "item_venda_loja")
@SequenceGenerator(name = "seq_item_venda_loja",sequenceName = "seq_item_venda_loja",allocationSize = 1,initialValue = 1 )
public class ItemVendaLoja implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE,generator = "seq_item_venda_loja")
	private Long id;
    @Column(nullable = false)
	private Double quantidade;
	@ManyToOne
	@JoinColumn(name = "produto_id", nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT,name = "produto_fk"))	
	private Produto produto;
	
	@ManyToOne
	@JoinColumn(name = "venda_compra_loja_virtual_id", nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT,name = "venda_compra_loja_virtual_fk"))
	private VendaCompraLojaVirtual vendaCompraLojaVirtual;
}
