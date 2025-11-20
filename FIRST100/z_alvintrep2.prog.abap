*&---------------------------------------------------------------------*
*& Report Z_ALVINTREP2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_ALVINTREP2
NO STANDARD PAGE HEADING
MESSAGE-ID Z_MESSAGECLASS.
*DECLARATIONS
TYPES: BEGIN OF TYPE1,
       EBELN TYPE EKKO-EBELN,
       AEDAT TYPE EKKO-AEDAT,
       BSART TYPE EKKO-BSART,
       STATU TYPE EKKO-STATU,
       BUKRS TYPE EKKO-BUKRS,
       LIFNR TYPE EKKO-LIFNR,
       END OF TYPE1.
DATA: ITAB1 TYPE TABLE OF TYPE1,
      WA1   TYPE TYPE1.
TYPE-POOLS: SLIS.
DATA: ITFCAT TYPE SLIS_T_FIELDCAT_ALV,
      WAFCAT TYPE SLIS_FIELDCAT_ALV.
*EVENTS
DATA: ITE    TYPE SLIS_T_EVENT,
      WAE    TYPE SLIS_ALV_EVENT.
*INPUTS
INCLUDE: Z_INCLUDE7.
*PROCESS
START-OF-SELECTION.
PERFORM SUBR_OPENSQL.
END-OF-SELECTION.
*OUTPUTS
CASE SY-SUBRC.
     WHEN 0.
       PERFORM SUBR_FIELDCAT.
       PERFORM SUBR_ASSIGNEVENT.
       PERFORM SUBR_OUTPUT1.
     WHEN 4.
       MESSAGE S002.
ENDCASE.
*&---------------------------------------------------------------------*
*&      Form  SUBR_OPENSQL
*&---------------------------------------------------------------------*
FORM SUBR_OPENSQL.
   SELECT EBELN AEDAT BSART STATU BUKRS LIFNR
    INTO TABLE ITAB1 FROM EKKO WHERE LIFNR EQ VENDOR.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SUBR_FIELDCAT
FORM SUBR_FIELDCAT .
 WAFCAT-COL_POS = 1.
 WAFCAT-FIELDNAME = 'EBELN'.
 WAFCAT-KEY = 'X'.
 WAFCAT-JUST = 'C'.
 WAFCAT-OUTPUTLEN = 20.
 WAFCAT-SELTEXT_M = 'PURCHASE ORDER NO'.
 APPEND WAFCAT TO ITFCAT.
 CLEAR  WAFCAT.

  WAFCAT-COL_POS = 2.
 WAFCAT-FIELDNAME = 'AEDAT'.
 WAFCAT-KEY = 'X'.
 WAFCAT-JUST = 'C'.
 WAFCAT-OUTPUTLEN = 20.
 WAFCAT-SELTEXT_M = 'PO DATE'.
 APPEND WAFCAT TO ITFCAT.
 CLEAR  WAFCAT.

 WAFCAT-COL_POS = 3.
 WAFCAT-FIELDNAME = 'BSART'.
 WAFCAT-KEY = 'X'.
 WAFCAT-JUST = 'C'.
 WAFCAT-OUTPUTLEN = 20.
 WAFCAT-SELTEXT_M = 'ORDER DOCTYPE'.
 APPEND WAFCAT TO ITFCAT.
 CLEAR  WAFCAT.

 WAFCAT-COL_POS = 4.
 WAFCAT-FIELDNAME = 'STATU'.
 WAFCAT-KEY = 'X'.
 WAFCAT-JUST = 'C'.
 WAFCAT-OUTPUTLEN = 20.
 WAFCAT-SELTEXT_M = 'ORDER DOC STATUS'.
 APPEND WAFCAT TO ITFCAT.
 CLEAR  WAFCAT.

 WAFCAT-COL_POS = 5.
 WAFCAT-FIELDNAME = 'BUKRS'.
 WAFCAT-KEY = 'X'.
 WAFCAT-JUST = 'C'.
 WAFCAT-OUTPUTLEN = 20.
 WAFCAT-SELTEXT_M = 'COMPANY CODE'.
 APPEND WAFCAT TO ITFCAT.
 CLEAR  WAFCAT.

 WAFCAT-COL_POS = 6.
 WAFCAT-FIELDNAME = 'LIFNR'.
 WAFCAT-JUST = 'C'.
 WAFCAT-OUTPUTLEN = 20.
 WAFCAT-SELTEXT_M = 'VENDOR NO'.
 APPEND WAFCAT TO ITFCAT.
 CLEAR  WAFCAT.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SUBR_ASSIGNEVENT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SUBR_ASSIGNEVENT .
 WAE-NAME = 'USER_COMMAND'.
 WAE-FORM = 'SUBR_EVENT'.
 APPEND WAE TO ITE.
 CLEAR WAE.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SUBR_OUTPUT1
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SUBR_OUTPUT1 .
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
EXPORTING

   I_CALLBACK_PROGRAM                = SY-CPROG
   I_GRID_TITLE                      = 'PURCHASE ORDER HEADER DATA'
   IT_EVENTS                         = ITE
   IT_FIELDCAT                       = ITFCAT

  TABLES
    T_OUTTAB                          = ITAB1.

ENDFORM.
 FORM SUBR_EVENT USING PV1 TYPE SY-UCOMM PV2 TYPE SLIS_SELFIELD.
 IF PV2-FIELDNAME EQ 'EBELN'.
   SET PARAMETER ID 'PON'
   FIELD PV2-VALUE.
   CALL TRANSACTION 'ME23' AND SKIP FIRST SCREEN.
   ENDIF.
 ENDFORM.
