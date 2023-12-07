package com.fabdev.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@Entity
@Table(name = "marca_produto")
@SequenceGenerator(name = "seq_marca_produto", sequenceName = "seq_marca_produto",allocationSize = 1,initialValue = 1)
public class MarcaProduto {
    
	@Id @GeneratedValue(strategy = GenerationType.SEQUENCE)
	@EqualsAndHashCode.Include 
	private Long id;
	@Column(nullable = false)
	private String nomeDesc;
	
}
