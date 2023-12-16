package com.fabdev.model;

import java.io.Serializable;

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
@Table(name = "forma_pagamento")
@SequenceGenerator(name="seq_forma_pagamento", sequenceName = "seq_forma_pagamento",allocationSize = 1,initialValue = 1)
public class FormaPagamento implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id @EqualsAndHashCode.Include
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_endereco")
	private Long id;
	
	private String descricao;
	

}
