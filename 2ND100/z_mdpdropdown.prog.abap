*&---------------------------------------------------------------------*
*& Module Pool       Z_MDPDROPDOWN
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
PROGRAM Z_MDPDROPDOWN.
TABLES : LFA1, EKKO.

DATA: BEGIN OF ITAB OCCURS 0,
      EBELN TYPE EKKO-EBELN,
      END OF ITAB.
MODULE ORDER INPUT.
SELECT EBELN INTO TABLE ITAB FROM EKKO WHERE LIFNR EQ LFA1-LIFNR.
  IF SY-SUBRC NE 0.
    MESSAGE 'NO PURCHASE ORDER DATA FOUND' TYPE 'S'.
   ELSE.
     CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
       EXPORTING

         RETFIELD              = 'EBELN'
        DYNPPROG               = 'Z_MDPDROPDOWN'
        DYNPNR                 = '0100'
        DYNPROFIELD            = 'EKKO-EBELN'
        VALUE_ORG              = 'C'
       TABLES
         VALUE_TAB              = ITAB

      EXCEPTIONS
        PARAMETER_ERROR        = 1
        NO_VALUES_FOUND        = 2
        OTHERS                 = 3
               .
     IF SY-SUBRC <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER  SY-MSGNO WITH  SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
     ENDIF.
     ENDIF.

ENDMODULE.
