REPORT Z_CONDICAO.
"Condição IF ABAP

*Variaveis
DATA hoje TYPE c LENGTH 10.

*Entrada de dados
hoje = 'domingo'.

*Processamento/Saida de dados
If hoje = 'segunda'.
   Write : 'Hoje é Segunda-feira'.
Elseif hoje = 'sabado' or hoje = 'domingo'.
   Write : 'Estamos no final de semana'.
Else.
   Write : 'Hoje é ' , hoje.
Endif.