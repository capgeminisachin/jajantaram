*"* use this source file for your ABAP unit test classes
CLASS ltcl_find_flights DEFINITION FINAL FOR TESTING
  DURATION MEDIUM
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      test_find_cargo_flight FOR TESTING RAISING cx_static_check.
    CLASS-METHODS  class_setup.
    CLASS-data the_carrier TYPE REF TO lcl_carrier.
    CLASS-DATA some_flight_data type /LRN/CARGOFLIGHT.
ENDCLASS.


CLASS ltcl_find_flights IMPLEMENTATION.





  METHOD test_find_cargo_flight.
*    cl_abap_unit_assert=>fail( 'Implement your first test here' ).

*    SELECT SINGLE
*    FROM /lrn/cargoflight
*    FIELDS carrier_id, connection_id, flight_date,
*    airport_from_id, airport_to_id
*    WHERE maximum_load - actual_load >= 1
*    INTO @DATA(some_flight_data).
*
*    IF sy-subrc NE 0.
*      cl_abap_unit_assert=>fail( 'no data set found in /LRN/CARGOFLIGHT' ).
*    ENDIF.
*
*    IF sy-subrc EQ 0.
*
*      TRY.
*          DATA(the_carrier) = NEW lcl_carrier( i_carrier_id = some_flight_data-carrier_id ).
*        CATCH cx_abap_invalid_value.
*          cl_abap_unit_assert=>fail( 'exception got raised shit' ).
*      ENDTRY.
*    ENDIF.

*if the_carrier is bound.


    the_carrier->find_cargo_flight(
    EXPORTING
    i_airport_from_id =
    some_flight_data-airport_from_id
    i_airport_to_id = some_flight_data-airport_to_id
    i_from_date = some_flight_data-flight_date
    i_cargo = 1

    IMPORTING
    e_flight = DATA(cargo_flight) "@DATA when inline in SQL, else without @
    e_days_later = DATA(days_later)


     ).


*cl_abap_unit_assert=>assert_bound( act = cargo_flight ).

*ENDIF.
*
    cl_abap_unit_assert=>assert_bound(
      act = cargo_flight
      msg = 'Flight object reference is not valid or initial.'
    ).

    cl_abap_unit_assert=>assert_equals(
      act = days_later
      exp = 0
      msg = 'The days_later parameter did not return zero.'
    ).


  ENDMETHOD.

  METHOD class_setup.

 SELECT SINGLE
    FROM /lrn/cargoflight
    FIELDS carrier_id, connection_id, flight_date,
    airport_from_id, airport_to_id
    WHERE maximum_load - actual_load >= 1
    INTO CORRESPONDING FIELDS OF @some_flight_data.

    IF sy-subrc NE 0.
      cl_abap_unit_assert=>fail( 'no data set found in /LRN/CARGOFLIGHT' ).
    ENDIF.

    IF sy-subrc EQ 0.

      TRY.
          the_carrier = NEW lcl_carrier( i_carrier_id = some_flight_data-carrier_id ).
        CATCH cx_abap_invalid_value.
          cl_abap_unit_assert=>fail( 'exception got raised shit' ).
      ENDTRY.
    ENDIF.


  ENDMETHOD.

ENDCLASS.



