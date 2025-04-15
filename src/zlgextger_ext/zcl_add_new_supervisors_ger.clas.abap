CLASS zcl_add_new_supervisors_ger DEFINITION
PUBLIC
FINAL
CREATE PUBLIC .


  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_add_new_supervisors_ger  IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DELETE FROM zquality_sup_ger.

    INSERT zquality_sup_ger FROM @( VALUE #( supervisor = cl_abap_context_info=>get_user_technical_name( )
                                             sup_name = 'Logali Group' ) ).

    IF sy-subrc EQ 0.
      out->write( |New Supervisors has been added { sy-dbcnt }| ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
