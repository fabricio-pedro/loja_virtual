package com.fabdev.model;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data @EqualsAndHashCode(onlyExplicitlyIncluded = true)
@Entity
@Table(name = "nota_fiscal_venda")
@SequenceGenerator(name = "seq_nota_fiscal_venda",sequenceName = "seq_nota_fiscal_venda",initialValue = 1,allocationSize = 1)
public class NotaFiscalVenda implements Serializable {
	private static final long serialVersionUID = 1L;
    
	@Id @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_nota_fical_vend")
	@EqualsAndHashCode.Include
	private Long id;
	@Column(nullable = false)
	private String numero;
	@Column(nullable = false)
	private String serie;
	@Column(nullable = false)
	private String tipo;
	@Column(columnDefinition = "text", nullable = false)
	private String xml;
	@Column(columnDefinition = "text",nullable = false)
	private String  pdf;
	@OneToOne(mappedBy = "notaFiscalVenda",fetch = FetchType.LAZY)
	//Fiz o relacionamento diferente do instrutor
	private VendaCompraLojaVirtual vendaCompraLojaVirtual;
}
