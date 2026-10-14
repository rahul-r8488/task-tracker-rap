CLASS zcl_tt_test_task DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS zcl_tt_test_task IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA(today) = cl_abap_context_info=>get_system_date( ).

    " Test 1: valid task (future date)
    MODIFY ENTITIES OF zi_task
      ENTITY Task CREATE FIELDS ( Title Description Priority DueDate )
      WITH VALUE #( ( %cid = 'T1' Title = 'Test task 1' Description = 'First'
                      Priority = 'H' DueDate = today + 7 ) )
      MAPPED DATA(mapped1) FAILED DATA(failed1) REPORTED DATA(reported1).
    COMMIT ENTITIES RESPONSE OF zi_task FAILED DATA(cfailed1) REPORTED DATA(creported1).
    IF cfailed1-task IS INITIAL.
      out->write( 'Test 1 OK: valid task saved' ).
    ELSE.
      out->write( 'Test 1 FAILED: valid task was rejected' ).
    ENDIF.

    " Test 2: past due date must be rejected
    MODIFY ENTITIES OF zi_task
      ENTITY Task CREATE FIELDS ( Title Description Priority DueDate )
      WITH VALUE #( ( %cid = 'T2' Title = 'Old task' Description = 'Past'
                      Priority = 'L' DueDate = today - 1 ) )
      MAPPED DATA(mapped2) FAILED DATA(failed2) REPORTED DATA(reported2).
    COMMIT ENTITIES RESPONSE OF zi_task FAILED DATA(cfailed2) REPORTED DATA(creported2).
    IF cfailed2-task IS NOT INITIAL.
      out->write( 'Test 2 OK: past date rejected' ).
    ELSE.
      out->write( 'Test 2 FAILED: past date was saved' ).
    ENDIF.

    " Test 3: Mark Complete on the valid task
    IF mapped1-task IS NOT INITIAL.
      MODIFY ENTITIES OF zi_task
        ENTITY Task EXECUTE markComplete
        FROM VALUE #( ( %key-TaskId = mapped1-task[ 1 ]-TaskId ) )
        FAILED DATA(failed3) REPORTED DATA(reported3).
      COMMIT ENTITIES.
    ENDIF.

    " Show the table content
    SELECT TaskId, Title, Priority, DueDate, Status FROM zi_task INTO TABLE @DATA(tasks).
    out->write( tasks ).
  ENDMETHOD.
ENDCLASS.
