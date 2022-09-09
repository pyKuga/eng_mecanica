function d = dinit(Kf,Kfsm,Nf,Se,Sy,T,M)
  a1 = (Kf*M./Se).^2;
  a2 = 0.75*(Kfsm*T./Sy).^2;
  a3 = 32*Nf/pi*sqrt(a2);
  d = a3.^1/3;
endfunction

