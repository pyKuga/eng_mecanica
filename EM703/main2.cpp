#include <iostream>
#include <random>
#include <math.h>
//#include <stdlib.h>
#include <fstream>
#include <string>

//na natureza este valor já existe. precisamos informá-lo para o computador.
#define PI 3.14159265359

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

float Experimento(float pi, float r, float D, long long Lancamentos){
    
    std::fstream fout; //ponteiro para o arquivo
    std::string Nome = "Lancamento_" + std::to_string(Lancamentos)+".csv";
  
    fout.open(Nome, std::ios::out | std::ios::trunc);
  
    float L = r*D; //espaço
    bool Tipo = L < D;
    int Acertos = 0;

    
    std::random_device rd;
    std::mt19937 generator{rd()}; //escolha de 32 bits pq é menor
    std::uniform_real_distribution<double> distribuicaox(0,D/2);
    std::uniform_real_distribution<double> distribuicaot(0,pi/2);

    Space* Espaco = new Space;
    Agulha* Needle = new Agulha;
    Needle->SetNeedle(L);
    float p =0;
    float pi_calc = 0;
    fout << "Lancamento,Pi\n";

    // Gera um espaço para a agulha, calcula a Probabilidade, o Pi e exporta um CSV
    for(long long i=0; i<Lancamentos;i++){
        Espaco->Theta = distribuicaot(generator);
        Espaco->x = distribuicaox(generator);
        Acertos += Needle->Throw(D,Espaco);
        p = (float) Acertos/(float) Lancamentos;
        pi_calc = Pi_calc(L,D,Tipo,Lancamentos,p);
        fout << i << "," << pi_calc << "\n";
     }

    return pi_calc;

}





int main(int argc, char *argv[]) {
    float GooglePi = PI; //pois este é o pi que encontramos ao procurar no google (está na sua calculadora)

    float r = 10;  // razao L/D
    float D = 10;  //Distância das bordas
    long long Lancamento = 0xffffff;
    float Pi_max = Experimento(GooglePi,r,D,Lancamento);

    


    // outros números de lançamentos

    std::fstream fout; //ponteiro para o arquivo
    fout.open("Tabela_diferentes.csv", std::ios::out | std::ios::trunc);
    float Pi_teste = 0;
    fout << "Lancamentos,Pi_obtido\n";

    for(int Lanc=10; Lanc<1e7; Lanc*=2){
        Pi_teste = Experimento(GooglePi,r,D,Lanc);
        fout << Lanc << "," << Pi_teste << "\n";
    }

    




    std::cout << "O valor de pi e: " << Pi_max << std::endl;
    std::cout << "Erro de norma com relacao ao Pi do Google: " << abs(Pi_max-GooglePi)/GooglePi << std::endl;



  

  
}