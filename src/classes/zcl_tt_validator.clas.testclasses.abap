CLASS ltc_validator DEFINITION FINAL FOR TESTING
  DURATION SHORT RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    METHODS test_future_date FOR TESTING.
    METHODS test_today       FOR TESTING.
    METHODS test_past_date   FOR TESTING.
ENDCLASS.

CLASS ltc_validator IMPLEMENTATION.
  METHOD test_future_date.
    DATA(today) = cl_abap_context_info=>get_system_date( ).
    cl_abap_unit_assert=>assert_true(
      act = zcl_tt_validator=>is_due_date_valid( due_date = today + 1 today = today )
      msg = 'Future date should be valid' ).
  ENDMETHOD.

  METHOD test_today.
    DATA(today) = cl_abap_context_info=>get_system_date( ).
    cl_abap_unit_assert=>assert_true(
      act = zcl_tt_validator=>is_due_date_valid( due_date = today today = today )
      msg = 'Today should be valid' ).
  ENDMETHOD.

  METHOD test_past_date.
    DATA(today) = cl_abap_context_info=>get_system_date( ).
    cl_abap_unit_assert=>assert_false(
      act = zcl_tt_validator=>is_due_date_valid( due_date = today - 1 today = today )
      msg = 'Past date should be invalid' ).
  ENDMETHOD.
ENDCLASS.
