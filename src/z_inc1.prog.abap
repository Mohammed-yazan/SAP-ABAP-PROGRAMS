*&---------------------------------------------------------------------*
*& Report Z_INC1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_INC1.
DATA: JOBCODE TYPE CHAR4, BASIC TYPE I.
PARAMETERS: PMGR RADIOBUTTON GROUP JOB,
            AMGR RADIOBUTTON GROUP JOB,
            FCON RADIOBUTTON GROUP JOB,
            ACON RADIOBUTTON GROUP JOB.
INCLUDE: Z_INCLUDE1.
START-OF-SELECTION.
 IF PMGR EQ 'X'.
    JOBCODE ='PMGR'.
  ELSEIF AMGR EQ 'X'.
    JOBCODE ='AMGR'.
  ELSEIF FCON EQ 'X'.
    JOBCODE ='FCON'.
  ELSEIF ACON EQ 'X'.
    JOBCODE ='ACON'.
    ENDIF.
    PERFORM SUBR USING JOBCODE CHANGING BASIC.
    IF PMGR EQ 'X'.
      WRITE:/ 'PMGR PROJECT MANAGER'.
    ELSEIF AMGR EQ 'X'.
      WRITE:/ 'AMGR ASSOCIATE MANAGER'.
    ELSEIF FCON EQ 'X'.
      WRITE:/'FUNCTIONAL CONSULTANT'.
    ELSEIF ACON EQ 'X'.
      WRITE: 'ABAP CONSULTANT'.
      ENDIF.
    WRITE:/ 'BASIC SALARY:', BASIC COLOR 4.
