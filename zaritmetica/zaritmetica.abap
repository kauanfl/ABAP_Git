REPORT Z_ARITMETICA.

DATA adicao TYPE i.
DATA sub    TYPE i.
DATA mult   TYPE i.
DATA div    TYPE i.
DATA exp    TYPE i.

adicao = 1 + 5.
sub    = 3 - 2.
mult   = 4 * 5.
div    = 10 / 2.
exp    = 9 ** 3.

WRITE: 'Soma ', adicao.
WRITE: / 'Subtração ', sub.
WRITE: / 'Multiplicação ', mult.
WRITE: / 'Divisão ', div.
WRITE: / 'Exponenciação ', exp.