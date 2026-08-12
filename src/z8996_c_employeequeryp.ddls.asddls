@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee (Consumption)'
@Metadata.ignorePropagatedAnnotations: true
//@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #D,
    sizeCategory:   #M,
    dataClass:      #MASTER
}
@Metadata.allowExtensions: true
define view entity Z8996_C_EmployeeQueryP
  with parameters
    p_target_curr : /dmo/currency_code,
    
    @Environment.systemField: #SYSTEM_DATE 
    p_date : abap.dats
  as select from Z8996_R_Employee
{
  key EmployeeId,
      FirstName,
      LastName,


      DepartmentId,

      _Department.Description             as DepartmentDescription,
      //      _Department._Assistant.LastName             as AssistantName,

      concat_with_space( _Department._Assistant.FirstName,
                         _Department._Assistant.LastName,
                         1 )              as AssistantName,

      
      case EmployeeId
        when _Department.HeadId      then 'H'
        when _Department.AssistantId then 'A'
        else ' '
      end                                 as EmployeeRole,

      
      @Semantics.amount.currencyCode: 'CurrencyCodeUSD'
      currency_conversion( amount=> AnnualSalary,
                           source_currency => CurrencyCode,
                           target_currency => $projection.CurrencyCodeUSD,
                           exchange_rate_date => $parameters.p_date
                         )                as AnnualSalaryConverted,

      
      @Semantics.amount.currencyCode: 'CurrencyCodeUSD'
      cast( $projection.AnnualSalaryConverted as abap.fltp )
      / 12.0                              as MonthlySalaryConverted,

              CurrencyCode,
//      cast( 'USD' as /dmo/currency_code ) as currencycodeusd,
      $parameters.p_target_curr as CurrencyCodeUSD,

      division( dats_days_between( EntryDate,
                                   $session.system_date ),
                365,
                1 )                       as CompanyAffiliation,
zzcountry_zem,
      /* Associations */
      _Department

}
