*&---------------------------------------------------------------------*
*& Report Z_EMP3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_EMP3.
TYPE-POOLS : Z1234.
DATA : ITAB TYPE Z1234_EMPTYPE.

*STORING
ITAB-EMPNO = 122.
ITAB-PFO   = 5.
ITAB-NAME  = 'WALEED'.
ITAB-JOB   = 'SENIOR ABAP CONSULTANT'.

WRITE:/'EMPLOY NO:',20 ITAB-EMPNO color 7,
      /'PFO      :',20 ITAB-PFO color 7,
      /'NAME     :',20 ITAB-NAME color 7,
      /'JOB TITLE:',20 ITAB-JOB color 7.
