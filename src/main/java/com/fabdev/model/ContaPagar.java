package com.fabdev.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;

import com.fabdev.enuns.StatusContaReceber;
import com.fabdev.enuns.TipoEndereco;

import jakarta.persistence.Column;
import jakarta.persistence.ConstraintMode;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity
@Table(name = "conta_pagar")
@SequenceGenerator(name = "seq_conta_pagar", sequenceName = "seq_conta_pagar", allocationSize = 1, initialValue = 1)
@Data @EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class ContaPagar implements Serializable{
    private static final long serialVersionUID = 1L;

    @EqualsAndHashCode.Include
	@Id @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_conta_pagar")
	private Long id;
    @Column(nullable = false)
    private String descricao;
    
    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private StatusContaReceber status;
    
    @Column(nullable = false)
    @Temporal(TemporalType.DATE)
    private LocalDate dtVencimento;
   
    @Temporal(TemporalType.DATE)
    private LocalDate dtPagamento;
    @Column(nullable = false)
    private BigDecimal valorTotal;
    
    private BigDecimal valorDesconto;
    
    @ManyToOne(targetEntity = Pessoa.class)
	@JoinColumn(name = "pessoa_id", nullable = false,
	foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "pessoa_fk"))
	private Pessoa pessoa;

	@ManyToOne(targetEntity = Pessoa.class)
	@JoinColumn(name = "pessoa_forn_id", nullable = false, 
	foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "pessoa_forn_fk"))
	private Pessoa pessoa_fornecedor;
	
}
