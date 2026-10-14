CLASS lhc_Task DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR Task RESULT result.

    METHODS setInitialStatus FOR DETERMINE ON MODIFY
      keys FOR Task~setInitialStatus.

    METHODS validateDueDate FOR VALIDATE ON SAVE
      keys FOR Task~validateDueDate.

    METHODS markComplete FOR MODIFY
      keys FOR ACTION Task~markComplete RESULT result.

ENDCLASS.

CLASS lhc_Task IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD setInitialStatus.
    READ ENTITIES OF zi_task IN LOCAL MODE
      ENTITY Task FIELDS ( Status ) WITH CORRESPONDING #( keys )
      RESULT DATA(tasks).

    DELETE tasks WHERE Status IS NOT INITIAL.
    CHECK tasks IS NOT INITIAL.

    MODIFY ENTITIES OF zi_task IN LOCAL MODE
      ENTITY Task UPDATE FIELDS ( Status )
      WITH VALUE #( FOR t IN tasks ( %tky = t-%tky Status = 'O' ) ).
  ENDMETHOD.

  METHOD validateDueDate.
    READ ENTITIES OF zi_task IN LOCAL MODE
      ENTITY Task FIELDS ( DueDate ) WITH CORRESPONDING #( keys )
      RESULT DATA(tasks).

    DATA(today) = cl_abap_context_info=>get_system_date( ).

    LOOP AT tasks INTO DATA(task) WHERE DueDate IS NOT INITIAL.
      IF zcl_tt_validator=>is_due_date_valid( due_date = task-DueDate today = today ) = abap_false.
        APPEND VALUE #( %tky = task-%tky ) TO failed-task.
        APPEND VALUE #( %tky = task-%tky
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'Due date cannot be in the past' )
                        %element-DueDate = if_abap_behv=>mk-on ) TO reported-task.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD markComplete.
    MODIFY ENTITIES OF zi_task IN LOCAL MODE
      ENTITY Task UPDATE FIELDS ( Status )
      WITH VALUE #( FOR key IN keys ( %tky = key-%tky Status = 'C' ) ).

    READ ENTITIES OF zi_task IN LOCAL MODE
      ENTITY Task ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(tasks).

    result = VALUE #( FOR t IN tasks ( %tky = t-%tky %param = t ) ).
  ENDMETHOD.

ENDCLASS.
