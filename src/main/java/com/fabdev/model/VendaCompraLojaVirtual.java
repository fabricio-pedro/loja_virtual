package com.fabdev.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.ConstraintMode;
import jakarta.persistence.Entity;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.Data;
import lombok.EqualsAndHashCode;
@Data @EqualsAndHashCode(onlyExplicitlyIncluded = true)
@Entity
@Table(name = "venda_compra_loja_virtual")
@SequenceGenerator(name = "seq_venda_compra_loja_virtual",sequenceName = "seq_venda_compra_loja_virtual",initialValue = 1,allocationSize = 1)
public class VendaCompraLojaVirtual implements Serializable {

	private static final long serialVersionUID = 1L;
	@Id @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_venda_compra_loja_virtual")
	private Long id;
	@ManyToOne
	@JoinColumn(name = "pessoa_id",nullable =false,
	foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT,name = "pessoa_fk"))
	private Pessoa pessoa;
	@ManyToOne
	@JoinColumn(name = "endereco_entrega_id",nullable =false,
	foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT,name = "endereco_entrega_fk"))
    private Endereco enderecoEntrega;
	
	@ManyToOne
	@JoinColumn(name = "endereco_cobranca_id",nullable =false,
	foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT,name = "endereco_cobranca_fk"))
    private Endereco enderecoCobranca;
	
	@Column(nullable = false)
	private BigDecimal valorTotal;
	private BigDecimal valorDesconto;
	@ManyToOne
	@JoinColumn(name = "forma_pagamento_id",nullable =false,
	foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT,name = "forma_pagamento_fk"))
	private FormaPagamento formaPagamento;
	@OneToOne
	@JoinColumn(name = "nota_fiscal_venda_id",nullable =false,
	foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT,name = "nota_fiscal_venda_fk"))
	private NotaFiscalVenda notaFiscalVenda;
	@ManyToOne
	@JoinColumn(name = "cup_desconto_id",
			foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT,name = "cup_desconto_fk"))
	private CupDesconto cupDesconto;
	@Column(nullable = false)
	private BigDecimal valorFrete;
	@Column(nullable = false)
	private Integer diaEntrega;
	@Column(nullable = false)
	@Temporal(TemporalType.DATE)
	private LocalDate dataEntrega;
	@Column(nullable = false)
	@Temporal(TemporalType.DATE)
	private LocalDate dataVenda;
	
	
}
