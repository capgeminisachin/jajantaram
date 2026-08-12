@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee (Consumption)'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #D,
    sizeCategory:   #M,
    dataClass:      #MASTER
}
define view entity ZC8996_EMPLOYEE_QRY
  as select from /LRN/R_Employee_Rel
{
  key EmployeeId,
      FirstName,
      LastName,
      DepartmentId,

      _Department.Description         as DepartmentDescription,
      _Department._Assistant.LastName as AssistantName,


      @EndUserText.label: 'Employee Role'
      case
      when EmployeeId = _Department.HeadId      then 'H'
      when EmployeeId <> _Department.AssistantId then 'A'
      else ' '
      end                             as EmployeeRole,
      
      
      
      
      @EndUserText.label: 'Monthly Salary'
      @Semantics.amount.currencyCode: 'CurrencyCode'
      cast(
        curr_to_decfloat_amount( AnnualSalary ) / 12 as abap.curr(15,2)
      )                               as MonthlySalary,

      CurrencyCode,

      /* Associations */
      _Department


}
