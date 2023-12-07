package com.fabdev.model;

import org.springframework.security.core.GrantedAuthority;

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
@Table(name = "acesso")
@SequenceGenerator(name = "seq_acesso", sequenceName = "seq_acesso",allocationSize = 1, initialValue = 1)
public class Acesso implements GrantedAuthority {
    @Id @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @EqualsAndHashCode.Include
	private Long id;
	
    @Column(nullable = false)
	private String descricao;
	
	@Override
	public String getAuthority() {
		// TODO Auto-generated method stub
		return this.descricao;
	}

}
