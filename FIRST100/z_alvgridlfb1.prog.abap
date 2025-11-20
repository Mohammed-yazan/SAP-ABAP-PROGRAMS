*&---------------------------------------------------------------------*
*& Report Z_ALVGRIDLFB1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_ALVGRIDLFB1
NO STANDARD PAGE HEADING
MESSAGE-ID Z_MESSAGECLASS.
DATA: BEGIN OF ITAB OCCURS 0,
       BUKRS TYPE LFB1-BUKRS,
       LIFNR TYPE LFB1-LIFNR,
       PERNR TYPE LFB1-PERNR,
       AKONT TYPE LFB1-AKONT,
       END OF ITAB.

INCLUDE: Z_INCLUDELFB1.

START-OF-SELECTION.
PERFORM SUBR_OPENSQL.
END-OF-SELECTION.
CASE SY-SUBRC.
  WHEN 0.
    PERFORM SUBR_OUTPUT.
  WHEN 4.
    MESSAGE S002.
 ENDCASE.

FORM SUBR_OPENSQL.
  SELECT  BUKRS LIFNR PERNR
     AKONT INTO TABLE  ITAB
    FROM LFB1 WHERE  BUKRS
    IN COMPANY.
ENDFORM.
*
FORM SUBR_OUTPUT .
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
   I_CALLBACK_PROGRAM                = SY-CPROG
   I_STRUCTURE_NAME                  = 'LFB1'
   I_GRID_TITLE                      = 'VENDOR ACCOUNTS DATA'
  TABLES
    T_OUTTAB                         = ITAB.
ENDFORM.
