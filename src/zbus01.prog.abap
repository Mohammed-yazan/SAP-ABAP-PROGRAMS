*****           Implementation of object type ZBUS01               *****
INCLUDE <OBJECT>.
BEGIN_DATA OBJECT. " Do not change.. DATA is generated
* only private members may be inserted into structure private
DATA:
" begin of private,
"   to declare private attributes remove comments and
"   insert private attributes here ...
" end of private,
      KEY LIKE SWOTOBJID-OBJKEY.
END_DATA OBJECT. " Do not change.. DATA is generated

BEGIN_METHOD CUSTOMERDATA CHANGING CONTAINER.
DATA:
      BAPICUSTOMER TYPE KNA1-KUNNR,
      RETURN LIKE BAPIRET2,
      BAPICUST LIKE ZBAPI_STRUCT OCCURS 0.
  SWC_GET_ELEMENT CONTAINER 'BapiCustomer' BAPICUSTOMER.
  SWC_GET_TABLE CONTAINER 'BapiCust' BAPICUST.
  CALL FUNCTION 'ZBAPI_FUNC1'
    EXPORTING
      BAPI_CUSTOMER = BAPICUSTOMER
    IMPORTING
      RETURN = RETURN
    TABLES
      BAPI_CUST = BAPICUST
    EXCEPTIONS
      NOTFOUND = 9001
      OTHERS = 01.
  CASE SY-SUBRC.
    WHEN 0.            " OK
    WHEN 9001.         " NOTFOUND
      EXIT_RETURN 9001 sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    WHEN OTHERS.       " to be implemented
  ENDCASE.
  SWC_SET_ELEMENT CONTAINER 'Return' RETURN.
  SWC_SET_TABLE CONTAINER 'BapiCust' BAPICUST.
END_METHOD.
