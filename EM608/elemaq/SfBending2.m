#fadiga de flex�o de grau 2 (Sfb') em fun��o da Brinell
function Sfbl = SfBending2(HB)
  Sfbl = 6235+174*HB-0.126*HB^2;
endfunction
