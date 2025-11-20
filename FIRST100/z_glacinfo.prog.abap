*&---------------------------------------------------------------------*
*& Report Z_GLACINFO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_GLACINFO.


"--- Input parameters
PARAMETERS: bukrs TYPE bsas-bukrs,
            gjahr TYPE bsas-gjahr,
            budat TYPE bsas-budat,
            saknr TYPE ska1-saknr.

"--- Output structure
TYPES: BEGIN OF ty_output,
         augdt TYPE bsas-augdt,
         dmbtr TYPE bsas-dmbtr,
         hkont TYPE bsas-hkont,
         ktopl TYPE ska1-ktopl,
         txt20 TYPE skat-txt20,
       END OF ty_output.

DATA: itab TYPE TABLE OF ty_output,
      wa   TYPE ty_output.

START-OF-SELECTION.

  "--- Fetch data (new Open SQL syntax with @ for host vars)
  SELECT a~augdt,
         a~dmbtr,
         a~hkont,
         b~ktopl,
         c~txt20
    INTO TABLE @itab
    FROM bsas AS a
    INNER JOIN ska1 AS b ON a~hkont = b~saknr
    INNER JOIN skat AS c ON b~saknr = c~saknr
    WHERE a~bukrs = @bukrs
      AND a~gjahr = @gjahr
      AND a~budat = @budat
      AND a~hkont = @saknr.

  IF sy-subrc <> 0.
    WRITE: / 'No data found for given inputs.'.
    EXIT.
  ENDIF.

  "--- Print header row
  WRITE: / sy-uline(80).
  WRITE: / 'AUGDT', 20 'DMBTR', 40 'HKONT', 55 'KTOPL', 65 'TXT20'.
  WRITE: / sy-uline(80).

  "--- Print data rows
  LOOP AT itab INTO wa.
    WRITE: / wa-augdt UNDER 'AUGDT',
             wa-dmbtr UNDER 'DMBTR',
             wa-hkont UNDER 'HKONT',
             wa-ktopl UNDER 'KTOPL',
             wa-txt20 UNDER 'TXT20'.
  ENDLOOP.

  WRITE: / sy-uline(80).
