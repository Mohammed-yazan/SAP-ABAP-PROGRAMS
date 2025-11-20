*&---------------------------------------------------------------------*
*&  Include           Z_INCLUDE9
*&---------------------------------------------------------------------*
DATA: V1 TYPE KNA1-KUNNR.
SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE  T1.
  SELECT-OPTIONS CUSTOMER FOR V1.
SELECTION-SCREEN END OF BLOCK B1.
INITIALIZATION.
T1 = 'ENTER CUSTOMER NUMBER'.
