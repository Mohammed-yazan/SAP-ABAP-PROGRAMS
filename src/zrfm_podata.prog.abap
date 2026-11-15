*&---------------------------------------------------------------------*
*& Report ZRFM_PODATA
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRFM_PODATA
NO STANDARD PAGE HEADING.
*DECLARATIONS.
DATA: ITEKKO TYPE TABLE OF EKKO.
DATA: V1 TYPE EKKO-AEDAT.

*INPUTS
SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE T1.
  PARAMETERS VENDOR TYPE EKKO-LIFNR.
  SELECT-OPTIONS DATE FOR V1.
SELECTION-SCREEN END OF BLOCK B1.
SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME TITLE T2.
 SELECTION-SCREEN ULINE.
 SELECTION-SCREEN COMMENT /1(40) CV.
 SELECTION-SCREEN ULINE.
PARAMETERS: CLNT800 RADIOBUTTON GROUP PO,
            CLNT810 RADIOBUTTON GROUP PO.
SELECTION-SCREEN END OF BLOCK B2.
INITIALIZATION.
T1 = 'SELECT VENDOR NUMBER'.
T2 = 'SELECT ORD CLIENT'.
CV = 'SELECT WHICH CLIENT DATA YOU WANT'.

*PROCESS
START-OF-SELECTION.
IF CLNT800 EQ 'X'.
  CALL FUNCTION 'RFM_PODATA'
    EXPORTING
      RFM_LIFNR        = VENDOR
    TABLES
      RFM_ITEKKO       = ITEKKO
   EXCEPTIONS
     NOTFOUND         = 1
     OTHERS           = 2.
     CASE SY-SUBRC.
          WHEN 0.
            PERFORM SUBR_800OUTPUT.
          WHEN 1.
            MESSAGE 'PO DATA IN CLIENT 800 NOT FOUND' TYPE 'I'.
          WHEN 2.
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                     WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
     ENDCASE.
ELSEIF CLNT810 EQ 'X'.
    CALL FUNCTION 'RFM_PODATA' DESTINATION 'RMCON810'
    EXPORTING
      RFM_LIFNR        = VENDOR
    TABLES
      RFM_ITEKKO       = ITEKKO
   EXCEPTIONS
     NOTFOUND         = 1
     OTHERS           = 2.
          CASE SY-SUBRC.
              WHEN 0.
            PERFORM SUBR_810OUTPUT.
          WHEN 1.
            MESSAGE 'PO DATA IN CLIENT 810 NOT FOUND' TYPE 'I'.
          WHEN 2.
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                     WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
          ENDCASE.

ENDIF.

*OUTPUT FOR 800 CLIENT
FORM SUBR_800OUTPUT .
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
EXPORTING

   I_STRUCTURE_NAME                  = 'EKKO'
   I_GRID_TITLE                      = 'PO DATA FROM CLIENT 800'

  TABLES
    T_OUTTAB                         = ITEKKO
 EXCEPTIONS
   PROGRAM_ERROR                     = 1
   OTHERS                            = 2.
ENDFORM.
*OUTPUT FOR 810 CLIENT
FORM SUBR_810OUTPUT .
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
EXPORTING
   I_STRUCTURE_NAME                  = 'EKKO'
   I_GRID_TITLE                      = 'PO DATA FROM CLIENT 810'

  TABLES
    T_OUTTAB                         = ITEKKO
 EXCEPTIONS
   PROGRAM_ERROR                     = 1
   OTHERS                            = 2.
ENDFORM.
