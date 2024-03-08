REPORT Z_CASE.
"Comandos case

*Variaveis
DATA hoje TYPE c LENGTH 10.

*Entrada de dados
hoje = 'segunda'.

*Processamento/Saida de dados
Case hoje.
  When 'segunda'.
       Write : 'Começando a semana'.
  When 'sabado' or 'domingo'.
       Write : 'Final de semana'.
  When OTHERS.
       Write : 'Hoje é ' , hoje.
Endcase.