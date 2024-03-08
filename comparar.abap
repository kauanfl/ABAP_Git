REPORT Z_COMPARA.
"Operadores de Comparação

"Variaveis
DATA x Type Integer.
DATA y Like x.

"Entrada de dados
x = 10.
y = 20.

"Processamento/Saida de dados
Write : 'Valor do x: ' , x.
Write : / 'Valor do y: ' , y.
if x = 5.
   write : / 'x = 5 é verdadeiro'.
Else.
   write : / 'x = 5 é falso'.
EndIf.

if x > y.
   write : / 'x > y é verdadeiro'.
Else.
   write : / 'x > y é falso'.
EndIf.

if x < y.
   write : / 'x < y é verdadeiro'.
Else.
   write : / 'x < y é falso'.
EndIf.

if x <> y.
   write : / 'x < y é verdadeiro'.
Else.
   write : / 'x < y é falso'.
EndIf.