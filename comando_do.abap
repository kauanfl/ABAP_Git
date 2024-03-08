REPORT Z_COMANDO_DO.
"Comando Do..EndDo

*Variaveis
DATA contador TYPE i VALUE 1.

*Processamento/Saida de dados
Do.
   If contador >= 10.
     Exit.
  EndIf.

     Write : / 'O numero é: ' , contador.
     contador = contador + 1.

Enddo.