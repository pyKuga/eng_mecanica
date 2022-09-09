#calcula o limite de resistência a fadiga de flexão
function S = Sfb(HB,N)
  Sfbl = SfBending2(HB);

  Kl = 1.3558*N^(-0.0178); #convencionamos vida limite maior que 10^7 ciclos
  Kt = 1; #temperatura ambiente
  Kr = 1; #confiabilidade de 99%

  S = (Kl)/(Kt*Kr)*Sfbl;
endfunction
