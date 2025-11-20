
*&---------------------------------------------------------------------*
*& Report Z_SF1_VENDOR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_SF1_VENDOR
NO STANDARD PAGE HEADING.

*INPUT
SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE T1.
    PARAMETERS VENDOR TYPE LFA1-LIFNR OBLIGATORY.
SELECTION-SCREEN END OF BLOCK B1.
INITIALIZATION.
T1 = 'ENTER VENDOR NO'.

*PROCESS
START-OF-SELECTION.
CALL FUNCTION '/1BCDWB/SF00000292'
  EXPORTING

    SF_VENDOR                  = VENDOR
 EXCEPTIONS
   FORMATTING_ERROR           = 1
   INTERNAL_ERROR             = 2
   SEND_ERROR                 = 3
   USER_CANCELED              = 4
   NOT_FOUND                  = 5
   OTHERS                     = 6.


*OUTPUT
