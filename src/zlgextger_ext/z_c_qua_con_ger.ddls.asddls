@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS - Consumption Quality Control'
//@Metadata.ignorePropagatedAnnotations: true

@Metadata.allowExtensions: true 

@ObjectModel.semanticKey: ['ReviewId']

define view entity Z_C_QUA_CON_GER as 
projection on z_r_qua_con_ger

{
    key OrderUuid,
    key ReviewId,
    OrderedItem,
    Rating,
    FreeTextComment,
    HelpfulCount,
    HelpfulTotal,
    Supervisor,
    SupName,
    LocalCreatedAt,
    LocalLastChangedAt,
    /* Associations */
    _Shop :redirected to parent ZLG_EXTC_ShopTP_GER
}
