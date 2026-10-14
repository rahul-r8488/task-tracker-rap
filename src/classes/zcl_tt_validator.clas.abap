CLASS zcl_tt_validator DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    CLASS-METHODS is_due_date_valid
      IMPORTING due_date      TYPE d
                today         TYPE d
      RETURNING VALUE(result) TYPE abap_boolean.
ENDCLASS.

CLASS zcl_tt_validator IMPLEMENTATION.
  METHOD is_due_date_valid.
    result = xsdbool( due_date >= today ).
  ENDMETHOD.
ENDCLASS.
