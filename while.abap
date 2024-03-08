REPORT Z_WHILE.
"Comando while

*Variaveis
DATA contador TYPE i VALUE 1.

*Processamento/Saida de dados
While contador >= 5 and contador <= 15.
   Write : 'O numero do contador é: ' , contador.
   contador = contador + 1.
EndWhile.