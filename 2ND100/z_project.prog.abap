*&---------------------------------------------------------------------*
*&  Include           Z_PROJECT
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE T1.
  PARAMETERS : P_LIFNR TYPE LFA1-LIFNR OBLIGATORY,
               BUKRS TYPE BKPF-BUKRS,
               GJAHR TYPE BSEG-GJAHR.
SELECTION-SCREEN END OF BLOCK B1.
INITIALIZATION.
T1 = 'VENDOR INFORMATION'.
