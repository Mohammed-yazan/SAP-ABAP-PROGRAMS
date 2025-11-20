*&---------------------------------------------------------------------*
*&  Include           Z_INCLUDE2
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Include Z_METER_BILLING_INC
*&---------------------------------------------------------------------*

FORM SUBR USING P_PHASE_NO P_CUR_READ P_PRE_READ  CHANGING P_UNITS_USED P_UNIT_RATE P_BILL_AMOUNT.
  P_UNITS_USED = P_CUR_READ - P_PRE_READ.

IF P_PHASE_NO = 1.
  P_UNIT_RATE = 5.
 ELSEIF P_PHASE_NO = 3.
  P_UNIT_RATE = 8.
 ELSE.
   WRITE:/5 'INVALID PHASE NO'.
   ENDIF.

   P_BILL_AMOUNT = P_UNITS_USED * P_UNIT_RATE.


ENDFORM.
