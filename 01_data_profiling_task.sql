-- key candidates
select PhoneId
from SourceData.Contracts
group by PhoneId
having count(*) > 1

select RecordId
from SourceData.Actions
group by RecordId
having count(*) > 1

-- nullability
select count(*)
from SourceData.Contracts
where PhoneId is null

select count(*) 
from SourceData.Actions
where RecordId is null

select count(*)
from SourceData.Actions
where Units is null

-- strangers
select * from SourceData.Actions where Units = 96342016
select count(*) from SourceData.Actions 
where Units > 1 
    and unit = 'pc' 
    and UnitPrice = -1
    and Subtotal != 0

-- use offline SSIS on laptop