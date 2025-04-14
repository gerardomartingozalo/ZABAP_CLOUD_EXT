CLASS lhc_shop DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Shop
        RESULT result,
      calculateorderid FOR DETERMINE ON SAVE
        IMPORTING
          keys FOR  Shop~CalculateOrderID .
ENDCLASS.

CLASS lhc_shop IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD calculateorderid.

    READ ENTITIES OF ZLG_EXTR_ShopTP_GER IN LOCAL MODE
      ENTITY Shop
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(entities).

    DELETE entities WHERE OrderID IS NOT INITIAL.

    CHECK entities IS NOT INITIAL.

    "Dummy logic to determine object_id
    SELECT MAX( order_id ) FROM zlgextashopger INTO @DATA(max_object_id).
    "Add support for draft if used in modify
    "SELECT SINGLE FROM FROM ZLGEXTSHO00D_GER FIELDS MAX( OrderID ) INTO @DATA(max_orderid_draft). "draft table
    "if max_orderid_draft > max_object_id
    " max_object_id = max_orderid_draft.
    "ENDIF.

    MODIFY ENTITIES OF ZLG_EXTR_ShopTP_GER IN LOCAL MODE
      ENTITY Shop
        UPDATE FIELDS ( OrderID )
          WITH VALUE #( FOR entity IN entities INDEX INTO i (
          %tky          = entity-%tky
          OrderID     = max_object_id + i
    ) ).

  ENDMETHOD.
ENDCLASS.
