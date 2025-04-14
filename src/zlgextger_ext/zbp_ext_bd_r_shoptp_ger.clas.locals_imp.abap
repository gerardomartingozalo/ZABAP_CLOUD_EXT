*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lhc_shop DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS zzChangeStatus FOR MODIFY
      IMPORTING keys FOR ACTION Shop~zzChangeStatus RESULT result.
    METHODS zzValidateItemDisc FOR VALIDATE ON SAVE
      IMPORTING keys FOR Shop~zzValidateItemDisc.
    METHODS zzSetDefaultStatus FOR DETERMINE ON SAVE
      IMPORTING keys FOR Shop~zzSetDefaultStatus.

    CONSTANTS validate_disc TYPE string VALUE 'VALIDATE_DISC'.


ENDCLASS.

CLASS lhc_shop IMPLEMENTATION.

  "Accion
  "Cuando pinchas en el boton SoldItem cambia el estatus a Sale SL solo si esta Onsale OS
  "Ademas asigna la fecha del sistema en el campo modificacion y coge el descuento del campo y actualiza el precio
  METHOD zzChangeStatus.


** READ root entity entries
    READ ENTITIES OF ZLG_EXTI_ShopTP_GER IN LOCAL MODE
    ENTITY Shop
    FIELDS ( zzstatuszaa zzmoddatezaa zzitemdiscountzaa OrderItemPrice )
    WITH CORRESPONDING #( keys )
    RESULT DATA(shops).

** SET Sold Status
    LOOP AT shops ASSIGNING FIELD-SYMBOL(<shop>).
      IF <shop>-zzstatuszaa EQ 'OS'. "On sale
        <shop>-zzstatuszaa = 'SL'. "Sale
        <shop>-zzmoddatezaa = cl_abap_context_info=>get_system_date( ).
        <shop>-OrderItemPrice = <shop>-OrderItemPrice * ( 1 - ( <shop>-zzitemdiscountzaa / 100 ) ).
      ENDIF.
    ENDLOOP.

** MODIFY status in Root Entity
    MODIFY ENTITIES OF ZLG_EXTI_ShopTP_GER IN LOCAL MODE
    ENTITY Shop
    UPDATE FIELDS ( zzstatuszaa zzmoddatezaa OrderItemPrice )
    WITH CORRESPONDING #( shops ).


    result = VALUE #( FOR shop IN shops ( %tky = shop-%tky
                                          %param = shop ) ).



  ENDMETHOD.

  "Validacion
  "Valida que el descuento este entre 0 y 50
  METHOD zzValidateItemDisc.

    READ ENTITIES OF ZLG_EXTI_ShopTP_GER IN LOCAL MODE
    ENTITY Shop
    FIELDS ( zzitemdiscountzaa )
    WITH CORRESPONDING #( keys )
    RESULT DATA(shops).

    LOOP AT shops INTO DATA(shop).
    "este APPEND funciona como limpiador de mensajes de error existentes
      APPEND VALUE #( %tky = shop-%tky
                      %state_area = validate_disc ) TO reported-Shop.

      IF NOT ( shop-zzitemdiscountzaa GT 0 AND shop-zzitemdiscountzaa LT 50 ).

        APPEND VALUE #( %tky = shop-%tky ) TO failed-Shop.

        APPEND VALUE #( %tky = shop-%tky
                        %state_area = validate_disc
                        %msg = NEW zcm_message_item_GER( textid = zcm_message_item_GER=>invalid_disc
                                                         severity = if_abap_behv_message=>severity-error )
                        %element-zzitemdiscountzaa = if_abap_behv=>mk-on ) TO reported-Shop.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  "Determinacion
  "Cuando se crea un registro nace con el estado por defecto OS On sale
  METHOD zzSetDefaultStatus.

    DATA shops_update TYPE TABLE FOR UPDATE ZLG_EXTI_ShopTP_GER.

    READ ENTITIES OF ZLG_EXTI_ShopTP_GER IN LOCAL MODE
    ENTITY Shop
    FIELDS ( zzstatuszaa )
    WITH CORRESPONDING #( keys )
    RESULT DATA(shops).

    LOOP AT shops INTO DATA(shop).

      IF shop-zzmoddatezaa IS INITIAL.
        APPEND INITIAL LINE TO shops_update ASSIGNING FIELD-SYMBOL(<shop_update>).
        <shop_update>-%tky = shop-%tky.
        <shop_update>-zzstatuszaa = 'OS'.
      ENDIF.

    ENDLOOP.

    MODIFY ENTITIES OF ZLG_EXTI_ShopTP_GER IN LOCAL MODE
    ENTITY Shop
    UPDATE FIELDS ( zzstatuszaa )
    WITH shops_update.


  ENDMETHOD.

ENDCLASS.
