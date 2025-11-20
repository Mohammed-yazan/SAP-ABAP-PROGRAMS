

PROGRAM Z_FICO.
TABLES:SKA1,SKAT,BSAS.
DATA: BEGIN OF ITAB OCCURS 0,
      BUKRS TYPE BSAS-BUKRS,
      AUGDT TYPE BSAS-AUGDT,
      HKONT TYPE BSAS-HKONT,
      DMBTR TYPE BSAS-DMBTR,
      GJAHR TYPE BSAS-GJAHR,
      BUDAT TYPE BSAS-BUDAT,
      SAKNR TYPE SKA1-SAKNR,
      KTOPL TYPE SKA1-KTOPL,
      TXT20 TYPE SKAT-TXT20,
  END OF ITAB.
 MODULE USER_COMMAND_0100 INPUT.
   CASE SY-UCOMM.
     WHEN 'FIND'.
       SELECT A~BUKRS A~AUGDT A~HKONT A~DMBTR A~GJAHR A~BUDAT
              B~SAKNR B~KTOPL
              C~TXT20
              INTO TABLE ITAB FROM
              BSAS AS A
              INNER JOIN SKA1 AS B
              ON A~HKONT = B~SAKNR
              INNER JOIN SKAT AS C
              ON B~SAKNR = C~SAKNR
              AND B~KTOPL = C~KTOPL
              AND C~SPRAS = SY-LANGU
              WHERE BUKRS EQ ITAB-BUKRS AND HKONT EQ ITAB-SAKNR AND GJAHR EQ ITAB-GJAHR
              AND BUDAT EQ ITAB-BUDAT.
     IF SY-SUBRC NE 0.
         MESSAGE 'ACCOUNT NOT FOUND' TYPE 'S'.

       ENDIF.
       WHEN 'EXIT'.
         LEAVE PROGRAM.
ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0101  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_0101 OUTPUT.
MOVE-CORRESPONDING ITAB TO BSAS.
SKAT-TXT20 = ITAB-TXT20.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0102  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_0102 OUTPUT.
MOVE-CORRESPONDING ITAB TO SKA1.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_0100 OUTPUT.

ENDMODULE.
