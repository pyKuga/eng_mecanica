#calcula a tensão do par
function [Sbp Sbg] = TensaoBendingPar(pd, Aplicacao, Qv, Tipo, Percentage, w_rot,dp,dg,Wt)
  Np = dp*pd;
  Ng = dg*pd;
  [Jg Jp] = Request_J_HPTSC25(Np,Ng);
  Sbp = SigmasFlexao(w_rot,pd,Aplicacao,Tipo,dp,Qv,Wt,Jp,Percentage);
  Sbg = SigmasFlexao(w_rot,pd,Aplicacao,Tipo,dg,Qv,Wt,Jg,Percentage);
endfunction
