extend view entity ZLG_EXTC_ShopTP_GER with
{
  @UI.facet: [{ id : 'Review',
                purpose: #STANDARD,
                type: #LINEITEM_REFERENCE,
                label: 'Reviews',
                position: 20,
                targetElement: 'ZZ_quality_ZAA' }]
  Shop.ZZ_quality_ZAA : redirected to composition child Z_C_QUA_CON_GER
}
