*&---------------------------------------------------------------------*
*& Module Pool       Z_GLACCINFO
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
PROGRAM Z_GLACCINFO.

TABLES: bsas, ska1, skat.

"--- Input variables (linked to screen 100 fields)
DATA: gv_bukrs TYPE bsas-bukrs,
      gv_gjahr TYPE bsas-gjahr,
      gv_budat TYPE bsas-budat,
      gv_saknr TYPE ska1-saknr.

"--- Output structure
DATA: BEGIN OF wa_output,
        bukrs TYPE bsas-bukrs,
        gjahr TYPE bsas-gjahr,
        budat TYPE bsas-budat,
        hkont TYPE bsas-hkont,
        augdt TYPE bsas-augdt,
        dmbtr TYPE bsas-dmbtr,
        saknr TYPE ska1-saknr,
        ktopl TYPE ska1-ktopl,
        txt20 TYPE skat-txt20,
      END OF wa_output.




*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT.
   CASE sy-ucomm.
    WHEN 'FIND'.
      PERFORM fetch_data.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
FORM fetch_data.
  CLEAR wa_output.

  SELECT SINGLE a~bukrs,
                a~gjahr,
                a~budat,
                a~hkont,
                a~augdt,
                a~dmbtr,
                b~saknr,
                b~ktopl,
                c~txt20
    INTO @wa_output
    FROM bsas AS a
    INNER JOIN ska1 AS b
       ON a~hkont = b~saknr
    INNER JOIN skat AS c
       ON b~saknr = c~saknr
      AND b~ktopl = c~ktopl
      AND c~spras = @sy-langu
   WHERE a~bukrs = @gv_bukrs
     AND a~gjahr = @gv_gjahr
     AND a~budat = @gv_budat
     AND b~saknr = @gv_saknr.

  IF sy-subrc <> 0.
    MESSAGE 'Data not found for given inputs' TYPE 'I'.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0101  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_0101 OUTPUT.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0102  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_0102 OUTPUT.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_0100 OUTPUT.
  SET PF-STATUS 'MAIN'.       " Create GUI Status MAIN in SE41
  SET TITLEBAR 'TIT1'.        " Create Title TIT1 in SE41

ENDMODULE.
