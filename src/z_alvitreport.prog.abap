*&---------------------------------------------------------------------*
*& Report Z_ALVITREPORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_ALVITREPORT
NO STANDARD PAGE HEADING
MESSAGE-ID Z_MESSAGECLASS.
*DECLARATIONS.
DATA : ITAB1 TYPE TABLE OF VBAK,
       ITAB2 TYPE TABLE OF VBAP.
*EVENTS
TYPE-POOLS: SLIS.
DATA: ITE TYPE SLIS_T_EVENT,
      WA  TYPE SLIS_ALV_EVENT.
*INPUTS
INCLUDE: Z_INCLUDE6.
*PROCESS
START-OF-SELECTION.
PERFORM SUBR_OPENSQL.
END-OF-SELECTION.
*OUTPUT
CASE SY-SUBRC.
     WHEN 0.
       PERFORM SUBR_EVENT.
       PERFORM SUBR_OUTPUT1.
     WHEN 4.
       MESSAGE S001.
ENDCASE.
*&---------------------------------------------------------------------*
*&      Form  SUBR_OPENSQL
*&---------------------------------------------------------------------*
FORM SUBR_OPENSQL .
SELECT * INTO TABLE ITAB1 FROM VBAK WHERE  ERDAT IN DATE.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SUBR_OUTPUT1
*&---------------------------------------------------------------------*
FORM SUBR_OUTPUT1 .
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
   I_CALLBACK_PROGRAM                = SY-CPROG
   I_STRUCTURE_NAME                  = 'VBAK'
   I_GRID_TITLE                      = 'SALES ORDER HEADER DATA'
   IT_EVENTS                         =  ITE
  TABLES
    T_OUTTAB                         = ITAB1.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SUBR_EVENT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SUBR_EVENT .
WA-NAME = 'USER_COMMAND'.
WA-FORM  = 'SUBR_EVENT2'.
APPEND WA TO ITE.
CLEAR WA.
ENDFORM.

*SUBROUTINE FOR 2ND DISPLAY.
FORM SUBR_EVENT2 USING PV1 TYPE SY-UCOMM PV2 TYPE SLIS_SELFIELD.
  DATA V2(10) TYPE N.
  IF PV2-FIELDNAME = 'VBELN'.
    V2 = PV2-VALUE.
    PERFORM SUBR_OPENSQL2 USING V2.
    IF SY-SUBRC EQ 0.
      PERFORM SUBR_OUTPUT2.
    ELSE.
      MESSAGE S001.
    ENDIF.
  ENDIF.
  ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SUBR_OPENSQL2
*&---------------------------------------------------------------------*
FORM SUBR_OPENSQL2  USING    P_V2.
  SELECT * INTO TABLE ITAB2 FROM VBAP WHERE VBELN EQ P_V2.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SUBR_OUTPUT2
*&---------------------------------------------------------------------*

FORM SUBR_OUTPUT2 .
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
  I_CALLBACK_PROGRAM                 = SY-CPROG
  I_STRUCTURE_NAME                   = 'VBAP'
  I_GRID_TITLE                       = 'SALES ORDER INFO'
  IT_EVENTS                          = ITE
  TABLES
    T_OUTTAB                         = ITAB2.

ENDFORM.
