#Calcula os C's p/ contato
function [Cv Cm Ca Cs Cf] = Cgen(wrot,Aplicacao,d,Qv,F)
  B = (12-Qv)^(2/3)/4;
  A = 50 + 56*(1-B);
  Cv = (A/(A+sqrt(wrot*d*2.5)))^B; #in*rad/s p/ ft/min -> in/12*rad/s*60 (1s = 1/60 min)
  Cm = F/9*0.2+1.6; #interpolação da tabela do slide 37
  TabelaAplic = [1 5/4 7/4;
                 5/4 3/2 2;
                 3/2 7/4 9/4]; #tabela slide 38
  Ca = TabelaAplic(Aplicacao); #aplicacao vai de 1 a 9;
  Cs = 1; #no nosso problema não varia muito
  Cf = 1; #metodos de fabricacao convencionais
endfunction

