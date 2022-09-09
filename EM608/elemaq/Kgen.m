#Gera os coeficientes de correção
function [Kv Km Ka Ks Kb Ki] = Kgen(wrot,pd,Aplicacao,Tipo,d,Qv,F)
  B = (12-Qv)^(2/3)/4;
  A = 50 + 56*(1-B);
  Kv = (A/(A+sqrt(wrot*d/2*2.5)))^B;#in*rad/s p/ ft/min -> in/12*rad/s*60 (1s = 1/60 min)
  Km = F/9*0.2+1.6; #interpolação da tabela do slide 37
  TabelaAplic = [1 5/4 7/4;
                 5/4 3/2 2;
                 3/2 7/4 9/4]; #tabela slide 38
  Ka = TabelaAplic(Aplicacao); #aplicacao vai de 1 a 9;
  Ks = 1; #no nosso problema não varia muito
  Kb = 1; #engrenagem de disco sólido
  Ki = 1+0.42*Tipo; #se engrenagem livre, tipo = 1;
endfunction
