function N = AllSFeng(Sbp, Sbg, Sc, Sfb, Sfc)
  Nbp = SafetyFactor(Sfb,Sbp);
  Nbg = SafetyFactor(Sfb,Sbg);
  Nc = SafetyFactor(Sfc,Sc);

  N = [Nbp Nbg Nc];
endfunction
