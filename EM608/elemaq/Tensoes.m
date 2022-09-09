function S = Tensoes(PropGeral, PropGrupo, PropMaterial)
  pd = PropGeral(1);
  Aplicacao = PropGeral(2);
  Qv = PropGeral(3);
  Tipo = PropGrupo(1);
  Percentage = PropGrupo(2);
  w_rot = PropGrupo(3);
  dp = PropGrupo(4);
  dg = PropGrupo(5);
  Wt = PropGrupo(6);
  E = PropMaterial(1);
  v = PropMaterial(2);
  [Sbp Sbg] = TensaoBendingPar(pd, Aplicacao, Qv, Tipo, Percentage, w_rot,dp,dg,Wt);
  Sc = SigmasContato(pd, Aplicacao, Qv, Tipo, Percentage, w_rot, dp, dg,Wt,E,v);
  S = [Sbp Sbg Sc];
endfunction
