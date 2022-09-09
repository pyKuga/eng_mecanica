#calcula sigma de contato
function Sc = SigmasContato(pd, Aplicacao, Qv, Tipo, Percentage, w_rot, dp, dg,Wt,E,v)
  F = Face(Percentage,pd);
  [Cv Cm Ca Cs Cf] = Cgen(w_rot,Aplicacao,dp,Qv,F);
  BigC = Ca*Cm*Cs*Cf/Cv;
  Cp = Cp(E,v)
  Ic = FGI(dp,dg,pd);
  Sc = Cp*sqrt(Wt/(F*Ic*dp)*BigC);
endfunction

