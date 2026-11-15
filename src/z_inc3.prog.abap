*&---------------------------------------------------------------------*
*& Report Z_INC3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_INC3.

PARAMETERS : SERVID TYPE I,
             PHASE_NO  TYPE I,
             PRE_READ TYPE I,
             CUR_READ TYPE I.
DATA: UNITS_USED TYPE I,
      UNIT_RATE TYPE P,
      BILL_AMOUNT TYPE P.

 PERFORM SUBR USING PHASE_NO CUR_READ PRE_READ CHANGING UNITS_USED UNIT_RATE BILL_AMOUNT.
     WRITE:/ 'Service ID       :', serVid,
       / 'Phase Number     :', phase_nO,
       / 'Previous Reading :', PRE_READ,
       / 'Current Reading  :', CUR_READ,
       / 'Units Used       :', units_used,
       / 'Rate per Unit    :', unit_rate,
       / 'Bill Amount      :', bill_AMOUNT.
     INCLUDE Z_INCLUDE2.
