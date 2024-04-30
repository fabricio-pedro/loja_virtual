package com.fabdev.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;

import com.fabdev.enuns.StatusContaReceber;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data @EqualsAndHashCode(onlyExplicitlyIncluded = true)
@Entity
@Table(name = "cup_desconto")
@SequenceGenerator(name = "seq_cup_desconto", sequenceName = "seq_cup_desconto", allocationSize = 1, initialValue = 1)
public class CupDesconto implements Serializable{

	
	    private static final long serialVersionUID = 1L;

		@EqualsAndHashCode.Include
		@Id @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_cup_desconto")
		private Long id;

	    private String codDesc;
	    
	    private BigDecimal valorRealDesc;
	    
	    private BigDecimal valorPorcDesc;
	    
	    @Temporal(TemporalType.DATE)
	    private LocalDate dataValidade;
	
	
}
