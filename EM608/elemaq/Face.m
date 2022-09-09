#gera a face com base em um percentual da largura da regra (slide 37 - engrenagens)
function F = Face(Percentage, pd)
  Interp = 8*(Percentage+1);
  F = Interp/pd;
endfunction

