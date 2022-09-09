#requisita os valores de J HPTSC 25º p/ o numero de dentes do pinhao e da engrenagem
function [Jg Jp] = Request_J_HPTSC25(Np,Ng)
  IndexV = [12 14 17 21 26 35 55 135];


  J_HPTSC25 = [
  zeros(1,16);
  0,0,0.33,0.33,0,0,0,0,0,0,0,0,0,0,0,0
  0,0,0.33,0.36,0.36,0.36,0,0,0,0,0,0,0,0,0,0
  0,0,0.33,0.39,0.36,0.39,0.39,0.39,0,0,0,0,0,0,0,0
  0,0,0.33,0.41,0.37,0.42,0.40,0.42,0.43,0.43,0,0,0,0,0,0
  0,0,0.34,0.44,0.37,0.45,0.40,0.45,0.43,0.46,0.46,0.46,0,0,0,0
  0,0,0.34,0.47,0.38,0.48,0.41,0.49,0.44,0.49,0.47,0.50,0.51,0.51,0,0
  0,0,0.35,0.51,0.38,0.52,0.42,0.53,0.45,0.53,0.48,0.54,0.53,0.56,0.57,0.57];

  #pega os indices menores, implicando em um menor valor de J, tendo uma alternativa mais conservadora.
  indexg = IndexApproach(Ng,IndexV);
  indexp = 2*IndexApproach(Np,IndexV)-1;

  J = J_HPTSC25(indexg,indexp:indexp+1);
  Jg = J(1);
  Jp = J(2);
endfunction
