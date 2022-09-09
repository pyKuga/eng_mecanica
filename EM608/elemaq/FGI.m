#calcula o fator I agma (?)
function Ic = FGI(dp, dg,pd)
  r1 = dp/2;
  r2 = dg/2;
  phi = 25*pi/180; #decidimos 25

  rho1 = sqrt((r1+1/pd)^2-(r1*cos(phi))^2)-pi/pd*cos(phi);
  rho2 = (r1+r2)*sin(phi)-rho1;

  Ic = cos(phi)/((1/rho1+1/rho2)*dp);

endfunction
