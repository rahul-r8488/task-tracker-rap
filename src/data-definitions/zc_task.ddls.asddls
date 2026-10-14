@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Task - Projection'
@Metadata.allowExtensions: true
define root view entity ZC_TASK
  provider contract transactional_query
  as projection on ZI_TASK
{
  key TaskId,
      @EndUserText.label: 'Title'
      Title,
      @EndUserText.label: 'Description'
      Description,
      @EndUserText.label: 'Priority'
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_PRIORITY_VH', element: 'Priority' } }]
      Priority,
      @EndUserText.label: 'Due Date'
      DueDate,
      @EndUserText.label: 'Status'
      Status,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt
}
