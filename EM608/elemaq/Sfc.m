#calcula o limite de resistência a fadiga de contato usando a dureza e o número de ciclos
function S = Sfc(HB,N)
  Sfcl = SfSurface2(HB);

  Cl = 1.4488*N^(-0.023); #convencionamos vida limite maior que 10^7 ciclos
  Ch = 1; #pinhao engrenagem de mesmo material
  Ct = 1; #temperatura ambiente
  Cr = 1; #confiabilidade de 99%

  S = (Cl*Ch)/(Ct*Cr)*Sfcl;
endfunction
