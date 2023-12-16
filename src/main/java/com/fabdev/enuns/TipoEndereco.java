package com.fabdev.enuns;

public enum TipoEndereco {

	COBRANCA("cobrança"),
	ENTREGA("entrega");

	private String descricao;
	
	TipoEndereco(String tipo) {
		// TODO Auto-generated constructor stub
		this.descricao=tipo;
	}
	
	public String getDescricao() {
		return this.descricao;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return this.descricao;
	}
	
}
