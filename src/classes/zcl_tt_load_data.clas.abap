CLASS zcl_tt_load_data DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS zcl_tt_load_data IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DELETE FROM ztt_priority.
    INSERT ztt_priority FROM TABLE @( VALUE #(
      ( priority = 'H' description = 'High' )
      ( priority = 'M' description = 'Medium' )
      ( priority = 'L' description = 'Low' ) ) ).
    out->write( |Priorities loaded: { sy-dbcnt }| ).
  ENDMETHOD.
ENDCLASS.
