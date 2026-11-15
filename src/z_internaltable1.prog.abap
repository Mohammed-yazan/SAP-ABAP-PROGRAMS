*&---------------------------------------------------------------------*
*& Report Z_INTERNALTABLE1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_INTERNALTABLE1.

DATA: BEGIN OF ITAB,
      ITEMNAME TYPE STRING,
      QUANTITY TYPE I,
      UNITRATE TYPE I,
      AMOUNT TYPE P,
      END OF ITAB.

* STORING THE VALUE
 ITAB-ITEMNAME = 'BIRYANI'.
 ITAB-QUANTITY = 5.
 ITAB-UNITRATE = 200.
 ITAB-AMOUNT   = ITAB-QUANTITY * ITAB-UNITRATE.

*DISPLAY
WRITE:/ 'MENU'.
WRITE:/ 'ITEM NAME', 20 ITAB-ITEMNAME COLOR 4,
      / 'QUANTITY' , 20 ITAB-QUANTITY COLOR 4,
      / 'UNITRATE' , 20 ITAB-UNITRATE COLOR 4,
      /2 'AMOUNT'  , 20 ITAB-AMOUNT   COLOR 6.
