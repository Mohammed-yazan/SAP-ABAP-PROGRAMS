*&---------------------------------------------------------------------*
*& Module Pool       Z_DDKNA1VBAK
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------
*&---------------------------------------------------------------------*
*&      Module  CUSTOMER  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
PROGRAM Z_DDKNA1VBAK.
TABLES: VBAK, KNA1.
DATA: BEGIN OF ITAB1 OCCURS 0,
    VBELN TYPE VBAK-VBELN,
    END OF ITAB1.
DATA: BEGIN OF DULHAN OCCURS 0,
      VBELN TYPE VBAK-VBELN,
      ERDAT TYPE VBAK-ERDAT,
      WAERK TYPE VBAK-WAERK,
      NETWR TYPE VBAK-NETWR,
      VKORG TYPE VBAK-VKORG,
      NAME1 TYPE KNA1-NAME1,
      LAND1 TYPE KNA1-LAND1,
      ORT01 TYPE KNA1-ORT01,
      TELF1 TYPE KNA1-TELF1,
      END OF DULHAN.
MODULE CUSTOMER INPUT.
SELECT VBELN INTO TABLE ITAB1
 FROM VBAK
 WHERE KUNNR EQ KNA1-KUNNR.

IF SY-SUBRC NE 0.
MESSAGE 'CUSTOMER NOT FOUND' TYPE 'I'.
ELSE.
CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
  EXPORTING
   RETFIELD              = 'VBELN'
   DYNPPROG               = 'Z_DDKNA1VBAK'
   DYNPNR                 = '0100'
    DYNPROFIELD           = 'VBAK-VBELN'
   VALUE_ORG              = 'S'
  TABLES
    VALUE_TAB       =  ITAB1
 EXCEPTIONS
   PARAMETER_ERROR        = 1
   NO_VALUES_FOUND        = 2
   OTHERS                 = 3.
          .
IF SY-SUBRC <> 0.
MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.
ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT.
CASE SY-UCOMM.
WHEN 'FIND'.
 SELECT A~VBELN A~ERDAT A~WAERK A~NETWR A~VKORG
             B~NAME1 B~LAND1 B~ORT01 B~TELF1
        INTO TABLE DULHAN
        FROM VBAK AS A
        INNER JOIN KNA1 AS B
          ON A~KUNNR = B~KUNNR
        WHERE A~VBELN = VBAK-VBELN.
IF SY-SUBRC = 0.
CALL SCREEN '0200'.
ELSE.
MESSAGE 'NO DATA FOUND FOR THIS SALES ORDER' TYPE 'I'.
ENDIF.
ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

MODULE USER_COMMAND_0200 INPUT.

CASE SY-UCOMM.
WHEN 'BACK'.
CALL SCREEN '0100'.
WHEN 'EXIT'.
LEAVE PROGRAM.
ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0200  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_0200 OUTPUT.
  SET PF-STATUS 'MAIN'.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_0100 OUTPUT.
 SET PF-STATUS 'MAIN'.
ENDMODULE.
