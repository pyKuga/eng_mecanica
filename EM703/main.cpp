#include <iostream>
#include <random>
#include <math.h>
//#include <stdlib.h>


//queremos refinar esse valor
#define PI 3.14

struct Space{
    public:
    float Theta;
    float x;

};

//classe da agulha
class Agulha{
  //Agulha
  public:
  float Theta;
  float x_pos;
  float L; //tamanho da agulha

  void SetNeedle(float L){
      this->L = L;
  }

  bool Throw(float D,Space* Espaco){
    this->Theta = Espaco->Theta;
    this->x_pos = Espaco->x;
    return this->L*cos(this->Theta)/2 > this->x_pos ;  
  }
};


// calcula o pi dependendo do caso
float Pi_calc(float L, float D, bool Tipo,int n, float p){
  float pi;
  if(Tipo){
    pi = 2*L/(D*p);
  }
  else{
    float r = D/L;
    pi = (2/p)*(acos(r)+(1/r)*(1-sqrt(1-pow(r,2))));
  }

  return pi;
}

float Experimento(float pi, float r, float D){
    float L = r*D; //espaço
    bool Tipo = L < D;


    long long Lancamentos = 0xffffff;
    int Acertos = 0;
/* dar um jeito de passar isso aqui p/ fora */
    std::random_device rd;
    std::mt19937 generator{rd()}; //escolha de 32 bits pq é menor
    std::uniform_real_distribution<double> distribuicaox(0,D/2);
    std::uniform_real_distribution<double> distribuicaot(0,pi/2);

    Space* Espaco = new Space;
    Agulha* Needle = new Agulha;
    Needle->SetNeedle(L);
  

    // cria, gera e deleta a agulha
    for(long long i=0; i<Lancamentos;i++){
        Espaco->Theta = distribuicaot(generator);
        Espaco->x = distribuicaox(generator);
        Acertos += Needle->Throw(D,Espaco);

        
    }

    float p = (float) Acertos/(float) Lancamentos;
    return Pi_calc(L,D,Tipo,Lancamentos,p);

}





int main(int argc, char *argv[]) {
    float GooglePi = 3.14159265359;
    
    long long Iteracoes = 10;
    float pi_e;
    float r = 10;
    float D = 10;  //Distância das bordas
    float Pi0 = Experimento(PI,r,D);

    for(long long i =0; i<Iteracoes;i++){
        pi_e = Experimento(Pi0,r,D);
    }

    




    std::cout << "O valor de pi e: " << pi_e << std::endl;
    std::cout << "Erro de norma com relacao ao Pi do Google: " << abs(pi_e-GooglePi)/GooglePi << std::endl;



  

  
}
