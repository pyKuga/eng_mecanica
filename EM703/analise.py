import pandas as pd
from matplotlib import pyplot as plt
import numpy as np

Lancgrande = pd.read_csv("Lancamento_16777215.csv")
Convergencia = pd.read_csv("Tabela_diferentes.csv")

n = Lancgrande['Lancamento']
pi = Lancgrande['Pi']

plt.yscale("log")
plt.title("Convergência para 0xFFFFFF lançamentos")
plt.ylabel("Valor de Pi")
plt.xlabel("Lançamento")
plt.plot(n,pi)
plt.show()


n = Convergencia['Lancamentos']
pi = Convergencia['Pi_obtido']

plt.title("Convergência para vários lançamentos")
plt.ylabel("Valor de Pi")
plt.xlabel("Lançamentos")
plt.xscale("log")
plt.plot(n,pi)
plt.show()



