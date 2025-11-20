*&---------------------------------------------------------------------*
*& Report Z_ALVREPORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_ALVREPORT
NO STANDARD PAGE HEADING
MESSAGE-ID Z_MESSAGECLASS.
*DECLARATIONS
DATA : ITBUKRS TYPE TABLE OF T001.
*INPUTS.
INCLUDE : Z_INCLUDE3.
*PROCESS.
START-OF-SELECTION.
PERFORM SUBR_OPENSQL.
*OUTPUT.
END-OF-SELECTION.
CASE SY-SUBRC.
  WHEN '0'.
    PERFORM SUBR_OUTPUT.
  WHEN '4'.
    MESSAGE S005.
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
  SELECT  *
    INTO TABLE  ITBUKRS FROM T001
    WHERE BUKRS IN COMPANY.
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
CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'
 EXPORTING
   I_CALLBACK_PROGRAM             = SY-CPROG
   I_STRUCTURE_NAME               = 'T001'
  TABLES
    T_OUTTAB                      = ITBUKRS
 EXCEPTIONS
   PROGRAM_ERROR                  = 1
   OTHERS                         = 2.

ENDFORM.
