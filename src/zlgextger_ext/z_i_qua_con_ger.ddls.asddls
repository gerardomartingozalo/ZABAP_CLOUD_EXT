@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS - Interface Quality Control'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z_I_QUA_CON_GER
  as projection on z_r_qua_con_ger
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
      /* Associations */
      _Shop : redirected to parent ZLG_EXTI_ShopTP_GER
}
