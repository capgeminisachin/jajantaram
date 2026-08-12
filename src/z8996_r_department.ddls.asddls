@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'descr'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z8996_R_Department as select from /lrn/depment_rel
{
    key id as Id,
    description as Description,
    head_id as HeadId,
    assistant_id as AssistantId,
    created_by as CreatedBy,
    created_at as CreatedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    last_changed_at as LastChangedAt
}
