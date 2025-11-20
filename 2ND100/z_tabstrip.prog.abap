*&---------------------------------------------------------------------*
*& Module Pool       Z_TABSTRIP
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
PROGRAM Z_TABSTRIP.

*&SPWIZARD: FUNCTION CODES FOR TABSTRIP 'TSTRIP'
CONSTANTS: BEGIN OF C_TSTRIP,
             TAB1 LIKE SY-UCOMM VALUE 'TSTRIP_FC1',
             TAB2 LIKE SY-UCOMM VALUE 'TSTRIP_FC2',
           END OF C_TSTRIP.
*&SPWIZARD: DATA FOR TABSTRIP 'TSTRIP'
CONTROLS:  TSTRIP TYPE TABSTRIP.
DATA:      BEGIN OF G_TSTRIP,
             SUBSCREEN   LIKE SY-DYNNR,
             PROG        LIKE SY-REPID VALUE 'Z_TABSTRIP',
             PRESSED_TAB LIKE SY-UCOMM VALUE C_TSTRIP-TAB1,
           END OF G_TSTRIP.
DATA:      OK_CODE LIKE SY-UCOMM.

*&SPWIZARD: OUTPUT MODULE FOR TS 'TSTRIP'. DO NOT CHANGE THIS LINE!
*&SPWIZARD: SETS ACTIVE TAB
MODULE TSTRIP_ACTIVE_TAB_SET OUTPUT.
  TSTRIP-ACTIVETAB = G_TSTRIP-PRESSED_TAB.
  CASE G_TSTRIP-PRESSED_TAB.
    WHEN C_TSTRIP-TAB1.
      G_TSTRIP-SUBSCREEN = '0202'.
    WHEN C_TSTRIP-TAB2.
      G_TSTRIP-SUBSCREEN = '0203'.
    WHEN OTHERS.
*&SPWIZARD:      DO NOTHING
  ENDCASE.
ENDMODULE.

*&SPWIZARD: INPUT MODULE FOR TS 'TSTRIP'. DO NOT CHANGE THIS LINE!
*&SPWIZARD: GETS ACTIVE TAB
MODULE TSTRIP_ACTIVE_TAB_GET INPUT.
  OK_CODE = SY-UCOMM.
  CASE OK_CODE.
    WHEN C_TSTRIP-TAB1.
      G_TSTRIP-PRESSED_TAB = C_TSTRIP-TAB1.
    WHEN C_TSTRIP-TAB2.
      G_TSTRIP-PRESSED_TAB = C_TSTRIP-TAB2.
    WHEN OTHERS.
*&SPWIZARD:      DO NOTHING
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0201  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

TABLES: lfa1.

DATA: BEGIN OF itab,
        lifnr TYPE lfa1-lifnr,
        name1 TYPE lfa1-name1,
        name2 TYPE lfa1-name2,
        telf1 TYPE lfa1-telf1,
        stras TYPE lfa1-stras,
        ort01 TYPE lfa1-ort01,
        land1 TYPE lfa1-land1,
      END OF itab.

MODULE user_command_0201 INPUT.
  CASE sy-ucomm.
    WHEN 'FIND'.
      CLEAR itab.
      SELECT SINGLE lifnr name1 name2 telf1 stras ort01 land1
        INTO itab
        FROM lfa1
        WHERE lifnr = lfa1-lifnr.  " directly using screen field
      IF sy-subrc <> 0.
        MESSAGE 'NOT FOUND' TYPE 'I'.
      ENDIF.
  ENDCASE.
ENDMODULE.

MODULE status_0202 OUTPUT.
  MOVE-CORRESPONDING itab TO lfa1.
ENDMODULE.
INCLUDE z_tabstrip_status_0110o01.
