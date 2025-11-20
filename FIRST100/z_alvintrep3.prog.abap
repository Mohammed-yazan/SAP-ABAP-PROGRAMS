*&---------------------------------------------------------------------*
*& Report Z_ALVINTREP3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_ALVINTREP3
NO STANDARD PAGE HEADING
MESSAGE-ID Z_MESSAGECLASS.

*-------------------------------------------------------------*
* TYPE DECLARATIONS
*-------------------------------------------------------------*
TYPES: BEGIN OF TYPE1,
         KUNNR TYPE KNA1-KUNNR,
         NAME1 TYPE KNA1-NAME1,
         LAND1 TYPE KNA1-LAND1,
       END OF TYPE1,
       BEGIN OF TYPE2,
         VBELN TYPE VBAK-VBELN,
         AEDAT TYPE VBAK-AEDAT,
         WAERK TYPE VBAK-WAERK,
         NETWR TYPE VBAK-NETWR,
         KUNNR TYPE VBAK-KUNNR,
       END OF TYPE2.

*-------------------------------------------------------------*
* DATA DECLARATIONS
*-------------------------------------------------------------*
DATA: ITAB1 TYPE TABLE OF TYPE1,
      WA1   TYPE TYPE1,
      ITAB2 TYPE TABLE OF TYPE2,
      WA2   TYPE TYPE2,
      ITAB3 TYPE TABLE OF VBAP.

* ALV declarations
TYPE-POOLS: SLIS.
DATA: ITE TYPE SLIS_T_EVENT,
      WAE TYPE SLIS_ALV_EVENT.

DATA: ITFCAT TYPE SLIS_T_FIELDCAT_ALV,
      WAFCAT TYPE SLIS_FIELDCAT_ALV,
      ITFCAT2 TYPE SLIS_T_FIELDCAT_ALV,
      WAFCAT2 TYPE SLIS_FIELDCAT_ALV.
DATA: V1 TYPE KNA1-KUNNR.
* Selection Screen
SELECT-OPTIONS: CUSTOMER FOR V1.

*-------------------------------------------------------------*
* MAIN LOGIC
*-------------------------------------------------------------*
START-OF-SELECTION.
  PERFORM SUBR_OPENSQL.
END-OF-SELECTION.
  CASE SY-SUBRC.
    WHEN 0.
      PERFORM SUBR_FCAT.
      PERFORM SUBR_ASSIGNEVENT.
      PERFORM SUBR_OUTPUT.
    WHEN 4.
      MESSAGE S001.
  ENDCASE.

*-------------------------------------------------------------*
* FORM ROUTINES
*-------------------------------------------------------------*

FORM SUBR_OPENSQL .
  SELECT KUNNR NAME1 LAND1
    INTO TABLE ITAB1
    FROM KNA1
    WHERE KUNNR IN CUSTOMER.
ENDFORM.

*---------------------------------------------------------------------*
* Field Catalog for Customer List
*---------------------------------------------------------------------*
FORM SUBR_FCAT.
  WAFCAT-FIELDNAME = 'KUNNR'.
  WAFCAT-COL_POS   = 1.
  WAFCAT-SELTEXT_M = 'CUSTOMER NO'.
  APPEND WAFCAT TO ITFCAT.
  CLEAR WAFCAT.

  WAFCAT-FIELDNAME = 'NAME1'.
  WAFCAT-COL_POS   = 2.
  WAFCAT-SELTEXT_M = 'CUSTOMER NAME'.
  APPEND WAFCAT TO ITFCAT.
  CLEAR WAFCAT.

  WAFCAT-FIELDNAME = 'LAND1'.
  WAFCAT-COL_POS   = 3.
  WAFCAT-SELTEXT_M = 'COUNTRY CODE'.
  APPEND WAFCAT TO ITFCAT.
  CLEAR WAFCAT.
ENDFORM.

*---------------------------------------------------------------------*
* Display ALV
*---------------------------------------------------------------------*
FORM SUBR_OUTPUT.
  CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'
    EXPORTING
      I_CALLBACK_PROGRAM = SY-CPROG
      IT_FIELDCAT        = ITFCAT
      IT_EVENTS          = ITE
    TABLES
      T_OUTTAB           = ITAB1.
ENDFORM.

*---------------------------------------------------------------------*
* Assign Event
*---------------------------------------------------------------------*
FORM SUBR_ASSIGNEVENT.
  WAE-NAME = 'USER_COMMAND'.
  WAE-FORM = 'SUBR_EVENT'.
  APPEND WAE TO ITE.
ENDFORM.

*---------------------------------------------------------------------*
* Event Handler for Customer Click
*---------------------------------------------------------------------*
FORM SUBR_EVENT USING PV1 TYPE SY-UCOMM PV2 TYPE SLIS_SELFIELD.
  IF PV2-FIELDNAME EQ 'KUNNR'.
    PERFORM SUBR_OPENSQL2 USING PV2-VALUE.
    PERFORM SUBR_FCAT2.
    IF SY-SUBRC EQ 0.
      PERFORM SUBR_OUTPUT2.
    ELSE.
      MESSAGE S001.
    ENDIF.
  ENDIF.
ENDFORM.

*---------------------------------------------------------------------*
* Fetch Sales Orders for Customer
*---------------------------------------------------------------------*
FORM SUBR_OPENSQL2 USING P_KUNNR TYPE CHAR10.
  SELECT VBELN AEDAT WAERK NETWR KUNNR
    INTO TABLE ITAB2
    FROM VBAK
    WHERE KUNNR = P_KUNNR.
ENDFORM.

*---------------------------------------------------------------------*
* Field Catalog for Sales Orders
*---------------------------------------------------------------------*
FORM SUBR_FCAT2.
  CLEAR ITFCAT2.

  WAFCAT2-FIELDNAME = 'VBELN'.
  WAFCAT2-SELTEXT_M = 'ORDER NUMBER'.
  APPEND WAFCAT2 TO ITFCAT2.
  CLEAR WAFCAT2.

  WAFCAT2-FIELDNAME = 'AEDAT'.
  WAFCAT2-SELTEXT_M = 'ORDER DATE'.
  APPEND WAFCAT2 TO ITFCAT2.
  CLEAR WAFCAT2.

  WAFCAT2-FIELDNAME = 'WAERK'.
  WAFCAT2-SELTEXT_M = 'CURRENCY'.
  APPEND WAFCAT2 TO ITFCAT2.
  CLEAR WAFCAT2.

  WAFCAT2-FIELDNAME = 'NETWR'.
  WAFCAT2-SELTEXT_M = 'NET VALUE'.
  APPEND WAFCAT2 TO ITFCAT2.
  CLEAR WAFCAT2.

  WAFCAT2-FIELDNAME = 'KUNNR'.
  WAFCAT2-SELTEXT_M = 'SOLD TO PARTY'.
  APPEND WAFCAT2 TO ITFCAT2.
  CLEAR WAFCAT2.
ENDFORM.

*---------------------------------------------------------------------*
* Display Sales Orders
*---------------------------------------------------------------------*
FORM SUBR_OUTPUT2.
  CLEAR WAE.
  WAE-NAME = 'USER_COMMAND'.
  WAE-FORM = 'SUBR_EVENT3'.
  APPEND WAE TO ITE.

  CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'
    EXPORTING
      I_CALLBACK_PROGRAM = SY-CPROG
      IT_FIELDCAT        = ITFCAT2
      IT_EVENTS          = ITE
    TABLES
      T_OUTTAB           = ITAB2.
ENDFORM.

*---------------------------------------------------------------------*
* Event Handler for Order Click
*---------------------------------------------------------------------*
FORM SUBR_EVENT3 USING PV3 TYPE SY-UCOMM PV4 TYPE SLIS_SELFIELD.
  IF PV4-FIELDNAME = 'VBELN'.
    PERFORM SUBR_OPENSQL3 USING PV4-VALUE.
    IF SY-SUBRC EQ 0.
      PERFORM SUBR_OUTPUT3.
    ELSE.
      MESSAGE S003.
    ENDIF.
  ENDIF.
ENDFORM.

*---------------------------------------------------------------------*
* Fetch VBAP (Order Item) Details
*---------------------------------------------------------------------*
FORM SUBR_OPENSQL3 USING P_VBELN TYPE VBAP-VBELN.
  SELECT * INTO TABLE ITAB3 FROM VBAP WHERE VBELN = P_VBELN.
ENDFORM.

*---------------------------------------------------------------------*
* Display VBAP Items
*---------------------------------------------------------------------*
FORM SUBR_OUTPUT3.
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      I_CALLBACK_PROGRAM = SY-CPROG
      I_GRID_TITLE       = 'SALES ORDER ITEM DETAILS'
    TABLES
      T_OUTTAB           = ITAB3.
ENDFORM.
