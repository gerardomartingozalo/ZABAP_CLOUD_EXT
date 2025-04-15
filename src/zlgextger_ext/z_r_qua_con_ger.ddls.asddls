@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS - Root Quality Control'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity z_r_qua_con_ger
  as select from zbase_i_qua_con_ger
  association to parent ZLG_EXTR_ShopTP_GER as _Shop on _Shop.OrderUUID = $projection.OrderUuid

{
  key OrderUuid,
  key ReviewId,
      OrderedItem,
      Rating,
      FreeTextComment,
      HelpfulCount,
      HelpfulTotal,
      @Semantics.user.createdBy: true
      Supervisor,
      SupName,
      @Semantics.systemDateTime.createdAt: true
      LocalCreatedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      LocalLastChangedAt,
      _Shop
}
