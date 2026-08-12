CLASS zcl8996_s4d430_rlt_path_expr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL8996_S4D430_RLT_PATH_EXPR IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT
    FROM z8996_c_employeequery
    FIELDS employeeid,
           firstname,
           lastname,
           departmentid,
*<unable to type association name/field here>
DepartmentDescription,
\_Department\_Assistant-FirstName as headname

    INTO TABLE @DATA(result).

    out->write( result ).

  ENDMETHOD.
ENDCLASS.
