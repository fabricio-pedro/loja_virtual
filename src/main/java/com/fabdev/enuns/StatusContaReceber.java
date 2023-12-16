package com.fabdev.enuns;

public enum StatusContaReceber {
   COBRANCA("Pagar"),
   VENCIDA("Vencida"),
   ABERTA("Aberta"),
   QUITADA("Quitada"),
   RENEGOCIADA("Renegociada");
	
	private String descricao;
	private StatusContaReceber(String descricao) {
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
