//@AbapCatalog.dataMaintenance: #RESTRICTED
//@AbapCatalog.viewEnhancementCategory: [#NONE]
@AbapCatalog: {
    dataMaintenance: #RESTRICTED,
    viewEnhancementCategory: [#PROJECTION_LIST]
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee (Entity)'
@Metadata.ignorePropagatedAnnotations: true
@AbapCatalog.extensibility: {
  extensible: true,
  allowNewDatasources: false,               // Must be false in base view entities
  dataSources: ['employee']  ,                // Purely white-lists your source alias/table
elementSuffix: 'ZEM'   
}
@ObjectModel.usageType:{
    serviceQuality: #D,
    sizeCategory:   #M,
    dataClass:      #MASTER
}
define view entity Z8996_R_Employee
  as select from z8996_employ as employee
  association [1..1] to /LRN/R_Department_Aut as _Department
    on $projection.DepartmentId = _Department.Id
  {
    key employee_id           as EmployeeId,
        first_name            as FirstName,
        last_name             as LastName,
        birth_date            as BirthDate,
        entry_date            as EntryDate,
        _Department.Id         as DepartmentId,
        @Semantics.amount.currencyCode: 'CurrencyCode'
        annual_salary         as AnnualSalary,
        @EndUserText.label: 'Currency Key'
        currency_code         as CurrencyCode,
//        CreatedBy            as CreatedBy,
//        created_at            as CreatedAt,
//        local_last_changed_by as LocalLastChangedBy,
//        local_last_changed_at as LocalLastChangedAt,
//        last_changed_at       as LastChangedAt,
zzcountry_zem,
        _Department
  }
