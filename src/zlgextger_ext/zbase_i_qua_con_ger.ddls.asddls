@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'entidad Base Quality Control'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zbase_i_qua_con_ger
  as select from zquality_con_ger

{
  key order_uuid            as OrderUuid,
  key review_id             as ReviewId,
      ordered_item          as OrderedItem,
      rating                as Rating,
      free_text_comment     as FreeTextComment,
      helpful_count         as HelpfulCount,
      helpful_total         as HelpfulTotal,
      @Semantics.user.createdBy: true
      supervisor            as Supervisor,
      sup_name              as SupName,
      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      local_last_changed_at as LocalLastChangedAt
}
