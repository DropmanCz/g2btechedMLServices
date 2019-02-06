create or alter view [SourceData].[viAggregatedActions]
as
select 
	PhoneNumberHash
	, EOMONTH(DateAndTime) as InvoicingPeriod
	, Unit
	, IsCorporate
	, CitySize
	, sum(units) as InvoicedAmount
from SourceData.Actions as a
	join SourceData.Contracts as c on a.PhoneId = c.PhoneId
where unit is not null
group by 
	PhoneNumberHash
	, EOMONTH(DateAndTime)
	, Unit
	, IsCorporate
	, CitySize
--order by 1, 2
GO

