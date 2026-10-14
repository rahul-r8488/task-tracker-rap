@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Priority Value Help'
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZI_PRIORITY_VH
  as select from ztt_priority
{
      @ObjectModel.text.element: [ 'Description' ]
  key priority    as Priority,
      description as Description
}
