@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'C view emp query'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z8996_C_EmployeeQuery
  as select from /LRN/R_Employee_Rel
{
  key EmployeeId,
      FirstName,
      LastName,
      DepartmentId,
      _Department.Description                                       as DepartmentDescription,
      //_Department._Assistant.LastName as AssistantName,
      concat_with_space( _Department._Assistant.FirstName,
      _Department._Assistant.LastName, 1 )                          as AssistantName,
      //

      @EndUserText.label: 'Company Affiliation in Years'
      fltp_to_dec(
        cast( dats_days_between( EntryDate, $session.user_date ) as abap.fltp ) / 365.25
        as abap.dec( 4, 1 )
      )                                                             as CompanyAffiliation,




      cast( 'USD' as /dmo/currency_code )                           as CurrencyCodeUSD,

      @EndUserText.label: 'Annual Salary'
      @Semantics.amount.currencyCode: 'CurrencyCodeUSD'
      currency_conversion( amount => AnnualSalary,
      source_currency => CurrencyCode ,
      target_currency => $projection.CurrencyCodeUSD,
      exchange_rate_date => $session.system_date )                  as AnnualSalaryConverted,

      @EndUserText.label: 'Monthly Salary'
      @Semantics.amount.currencyCode: 'CurrencyCodeUSD'
      cast( $projection.AnnualSalaryConverted as abap.fltp ) / 12.0 as MonthlySalaryConverted,
      _Department
      //_Department._Assistant,
      //_Department.AssistantId
}
