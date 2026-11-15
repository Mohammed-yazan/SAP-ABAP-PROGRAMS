*&---------------------------------------------------------------------*
*& Report Z_OPENSQLP4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_OPENSQLP4.

TYPES: BEGIN OF TYPE1,
       EBELN TYPE EKKO-EBELN,
       AEDAT TYPE EKKO-AEDAT,
       BSART TYPE EKKO-BSART,
       BUKR  TYPE EKKO-BUKRS,
       LIFNR TYPE EKKO-LIFNR,
       END OF TYPE1.

      DATA: ITAB TYPE TABLE OF TYPE1,
            WA TYPE TYPE1.

     DATA: VAEDAT TYPE EKKO-AEDAT,
           VCOUNT TYPE I,
           VEBELN TYPE EKKO-VEBELN.

     PARAMETER TY
     SELECT-OPTIONS : VENDOR FOR
