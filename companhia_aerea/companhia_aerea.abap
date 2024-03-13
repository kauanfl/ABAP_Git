REPORT Z_AEREO1.

tables: scarr.

Data w_aereo type scarr. "workarea
Data t_aereo type STANDARD TABLE OF scarr. "tabela interna
Data moeda TYPE c LENGTH 3.

"tabela interna lê as informações obtidas da tabela interna t_aereo

"w_aereo-mandt     = '001'.
"w_aereo-carrid    = '2022'.
"w_aereo-carrname  = 'LATAM'.
"w_aereo-currcode  = 'BRZ'.

"Entrada de dados
SELECTION-SCREEN BEGIN OF BLOCK bloco1 WITH FRAME TITLE TEXT-001.
   SELECT-OPTIONS: s_carrid FOR scarr-carrid.

"PARAMETER : p_carrid  type scarr-carrid,
"            p_carrnm  type scarr-carrname.
PARAMETER: r_usd RADIOBUTTON GROUP r1 default 'X',
           r_eur RADIOBUTTON GROUP r1,
           r_zar RADIOBUTTON GROUP r1.

SELECTION-SCREEN END OF BLOCK bloco1.

Select mandt,
       carrid,
       carrname,
       currcode
into TABLE @t_aereo
   FROM scarr
 WHERE carrid   in  @s_carrid
       and currcode = @moeda.

If sy-subrc = 0.
  loop at t_aereo into w_aereo.
  Write: / 'Mandante: '             , w_aereo-mandt.
  Write: / 'ID: '                   , w_aereo-carrid.
  Write: / 'Cia Aerea: '            , w_aereo-carrname.
  Write: / 'Código da moeda: '(001) , w_aereo-currcode.
  endloop.
EndIf.