*&---------------------------------------------------------------------*
*& Report Z_MYFOURTH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_MYFOURTH.

PARAMETERS: V1 TYPE I OBLIGATORY,
            V2 TYPE I OBLIGATORY,
            V3 TYPE I OBLIGATORY.
DATA AMOUNT TYPE I.

AMOUNT = V2 * V3.

WRITE: /5 'TOTAL AMOUNT IS :', AMOUNT COLOR 4.
