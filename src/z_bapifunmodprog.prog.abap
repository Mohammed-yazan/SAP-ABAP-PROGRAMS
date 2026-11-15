*&---------------------------------------------------------------------*
*& Report Z_BAPIFUNMODPROG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_BAPIFUNMODPROG.

*---------------------------------------------------------------------
* PARAMETERS
*---------------------------------------------------------------------
PARAMETERS: P_BUKRS TYPE BUKRS,
            P_LIFNR TYPE LIFNR,
            P_DATE  TYPE BUDAT.

*---------------------------------------------------------------------
* INTERNAL TABLES AND WORK AREAS
*---------------------------------------------------------------------
DATA: IT_DATA TYPE TABLE OF ZBAPI_STRUCT1,
      WA_DATA TYPE  ZBAPI_STRUCT1.

DATA: IT_BAPI TYPE TABLE OF BAPI3008_2,
      WA_BAPI TYPE BAPI3008_2.

DATA: WA_RETURN TYPE BAPIRETURN.

*---------------------------------------------------------------------
* CALL THE BAPI
*---------------------------------------------------------------------
CALL FUNCTION 'BAPI_AP_ACC_GETOPENITEMS'
  EXPORTING
    COMPANYCODE = P_BUKRS
    VENDOR      = P_LIFNR
    KEYDATE     = P_DATE
  IMPORTING
    RETURN      = WA_RETURN
  TABLES
    LINEITEMS   = IT_BAPI.

*---------------------------------------------------------------------
* ERROR CHECK
*---------------------------------------------------------------------
IF WA_RETURN-TYPE = 'E'.
  MESSAGE WA_RETURN-MESSAGE TYPE 'E'.
ENDIF.

*---------------------------------------------------------------------
* MOVE DATA FROM BAPI TABLE TO OUR TABLE (ONLY 10 FIELDS)
*---------------------------------------------------------------------
LOOP AT IT_BAPI INTO WA_BAPI.

  CLEAR WA_DATA.

  WA_DATA-COMP_CODE  = WA_BAPI-COMP_CODE.
  WA_DATA-VENDOR_NO    = WA_BAPI-VENDOR.
  WA_DATA-SP_GL_IND  = WA_BAPI-SP_GL_IND.
  WA_DATA-CLEAR_DATE = WA_BAPI-CLEAR_DATE.
  WA_DATA-CLR_DOC_NO = WA_BAPI-CLR_DOC_NO.
  WA_DATA-FISC_YEAR  = WA_BAPI-FISC_YEAR.
  WA_DATA-AC_DOC_NO  = WA_BAPI-DOC_NO.
  WA_DATA-ITEM_NUM   = WA_BAPI-ITEM_NUM.
  WA_DATA-PSTNG_DATE = WA_BAPI-PSTNG_DATE.

  APPEND WA_DATA TO IT_DATA.

ENDLOOP.

*---------------------------------------------------------------------
* SIMPLE FIELD CATALOG FOR ALV
*---------------------------------------------------------------------
DATA: IT_FCAT TYPE SLIS_T_FIELDCAT_ALV,
      WA_FCAT TYPE SLIS_FIELDCAT_ALV.

CLEAR WA_FCAT.
WA_FCAT-FIELDNAME = 'COMP_CODE'.
WA_FCAT-SELTEXT_M = 'COMPANY CODE'.
APPEND WA_FCAT TO IT_FCAT.

CLEAR WA_FCAT.
WA_FCAT-FIELDNAME = 'VENDOR'.
WA_FCAT-SELTEXT_M = 'VENDOR'.
APPEND WA_FCAT TO IT_FCAT.

CLEAR WA_FCAT.
WA_FCAT-FIELDNAME = 'SP_GL_IND'.
WA_FCAT-SELTEXT_M = 'SP.GL'.
APPEND WA_FCAT TO IT_FCAT.

CLEAR WA_FCAT.
WA_FCAT-FIELDNAME = 'CLEAR_DATE'.
WA_FCAT-SELTEXT_M = 'CLEAR DATE'.
APPEND WA_FCAT TO IT_FCAT.

CLEAR WA_FCAT.
WA_FCAT-FIELDNAME = 'CLR_DOC_NO'.
WA_FCAT-SELTEXT_M = 'CLR DOC'.
APPEND WA_FCAT TO IT_FCAT.

CLEAR WA_FCAT.
WA_FCAT-FIELDNAME = 'FISC_YEAR'.
WA_FCAT-SELTEXT_M = 'YEAR'.
APPEND WA_FCAT TO IT_FCAT.

CLEAR WA_FCAT.
WA_FCAT-FIELDNAME = 'DOC_NO'.
WA_FCAT-SELTEXT_M = 'DOC NO'.
APPEND WA_FCAT TO IT_FCAT.

CLEAR WA_FCAT.
WA_FCAT-FIELDNAME = 'ITEM_NUM'.
WA_FCAT-SELTEXT_M = 'ITEM'.
APPEND WA_FCAT TO IT_FCAT.

CLEAR WA_FCAT.
WA_FCAT-FIELDNAME = 'PSTNG_DATE'.
WA_FCAT-SELTEXT_M = 'POSTING DATE'.
APPEND WA_FCAT TO IT_FCAT.

*---------------------------------------------------------------------
* ALV GRID DISPLAY
*---------------------------------------------------------------------
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
  EXPORTING
    IT_FIELDCAT = IT_FCAT
  TABLES
    T_OUTTAB    = IT_DATA.
