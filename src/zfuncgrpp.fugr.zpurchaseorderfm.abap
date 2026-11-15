FUNCTION ZPURCHASEORDERFM.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(FM_EBELN) TYPE  EKKO-EBELN
*"  EXPORTING
*"     REFERENCE(FM_EKKO) LIKE  EKKO STRUCTURE  EKKO
*"     REFERENCE(FM_LFA1) LIKE  LFA1 STRUCTURE  LFA1
*"  TABLES
*"      FM_EKPO STRUCTURE  EKPO
*"  EXCEPTIONS
*"      NOTFOUND
*"----------------------------------------------------------------------
SELECT *
   INTO FM_EKKO FROM EKKO WHERE EBELN EQ FM_EBELN.
  ENDSELECT.
  IF SY-SUBRC EQ 0.
    SELECT *
      INTO FM_LFA1 FROM LFA1 WHERE LIFNR EQ FM_EKKO-LIFNR.
      ENDSELECT.
      ENDIF.

      IF SY-SUBRC EQ 0.
        SELECT * FROM EKPO INTO FM_EKPO WHERE EBELN EQ FM_EBELN.
          ENDSELECT.
       ELSE.
         RAISE NOTFOUND.
         ENDIF.






ENDFUNCTION.
