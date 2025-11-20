*&---------------------------------------------------------------------*
*& Report Z_ALVREPFOOD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_ALVREPFOOD.
DATA V1 TYPE ZFOODCOURT-SALESID.
DATA: ITFOOD TYPE TABLE OF ZFOODCOURT.
SELECTION-SCREEN BEGIN OF BLOCK B1.
  SELECT-OPTIONS SALESNO FOR V1.
SELECTION-SCREEN END OF BLOCK B1.
START-OF-SELECTION.
CASE SY-SUBRC.
     WHEN 0.
       PERFORM SUBR_OPENSQL.
       PERFORM SUBR_OUTPUT.
     WHEN 4.
       MESSAGE 'SALESID NOT FOUND' TYPE 'I'.
ENDCASE.
*&---------------------------------------------------------------------*
*&      Form  SUBR_OPENSQL
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SUBR_OPENSQL .
SELECT * INTO TABLE ITFOOD FROM ZFOODCOURT WHERE SALESID IN SALESNO.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  SUBR_OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SUBR_OUTPUT .
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
EXPORTING
  I_CALLBACK_PROGRAM                = SY-CPROG
  I_STRUCTURE_NAME                  = 'ZFOODCOURT'
  I_GRID_TITLE                      = 'FOODDATA FROM ZFOODCOURT'

  TABLES
    T_OUTTAB                        = ITFOOD
 EXCEPTIONS
   PROGRAM_ERROR                     = 1
   OTHERS                            = 2.

ENDFORM.
