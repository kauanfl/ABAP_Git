REPORT ZCAPAC_15_COMPRAS.

INCLUDE ZCAPAC_15_COMPRAS_TOP    IF FOUND. "Declaracao de tabelas e variaveis

------------------------------------------------------------------
*&  TABLES
&---------------------------------------------------------------------
TABLES: EKKO,
        EKPO.


------------------------------------------------------------------
*&  TYPES
&---------------------------------------------------------------------

TYPES:
BEGIN OF tp_saida,
  Empresa    TYPE ekko-bukrs,
  Num_DOC    TYPE ekpo-ebeln,
  ITEM       TYPE ekpo-ebelp,
  CATEG_DOC  TYPE ekko-bstyp,
  MATERIAL   TYPE ekpo-matnr,
  DESC_MAT   TYPE makt-maktx,
  VL_LIQ     TYPE ekpo-netwr,
  FORNECEDOR TYPE lfa1-name1,
  CIDADE     TYPE lfa1-ort01,
END OF tp_saida,

tp_t_saida TYPE TABLE OF tp_saida,

tp_t_lfa1  TYPE TABLE OF lfa1,

tp_t_ekko  TYPE TABLE OF ekko,

tp_t_ekpo  TYPE TABLE OF EKPO,

tp_t_makt  TYPE TABLE OF makt.

------------------------------------------------------------------
*&  DATA
&---------------------------------------------------------------------
DATA: tg_lfa1  TYPE tp_t_lfa1,
      tg_saida TYPE tp_t_saida,
      tg_ekko  TYPE tp_t_ekko,
      tg_ekpo  TYPE tp_t_ekpo,
      tg_makt  TYPE tp_t_makt.

------------------------------------------------------------------
*&  SELECTION-SCREEN
&---------------------------------------------------------------------

SELECTION-SCREEN BEGIN OF BLOCK bloco1 WITH FRAME TITLE text-t15.
  SELECT-OPTIONS: s_bukrs FOR ekko-bukrs MODIF ID DC1,
                  s_bstyp FOR ekko-bstyp MODIF ID DC1,
                  s_ebeln FOR ekko-ebeln MODIF ID DC1,
                  s_aedat FOR EKKO-AEDAT MODIF ID DC1.

  PARAMETERS: p_bukrs TYPE EKKO-BUKRS MODIF ID DC2,
              p_matnr TYPE EKPO-MATNR MODIF ID DC2.

  SELECTION-SCREEN END OF BLOCK bloco1.

  SELECTION-SCREEN BEGIN OF BLOCK bloco2 WITH FRAME TITLE text-tA2.

  PARAMETERS: r_DC1 RADIOBUTTON GROUP r1 USER-COMMAND com1,
              r_DC2 RADIOBUTTON GROUP r1.

  SELECTION-SCREEN END OF BLOCK bloco2.

INCLUDE ZCAPAC_15_COMPRAS_EVENTS IF FOUND. "Logica do programa

&---------------------------------------------------------------------
*&  Include           ZCAPAC_15_DOC_COMPRAS_EVENT
&---------------------------------------------------------------------


INITIALIZATION.

r_DC1 = 'X'.

*AT SELECTION-SCREEN ON s_bukrs.
*
*  PERFORM f_check_bukrs.

AT SELECTION-SCREEN OUTPUT.

LOOP AT SCREEN.

  IF r_DC1 IS NOT INITIAL.

  CASE screen-group1.
    WHEN 'DC1'.
       screen-active = 1.
    WHEN 'DC2'.
       screen-active = 0.
    WHEN OTHERS.
  ENDCASE.

  ELSE.

   CASE screen-group1.
     WHEN 'DC1'.
       screen-active = 0.
     WHEN 'DC2'.
       screen-active = 1.
     WHEN OTHERS.
   ENDCASE.

  ENDIF.

MODIFY SCREEN.
ENDLOOP.

  "Inicio do processamento (F8
 START-OF-SELECTION.

PERFORM F_EXECUTE2.

END-OF-SELECTION.

PERFORM F_DISPLAY2.

INCLUDE ZCAPAC_15_COMPRAS_FORMS  IF FOUND. "Funcionalidades especificas da logica
&---------------------------------------------------------------------
*&  Include           ZCAPAC_15_DOC_COMPRAS_FORM
&---------------------------------------------------------------------


FORM F_EXECUTE2 .

PERFORM F_SELECT2.

PERFORM F_TRATE_DATA2.

ENDFORM.

&---------------------------------------------------------------------
*&      Form  F_SELECT
&---------------------------------------------------------------------
*       text
----------------------------------------------------------------------
*  -->  p1        text
*  <--  p2        text
----------------------------------------------------------------------
FORM F_SELECT2 .

IF r_DC1 IS NOT INITIAL.
  SELECT *
    FROM EKKO
    INTO TABLE tg_ekko
   WHERE ebeln IN s_ebeln
     AND bukrs IN s_bukrs
     AND bstyp IN s_bstyp
     AND aedat IN s_aedat.

IF sy-subrc IS INITIAL.
 SELECT *
    FROM EKPO
    INTO TABLE tg_ekpo
   FOR ALL ENTRIES IN tg_ekko
   WHERE ebeln EQ tg_ekko-ebeln.
 ENDIF.

 ELSE.

 SELECT *
    FROM EKPO
    INTO TABLE tg_ekpo
   WHERE bukrs EQ p_bukrs
     AND matnr EQ p_matnr.

 IF sy-subrc IS INITIAL.
   SELECT *
     FROM EKKO
     INTO TABLE tg_ekko
     FOR ALL ENTRIES IN tg_ekpo
      WHERE ebeln EQ tg_ekpo-ebeln.
 ENDIF.

 ENDIF.

IF sy-subrc IS INITIAL.

  SELECT *
    FROM lfa1
    INTO TABLE tg_lfa1
    FOR ALL ENTRIES IN tg_ekko
    WHERE lifnr EQ tg_ekko-lifnr.

      IF sy-subrc IS INITIAL.
      SORT tg_lfa1 BY lifnr.
      ENDIF.

  SELECT *
    FROM ekko
    INTO TABLE tg_ekko
    FOR ALL ENTRIES IN tg_ekko
    WHERE ebeln EQ tg_ekko-ebeln.

    IF sy-subrc IS INITIAL.
      SORT tg_ekko BY ebeln.
    ENDIF.

  SELECT *
    FROM makt
    INTO TABLE tg_makt
    FOR ALL ENTRIES IN tg_ekpo
    WHERE matnr EQ tg_ekpo-matnr
      AND spras EQ 'P'.

 ELSE.

  SELECT *
    FROM lfa1
    INTO TABLE tg_lfa1
    FOR ALL ENTRIES IN tg_ekko
    WHERE lifnr = tg_ekko-lifnr.

    IF sy-subrc IS INITIAL.
      SORT tg_lfa1 BY lifnr.
      ENDIF.

  SELECT *
    FROM ekko
    INTO TABLE tg_ekko
    FOR ALL ENTRIES IN tg_ekpo
    WHERE ebeln = tg_ekpo-ebeln.

    IF sy-subrc IS INITIAL.
      SORT tg_ekko BY ebeln.
    ENDIF.

  SELECT *
    FROM makt
    INTO TABLE tg_makt
    FOR ALL ENTRIES IN tg_ekpo
    WHERE  matnr = tg_ekpo-matnr
    AND spras = 'P'.

ENDIF.

IF sy-subrc IS NOT INITIAL.
    MESSAGE i002(ZCAPAC_15) with text-e01.
*    MESSAGE text-e01 TYPE 'S' DISPLAY LIKE 'E'. "Se definir como S não aparece pop-up, se for para aparecer, definir como I."
    leave LIST-PROCESSING. "Volta para a tela inicial do programa.
ENDIF.

ENDFORM.
&---------------------------------------------------------------------
*&      Form  F_DISPLAY
&---------------------------------------------------------------------
*       text
----------------------------------------------------------------------
*  -->  p1        text
*  <--  p2        text
----------------------------------------------------------------------
FORM F_DISPLAY2.

DATA: wl_saida TYPE tp_saida.

LOOP AT tg_saida INTO wl_saida.

  WRITE: / 'Empresa:', wl_saida-empresa, 'Num.Doc:', wl_saida-num_doc, 'Item:', wl_saida-item,
           'Categoria Doc:', wl_saida-categ_doc, 'Material:', wl_saida-material, 'Desc. Material:', wl_saida-desc_mat,
           'Vlr Liquido:', wl_saida-vl_liq, 'Fornecedor:', wl_saida-fornecedor, 'Cidade:', wl_saida-cidade.

  ENDLOOP.

ENDFORM.
&---------------------------------------------------------------------
*&      Form  F_TRATE_DATA
&---------------------------------------------------------------------
*       text
----------------------------------------------------------------------
*  -->  p1        text
*  <--  p2        text
----------------------------------------------------------------------
FORM F_TRATE_DATA2 .

  DATA: wl_ekko TYPE ekko,
        wl_ekpo TYPE ekpo,
        wl_makt TYPE makt,
        wl_lfa1 TYPE lfa1,
        wl_saida TYPE tp_saida.

  LOOP At tg_ekpo INTO wl_ekpo.

  wl_saida-num_doc  = wl_ekpo-ebeln.
  wl_saida-item     = wl_ekpo-ebelp.
  wl_saida-material = wl_ekpo-matnr.
  wl_saida-vl_liq   = wl_ekpo-netwr.


  READ TABLE tg_ekko INTO wl_ekko WITH KEY ebeln = wl_ekpo-ebeln.
  IF sy-subrc IS INITIAL.
     wl_saida-empresa   = wl_ekko-bukrs.
     wl_saida-categ_doc = wl_ekko-bstyp.
  ENDIF.

  READ TABLE tg_lfa1 INTO wl_lfa1 WITH KEY lifnr = wl_ekko-lifnr.
  IF sy-subrc IS INITIAL.
     wl_saida-fornecedor = wl_lfa1-name1.
     wl_saida-cidade     = wl_lfa1-ort01.
  ENDIF.

  READ TABLE tg_makt INTO wl_makt WITH KEY matnr = wl_ekpo-matnr.
    IF sy-subrc IS INITIAL.
      wl_saida-desc_mat = wl_makt-maktx.
  ENDIF.

  APPEND wl_saida TO tg_saida.
  CLEAR wl_saida.

  ENDLOOP.

ENDFORM.