*&---------------------------------------------------------------------*
*& Module Pool       Z_TABSTRIP2
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
PROGRAM Z_TABSTRIP2.

*&SPWIZARD: FUNCTION CODES FOR TABSTRIP 'TSTRIPP'
CONSTANTS: BEGIN OF C_TSTRIPP,
             TAB1 LIKE SY-UCOMM VALUE 'TSTRIPP_FC1',
             TAB2 LIKE SY-UCOMM VALUE 'TSTRIPP_FC2',
           END OF C_TSTRIPP.
*&SPWIZARD: DATA FOR TABSTRIP 'TSTRIPP'
CONTROLS:  TSTRIPP TYPE TABSTRIP.
DATA:      BEGIN OF G_TSTRIPP,
             SUBSCREEN   LIKE SY-DYNNR,
             PROG        LIKE SY-REPID VALUE 'Z_TABSTRIP2',
             PRESSED_TAB LIKE SY-UCOMM VALUE C_TSTRIPP-TAB1,
           END OF G_TSTRIPP.
DATA:      OK_CODE LIKE SY-UCOMM.

*&SPWIZARD: OUTPUT MODULE FOR TS 'TSTRIPP'. DO NOT CHANGE THIS LINE!
*&SPWIZARD: SETS ACTIVE TAB
MODULE TSTRIPP_ACTIVE_TAB_SET OUTPUT.
  TSTRIPP-ACTIVETAB = G_TSTRIPP-PRESSED_TAB.
  CASE G_TSTRIPP-PRESSED_TAB.
    WHEN C_TSTRIPP-TAB1.
      G_TSTRIPP-SUBSCREEN = '0101'.
    WHEN C_TSTRIPP-TAB2.
      G_TSTRIPP-SUBSCREEN = '0102'.
    WHEN OTHERS.
*&SPWIZARD:      DO NOTHING
  ENDCASE.
ENDMODULE.

*&SPWIZARD: INPUT MODULE FOR TS 'TSTRIPP'. DO NOT CHANGE THIS LINE!
*&SPWIZARD: GETS ACTIVE TAB
MODULE TSTRIPP_ACTIVE_TAB_GET INPUT.
  OK_CODE = SY-UCOMM.
  CASE OK_CODE.
    WHEN C_TSTRIPP-TAB1.
      G_TSTRIPP-PRESSED_TAB = C_TSTRIPP-TAB1.
    WHEN C_TSTRIPP-TAB2.
      G_TSTRIPP-PRESSED_TAB = C_TSTRIPP-TAB2.
    WHEN OTHERS.
*&SPWIZARD:      DO NOTHING
  ENDCASE.
ENDMODULE.
TABLES: kna1.

DATA: BEGIN OF itab,
        kunnr TYPE kna1-kunnr,
        name1 TYPE kna1-name1,
        name2 TYPE kna1-name2,
        land1 TYPE kna1-land1,
        ort01 TYPE kna1-ort01,
        pstlz TYPE kna1-pstlz,
        regio TYPE kna1-regio,
        telfx TYPE kna1-telfx,
        stras TYPE kna1-stras,
      END OF itab.

MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'FIND'.
      CLEAR itab.
      SELECT SINGLE kunnr name1 name2 land1 stras ort01 pstlz regio telfx
        INTO itab
        FROM kna1
        WHERE kunnr = kna1-kunnr.  " screen field directly

      IF sy-subrc <> 0.
        MESSAGE 'CUSTOMER INFO NOT FOUND' TYPE 'I'.
        CLEAR itab.
      ENDIF.

    WHEN 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.

MODULE status_0110 OUTPUT.
  MOVE-CORRESPONDING itab TO kna1.  " pushes data to screen fields
ENDMODULE.
