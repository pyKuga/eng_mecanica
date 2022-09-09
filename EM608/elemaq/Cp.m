#coeficiente do material
function Cp = Cp(E,v)
  Cp = sqrt((1/(2*pi))*(E/(1-v^2)));
endfunction
