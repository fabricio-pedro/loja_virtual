package com.fabdev.model;

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
@Table(name = "status_rastreio")
@SequenceGenerator(name = "seq_status_rastreio",sequenceName = "seq_status_rastreio",initialValue = 1,allocationSize = 1)
public class StatusRastreio {
	@Id @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_status_rastreio")
	@EqualsAndHashCode.Include
	private Long id;
	
	private String centroDistribuicao;
	
	private String cidade;
	
	private String estado;
	
	private String status;
	
	@ManyToOne
	@JoinColumn(name = "venda_compra_loja_virtual_id", nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT,name = "venda_compra_loja_virtual_id"))
	private VendaCompraLojaVirtual vendaCompraLojaVirtual;

}
