@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee (Query)'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z8996_C_DepartmentQuery
  with parameters
    // <-- 1. DEFINE PARAMETERS FOR YOUR NEW VIEW HERE
    p_target_curr : /dmo/currency_code,
    p_date        : abap.dats
  as select from     Z8996_C_EmployeeQueryP(  p_target_curr: $parameters.p_target_curr, // <-- 2. FORWARD THEM DOWN USING THE $parameters SYSTEM VARIABLE
                     p_date:        $parameters.p_date  ) as c
    right outer join Z8996_R_Department                   as d on c.DepartmentId = d.Id
{
  c.DepartmentId,
    d.Description as DepartmentDescription,
    avg(c.CompanyAffiliation as abap.dec(11,1)) as AverageAffiliation,
    @Semantics.amount.currencyCode: 'CurrencyCodeUSD'
    sum( c.AnnualSalaryConverted ) as TotalSalary,
    c.CurrencyCodeUSD
}
group by
    c.DepartmentId,
    d.Description,
    c.CurrencyCodeUSD
