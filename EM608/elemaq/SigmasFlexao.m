#calcula a tensão de flexao:

#wrot - velocidade de rotacao
#pd - passo diametral
#Aplicacao - de 1 a 9, verificar slide
#Tipo - se é livre ou não,dp
#d-diametro do chute
#Qv - qualidade
#T - torque
#J - J
#Percentage - percentual da face (verificar funcao Face())

function Sb = SigmasFlexao(wrot,pd,Aplicacao,Tipo,d,Qv,Wt,J,Percentage)
  F = Face(Percentage,pd);
  [Kv Km Ka Ks Kb Ki] = Kgen(wrot,pd,Aplicacao,Tipo,d,Qv,F);
  BigK = Ka*Km*Ks*Kb*Ki/Kv;
  Sb = Wt*pd/(F*J)*BigK;
endfunction
