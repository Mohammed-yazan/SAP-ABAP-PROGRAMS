*&---------------------------------------------------------------------*
*& Report Z_SF2_VENDOR
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
REPORT Z_SF2_VENDOR
NO STANDARD PAGE HEADING.

DATA: V1 TYPE KNA1-KUNNR,
      ITAB1 TYPE TABLE OF ZSFSTR.

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.
  PARAMETERS CUSTOMER TYPE KNA1-KUNNR.
SELECTION-SCREEN END OF BLOCK B1.

START-OF-SELECTION.

*--- Convert customer number to internal format (add leading zeros)
CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
  EXPORTING
    INPUT  = CUSTOMER
  IMPORTING
    OUTPUT = CUSTOMER.

*--- Select data
SELECT VBELN ERDAT NETWR WAERK
  INTO TABLE ITAB1
  FROM VBAK
  WHERE KUNNR EQ CUSTOMER.

IF SY-SUBRC = 0.
  CALL FUNCTION '/1BCDWB/SF00000303'
    EXPORTING
      SF_CUSTOMER = CUSTOMER
    TABLES
      ITAB        = ITAB1
    EXCEPTIONS
      FORMATTING_ERROR = 1
      INTERNAL_ERROR   = 2
      SEND_ERROR       = 3
      USER_CANCELED    = 4
      NOTFOUND         = 5
      OTHERS           = 6.
ELSE.
  WRITE: / 'No records found for this customer.'.
ENDIF.
