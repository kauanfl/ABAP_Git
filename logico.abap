REPORT Z_LOGICO.
"Operadores logicos

*Controle de temperatura
"Variaveis
DATA min TYPE i.
DATA max TYPE i.
DATA temp TYPE i.

"Entrada de dados
min = 14.
max = 25.
temp = 20.

"Processamento/Saida de dados
Write: 'Temperatura minima: ' , min.
Write: 'Temperatura maxima: ' , max.
Write: 'Temperatura atual: ' , temp.

if temp >= min and temp <= max.
   Write : / 'Tempo estável'.
else.
   Write : / 'Tempo fora de controle'.
endIf.

if temp <= min or temp >= max.
   Write : / 'Tempo estável para frio'.
else.
   Write : / 'Calor'.
endIf.