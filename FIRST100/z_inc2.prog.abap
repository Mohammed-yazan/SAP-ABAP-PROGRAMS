*&---------------------------------------------------------------------*
*& Report Z_INC2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_INC2.
*&---------------------------------------------------------------------*
*& Report Z_METER_BILLING_MAIN
*&---------------------------------------------------------------------*

*--- User Inputs
PARAMETERS: service_id     TYPE char10,   " Service ID
            phase_number   TYPE i,        " Phase (1 or 3)
            current_read   TYPE i,        " Current Meter Reading
            previous_read  TYPE i.        " Previous Meter Reading

*--- Output variables
DATA: bill_total       TYPE p DECIMALS 2, " Bill Amount
      new_previous     TYPE i.            " Updated Previous Reading

*--- Call Subroutine
PERFORM calc_bill USING phase_number current_read previous_read
                  CHANGING bill_total new_previous.

*--- Show Result
WRITE: / 'Service ID       :', service_id,
       / 'Phase Number     :', phase_number,
       / 'Previous Reading :', new_previous,
       / 'Current Reading  :', current_read,
       / 'Bill Amount      :', bill_total.

*--- Include the Subroutine
INCLUDE z_meter_billing_inc.
