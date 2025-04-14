@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Root Entity CDS View forShop'
@ObjectModel.sapObjectNodeType.name: 'ZLG_EXTShop_GER'
@AbapCatalog.extensibility: {
  extensible: true, 
  elementSuffix: 'ZAA', 
  allowNewDatasources: false, 
  allowNewCompositions: true, 
  dataSources: [ '_Extension' ], 
  quota: {
    maximumFields: 100 , 
    maximumBytes: 10000 
  }
}
define root view entity ZLG_EXTR_ShopTP_GER
  as select from ZLG_EXTI_Shop_GER as Shop
  association [1] to ZLG_EXTE_Shop_GER as _Extension on $projection.OrderUUID = _Extension.OrderUUID
{
  key OrderUUID,
  OrderID,
  OrderedItem,
  CurrencyCode,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  OrderItemPrice,
  DeliveryDate,
  OverallStatus,
  Notes,
  @Semantics.systemDateTime.lastChangedAt: true
  LastChangedAt,
  @Semantics.user.createdBy: true
  CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  CreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  LocalLastChangedBy,
  @Semantics.user.lastChangedBy: true
  LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LocalLastChangedAt,
  _Extension
  
}
