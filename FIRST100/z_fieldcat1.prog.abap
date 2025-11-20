*&---------------------------------------------------------------------*
*& Report Z_FIELDCAT1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_FIELDCAT1
NO STANDARD PAGE HEADING
MESSAGE-ID Z_MESSAGECLASS.
*DECLARATIONS.
TYPES: BEGIN OF TYPE1,
      KUNNR TYPE KNA1-KUNNR,
      NAME1 TYPE KNA1-NAME1,
      LAND1 TYPE KNA1-LAND1,
      VBELN TYPE VBAK-VBELN,
      AUDAT TYPE VBAK-AUDAT,
      WAERK TYPE VBAK-WAERK,
      END OF TYPE1.
DATA: ITKUNNR TYPE TABLE OF TYPE1.

*GLOBAL DECLARATIONS.
   TYPE-POOLS : SLIS.
*fieldcat data object & work area
  DATA : ITFCAT TYPE SLIS_T_FIELDCAT_ALV,
         WAFCAT TYPE SLIS_FIELDCAT_ALV.

*INPUTS.
INCLUDE: Z_KUNNR.

*PROCESS.
START-OF-SELECTION.
PERFORM SUBR_OPENSQL.
END-OF-SELECTION.
*OUTPUTS
CASE SY-SUBRC.
  WHEN 0.
    PERFORM SUBR_FIELDCAT.
    PERFORM SUBR_OUTPUT.
  WHEN 4.
    MESSAGE S001.
  ENDCASE.
*SELECT QUERY
FORM SUBR_OPENSQL .
SELECT A~KUNNR NAME1 LAND1
       B~VBELN AUDAT WAERK
       INTO TABLE ITKUNNR
       FROM KNA1 AS A
       INNER JOIN
       VBAK AS B
       ON A~KUNNR = B~KUNNR
       WHERE A~KUNNR IN CUSTOMER
       AND   SPRAS = SY-LANGU.
ENDFORM.

FORM SUBR_FIELDCAT .
   WAFCAT-COL_POS    =  1.
   WAFCAT-FIELDNAME  =  'KUNNR'.
   WAFCAT-KEY        =  'X'.
   WAFCAT-JUST       =  'C'.
   WAFCAT-OUTPUTLEN  =  20.
   WAFCAT-SELTEXT_M  = 'CUSTOMER NO'.
   APPEND WAFCAT TO ITFCAT.
   CLEAR WAFCAT.

   WAFCAT-COL_POS    =  2.
   WAFCAT-FIELDNAME  =  'NAME1'.
   WAFCAT-KEY        =  'X'.
   WAFCAT-JUST       =  'C'.
   WAFCAT-OUTPUTLEN  =  20.
   WAFCAT-SELTEXT_M  = 'CUSTOMER NAME'.
   APPEND WAFCAT TO ITFCAT.
   CLEAR WAFCAT.

   WAFCAT-COL_POS    =  3.
   WAFCAT-FIELDNAME  =  'LAND1'.
   WAFCAT-KEY        =  'X'.
   WAFCAT-JUST       =  'C'.
   WAFCAT-OUTPUTLEN  =  20.
   WAFCAT-SELTEXT_M  = 'COUNTRY CODE'.
   APPEND WAFCAT TO ITFCAT.
   CLEAR WAFCAT.




      WAFCAT-COL_POS    =  4.
   WAFCAT-FIELDNAME  =  'VBELN'.
   WAFCAT-KEY        =  'X'.
   WAFCAT-JUST       =  'C'.
   WAFCAT-OUTPUTLEN  =  20.
   WAFCAT-SELTEXT_M  = 'ORDER NO'.
   APPEND WAFCAT TO ITFCAT.
   CLEAR WAFCAT.

      WAFCAT-COL_POS    =  5.
   WAFCAT-FIELDNAME  =  'AUDAT'.
   WAFCAT-KEY        =  'X'.
   WAFCAT-JUST       =  'C'.
   WAFCAT-OUTPUTLEN  =  20.
   WAFCAT-SELTEXT_M  = 'ORDER DATE'.
   APPEND WAFCAT TO ITFCAT.
   CLEAR WAFCAT.


     WAFCAT-COL_POS    =  6.
   WAFCAT-FIELDNAME  =  'WAERK'.
   WAFCAT-KEY        =  'X'.
   WAFCAT-JUST       =  'C'.
   WAFCAT-OUTPUTLEN  =  20.
   WAFCAT-SELTEXT_M  = 'CURRENCY KEY'.
   APPEND WAFCAT TO ITFCAT.
   CLEAR WAFCAT.


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
   I_GRID_TITLE                      = 'CUSTOMER DATA'
   IT_FIELDCAT                       = ITFCAT

  TABLES
    T_OUTTAB                          = ITKUNNR.


ENDFORM.
