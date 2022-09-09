function Ks()
Kt = 1.85;
r = 0.1;
sqrta = 0.076;
sqrtaf = 0.0592;

q = 1/(1+sqrta/sqrt(r))
qf = 1/(1+sqrtaf/sqrt(r))

Kf = 1+q*(Kt-1);
Kfs = 1+qf*(Kt-1);


