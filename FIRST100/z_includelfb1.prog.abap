*&---------------------------------------------------------------------*
*&  Include           Z_INCLUDELFB1
*&---------------------------------------------------------------------*
DATA: V1 TYPE LFB1-BUKRS.
SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE T1.
  SELECT-OPTIONS COMPANY FOR V1 OBLIGATORY.
SELECTION-SCREEN END OF BLOCK B1.
INITIALIZATION.
T1 = 'VENDOR DATA'.
