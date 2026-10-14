@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Task - Interface View'
define root view entity ZI_TASK
  as select from ztt_task
{
  key task_id               as TaskId,
      title                 as Title,
      description           as Description,
      priority              as Priority,
      due_date              as DueDate,
      status                as Status,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by       as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt
}
