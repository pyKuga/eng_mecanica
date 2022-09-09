function R = Reaction(F,L,a)
  R2 = a/L*F;
  R1 = F-R2;
  R = [R1 R2];
endfunction
