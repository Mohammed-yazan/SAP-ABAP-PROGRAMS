*&---------------------------------------------------------------------*
*& Report Z_PROJECT1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_PROJECT1
NO STANDARD PAGE HEADING
MESSAGE-ID Z_MESSAGECLASS.
*DECLARATIONS.
TYPES :BEGIN OF TYPE1,
         LIFNR TYPE BSEG-LIFNR,
         BUKRS TYPE BKPF-BUKRS,
         BELNR TYPE BSEG-BELNR,
         GJAHR TYPE BSEG-GJAHR,
         BLDAT TYPE BKPF-BLDAT,
         DMBTR TYPE BSEG-DMBTR,
         WAERS TYPE BKPF-WAERS,
       END OF TYPE1.
DATA: ITAB TYPE STANDARD TABLE OF TYPE1 WITH EMPTY KEY.
*INPUTS.
      INCLUDE : Z_PROJECT.
*PROCESS.
      START-OF-SELECTION.
      PERFORM SUBR_OPENSQL.
      END-OF-SELECTION.
*OUTPUTS.
      CASE SY-SUBRC.
        WHEN 0.
          PERFORM SUBR_OUTPUT.
        WHEN 4.
          MESSAGE S002.
        ENDCASE.
FORM SUBR_OPENSQL .

  CLEAR ITAB.

  SELECT A~LIFNR
         B~BUKRS
         A~BELNR
         A~GJAHR
         B~BLDAT
         A~DMBTR
         B~WAERS
    INTO CORRESPONDING FIELDS OF TABLE ITAB
    FROM BSEG AS A
    INNER JOIN BKPF AS B
      ON A~BELNR = B~BELNR
     AND A~GJAHR = B~GJAHR
    WHERE A~LIFNR = P_LIFNR.

  IF ITAB IS INITIAL.
    CLEAR ITAB.
  ENDIF.


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
 IF ITAB IS INITIAL.
    MESSAGE 'No records found for the selection' TYPE 'I'.
    RETURN.
  ENDIF.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      I_CALLBACK_PROGRAM = SY-CPROG
      I_STRUCTURE_NAME   = ''
      I_GRID_TITLE       = 'VENDOR INVOICE'
    TABLES
      T_OUTTAB           = ITAB.
ENDFORM.
