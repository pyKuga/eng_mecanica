clc; clear all; close all
addpath('elemaq')

T = 11; #lb in
P = 0.5; #hp
we = rpm2rads(2835); #rad/s

ws = rpm2rads(450); #rad/s



T_in = T;


% Parâmetros da Seleção do Material - Aço 1045 para Eixo e Aço 1010 para a

% chaveta aço SAE 1010
Sy_chaveta  = 44000;   % Limite Escoamento da Chaveta [ psi ]
Sut_chaveta = 53000;   % Tensao de ruptura da Chaveta [ psi ]


#aço sae 1045
Sy    = 76900;         % Tensao de escoamento [ psi ]
Sut   = 90600;         % Tensao de ruptura    [ psi ]
E = 29900;         %modulo de young
v = 0.29;              %poisson
HB = 179;




% Parâmetros de Projeto
ang_press = 25 * pi /180; % Angulo de Pressao [rad]
l = 10;                   % Comprimento vertical indicado na figura 1 [in]
r_arred = 0.01;           % Raio de arredondamento [in]
fator_eixo_chaveta = 1.5; % Quantas vezes deseja-se que o fator de seguranca do eixo exceda o da chaveta


#condicoes para a engrenagem
N = 2*10^9; #ciclos


#tensao de fadiga de flexão e contato
Sfb = Sfb(HB,N);
Sfc = Sfc(HB,N);

#ENGRENAGENS
#sistema:

Aplicacao = 5; #ver tabela [1 2 3; 4 5 6; 7 8 9]
Qv = 8; #qualidade


pd1 = 14; #passo diametral
#relacoes entre os diametros das engrenagens
#r = dp/dg
r = [0.5 5/6];

#fator de segurancSa minimo geral
Nfgeral = 2; #apenas definido por informação

#diametros das engrenagens
d1 = 1.2; #in
d2 = d1/r(1);
d3 = d2/r(2);

d4 = 1.5;
d5 = d1*d4/d3*we/ws;

d = [d1 d2 d3 d4 d5];
#IndexV = [12 14 17 21 26 35 55 135]
#Ndentes = [d1*pd1 d2*pd1 d3*pd1 d4*pd2 d5*pd2]

#Percentuais de face - o valor proporcional do intervalo (8->12)/pd
#da eng 1 a 3
Percentual1 = 0.5;
#da eng 4 e 5
Percentual2 = 0.5;


#Propriedades dos pares de engrenagens
#Propriedades do engrenamento

PG1 = [pd1 Aplicacao Qv];
PG2 = [pd1 Aplicacao Qv];
#Propriedades dos materiais
#Young e Poisson
PM = [E,v];

#Propriedades locais:

#Tipo, Percentual, W_rot, Diametro do pinhao, Diametro da movida, For?a Tangencial
F = 2*T/d1;

PlGr1 = [0 Percentual1 we d(1) d(2) F];
PlGr2 = [1 Percentual1 we*r(1) d(2) d(3) F];
PlGr3 = [0 Percentual1 we*r(2) d(4) d(5) F];

#calculo das tensões [flexao pinhao | flexao movida | contato]
Scj = [
Tensoes(PG1, PlGr1, PM);
Tensoes(PG1, PlGr2, PM);
Tensoes(PG2, PlGr3, PM);
];
disp("tensoes de flexao do pinhao, da engrenagem e de contato:")
N1 = AllSFeng(Scj(:,1), Scj(:,2), Scj(:,3), Sfb, Sfc)


#EIXOS
#diametros dos eixos

W = F/cos(deg2rad(25)); #força geral de contato

#comprimento dos eixos tipo 1 e 2
L1 = 7;
L2 = 2*L1;

#posicao das forças nos eixos
Pos1 = 0.5*L1;
Pos2 = Pos1;
Pos3 = Pos2;
Pos4 = L2-Pos3;
Pos5 = Pos4;

#reações do dcl
R=[
Reaction(W,L1,Pos1);
Reaction(W,L1,Pos2);
Reaction(W,L2,Pos3)+Reaction(W,L2,Pos4); #duas engrenagens
Reaction(W,L2,Pos5);
];
##
##
##M = [
##Moment(W,L1,Pos1);
##Moment(W,L1,Pos2);
##Moment(W,L2,Pos3)+Moment(W,L2,Pos4);
##Moment(W,L2,Pos1);
##];
##
###rever dcl
##T1 = T;
##T2 = T/r(1);
##T3 = T2/r(2);
##T4 = T2*d(5)/d(4);
##
##T = [T1 T2 T3 T4];
##
##Se = Se(Sut);
##
##r = 0.01 #raio de arredondamento
##ratio = r./de; #r/d
##
##Kt = 0.97098*ratio.^(-0.21796); #Kt
##Kts = 0.82342525*ratio.^(-0.21649); #Kts
##
##sqrta = 0.076; #constante de neuber p/ flexão
##sqrtaf = 0.0592; #constante de neuber p/ torção
##
##q = 1/(1+sqrta/sqrt(r))
##qf = 1/(1+sqrtaf/sqrt(r))
##
##Kf = 1+q*(Kt-1);
##Kfs = 1+qf*(Kts-1);
##Nf = 3
##
###vetor com 5 e outro com 4 (?)
##de = dinit(Kf,Kfs,Nf,Se,Sy,T,M);
##

#transição de codigo kuga->nogueira

d_eng = d;


%%% Dimensões previas Engrenagens %%%

d1_engre = d_eng(1);
d2_engre = d_eng(2);
d3_engre = d_eng(3);
d4_engre = d_eng(4);
d5_engre = d_eng(5);



%%% Eixo %%%

d1_eixo = [1]; % Diametro inicial do eixo 1 [in]
d2_eixo = [1]; % Diametro inicial do eixo 2 [in]
d3_eixo = [1]; % Diametro inicial do eixo 3 [in]
d4_eixo = [1]; % Diametro inicial do eixo 4 [in]
d5_eixo = [1]; % Diametro inicial do eixo 5 [in]


M1 = T_in*l /(( d1_engre /2) * cos(ang_press)*8) ;
T1 = T_in ;

M2 = T_in*l /(( d1_engre /2) * cos(ang_press )*4) ;
T2 = 0;

M3 = (( T_in /(( d1_engre /2) * cos( ang_press )) ) * ( 3/4 + d3_engre /(4* d4_engre )) * (l/4) );
T3 = T_in * d3_engre / d1_engre ;

M4 = ( T_in /( d1_engre * cos( ang_press )/2) ) * (0.25+0.75* d3_engre / d4_engre ) *(l/4) ;
T4 = T3;

M5 = T_in *3* d3_engre *l /(( d1_engre /2) * cos ( ang_press ) *4* d4_engre *4) ;
T5 = T_in * d3_engre * d5_engre /( d1_engre * d4_engre );

    %Limite de Ruptura

    Se_l = 0.5* Sut ;
    Cconf =0.814;
    A    = 2.7;
    B    = -0.265;
    Csup = A *( Sut /1000) ^B;
    Ccar = 1;
    Ctemp =1;




Iter_d_eixo = 19;

for i = 1: Iter_d_eixo
    d =[d1_eixo(i), d2_eixo(i), d3_eixo(i), d4_eixo(i), d5_eixo(i)];

    Ctam = 0.869*([d(1) ,d(2) ,d(3) ,d(4) ,d(5)]).^(-0.097);
    % Gera-se um vetor com Se respectivo a cada eixo.
    for ii = 1:5
        if d(ii) < 0.3
            Ctam(ii) = 1;
        end
    end


    Se = Csup * Ccar * Ctam * Ctemp * Cconf * Se_l ;

    %Fator de Concentração de Tensões flexão (Kf)

    sqrt_a = 0.07;                      % Constante de Neuber [in ^0.5]
    q  = 1/(1 + sqrt_a / sqrt (r_arred) ); % Fator de sensibilidade ao entalhe
    kt = 0.97098 * (0.01./[ d1_eixo(i) , d2_eixo(i) , d3_eixo(i), d4_eixo(i), d5_eixo(i) ]) .^( -0.21796) ;
    kf = 1 + q *( kt -1) ;

    %Fator de Concentração de Tensões em torção (Kfs)

    final_a_s = 0.055;                     % Constante de Neuber [in ^0.5]
    r_s  = 0.01;                          % Raio de arredondamento [in]
    q_s  = 1/(1+final_a_s / sqrt( r_s )); % Fator de sensibilidade ao entalhe
    kt_s = 0.83425*(0.01./[ d1_eixo(i) , d2_eixo(i) , d3_eixo(i), d4_eixo(i), d5_eixo(i) ]).^( -0.21649);
    kf_s = 1 + q_s *(kt_s - 1) ;

    w_chaveta =[];
    for j =1:5
        w_chaveta(j) = Wchaves(d(j));
    end

    %Tensao de Cisalhamento

    T_cis     = [T1 T2 T3 T4 T5];
    F_m       = 2*T_cis ./ d;
    L_chaveta = [0.1*ones(1,4) 0.2];

    Tau       = F_m ./ (L_chaveta.*w_chaveta);
    sig_cis   = (Tau)*3^(1/2);

    Nf_cis    = Sy_chaveta ./ sig_cis;

    %Tensao de Esmagamento

    h_chaveta = w_chaveta;
    A_esm     = L_chaveta.*h_chaveta / 2 ;
    sig_esm   = F_m ./ A_esm;

    Nf_esm    = Sy_chaveta ./ sig_esm;

    %Selecionando o Nf mais crítico

    Nf_crit = [];
    for j = 1:length(d)
        Nf_crit(j) = min([Nf_cis(j), Nf_esm(j)]);
    end
    Nf_crit;

    %Atualizando o diâmetro do Eixo

    func_d_eixo =@(M,T,n_eixo,Nf) ((32* Nf /pi)*(( kf(n_eixo)*M ./ Se(n_eixo)).^2 + 0.75 *( kf_s(n_eixo)*T./ Sy ).^2).^(0.5) ).^(1/3) ;

    d1_eixo(i+1) = func_d_eixo( M1,T1,1,fator_eixo_chaveta * Nf_crit (1) );
    d2_eixo(i+1) = func_d_eixo( M2,T2,2,fator_eixo_chaveta * mean([ Nf_crit(1), Nf_crit(3), Nf_crit(4), Nf_crit(5)]) ) ;
    d3_eixo(i+1) = func_d_eixo( M3,T3,3,fator_eixo_chaveta * Nf_crit (3) );
    d4_eixo(i+1) = func_d_eixo( M4,T4,4,fator_eixo_chaveta * Nf_crit (4) );
    d5_eixo(i+1) = func_d_eixo( M5,T5,5,fator_eixo_chaveta * Nf_crit (5) );
end

figure
plot (1: Iter_d_eixo +1, d1_eixo )
hold on
plot (1: Iter_d_eixo +1, d2_eixo )
plot (1: Iter_d_eixo +1, d3_eixo )
plot (1: Iter_d_eixo +1, d4_eixo )
plot (1: Iter_d_eixo +1, d5_eixo )

title("Evolução dos Diâmetros ao Iterar")
xlabel("Número de Iterações")
ylabel("Diâmetro do eixo [in] ")
legend ("diametro 1", "diametro 2", "diametro 3", "diametro 4", "diametro 5")
grid minor



