*&---------------------------------------------------------------------*
*& Report Z_SUBROUTINES
*&---------------------------------------------------------------------*
REPORT Z_SUBROUTINES.

DATA: v1 TYPE i VALUE 10,
      v2 TYPE i VALUE 20.

PERFORM add_numbers USING v1 v2.

WRITE: / 'before Subroutine v1 = ', v1,
       / 'After Subroutine v2 = ', v2.

*---------------------------------------------------------------------*
* Subroutine
*---------------------------------------------------------------------*
FORM add_numbers USING p1 p2.
  p2 = p1 + p2.
ENDFORM.
