package com.fabdev.enuns;

public enum StatusContaPagar {
   COBRANCA("Pagar"),
   VENCIDA("Vencida"),
   ABERTA("Aberta"),
   QUITADA("Quitada");
	
	private String descricao;
	private StatusContaPagar(String descricao) {
		// TODO Auto-generated constructor stub
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
