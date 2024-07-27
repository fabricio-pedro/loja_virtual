package com.fabdev.model;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.PrimaryKeyJoinColumn;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.Data;

@Data
@Entity
@Table(name = "pessoa_fisica")
@PrimaryKeyJoinColumn(name = "id")
public class PessoaFisicia extends Pessoa{
	private static final long serialVersionUID = 1L;
	@Column(nullable=false)
	private String cpf;
	
	@Temporal(TemporalType.DATE)
	private LocalDate dataNascimento;
	

}
