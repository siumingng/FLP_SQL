use flpndp

select dist_id, 
((select isnull(sum(total_cc),0) from dbo.GetCurrentMonthDOrder_nonPromote(dist_id) )+ (select isnull(sum(d_cc),0) from dbo.GetCurrentMonthDOrder_Promote(dist_id))) as 'Distributor CC',
(select isnull(sum(total_cc),0) from dbo.GetCurrentMonthPOrder(dist_id)) as 'Personal CC',
((select isnull(sum(total_cc),0) from dbo.GetCurrentMonthDOrder_nonPromote(dist_id) )+ (select isnull(sum(d_cc),0) from dbo.GetCurrentMonthDOrder_Promote(dist_id)) + (select isnull(sum(total_cc),0) from dbo.GetCurrentMonthPOrder(dist_id))) as 'Active CC'
from tblAppliciant where DistLevel=5 and (country ='HKG' or country='MAC') 
order by 1