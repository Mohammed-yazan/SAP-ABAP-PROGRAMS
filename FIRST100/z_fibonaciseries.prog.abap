*
REPORT Z_FIBONACISERIES.

DATA: A TYPE I VALUE 0,
      B TYPE I VALUE 1,
      C TYPE I.

WRITE: / 'Fibonacci series till the value 150:'.
WRITE: / A.
WRITE: / B.

C = A + B.

WHILE C <= 150.
  WRITE: / C.
  A = B.
  B = C.
  C = A + B.
ENDWHILE.
