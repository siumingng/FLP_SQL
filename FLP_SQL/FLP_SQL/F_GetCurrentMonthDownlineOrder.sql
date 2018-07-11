USE [FLPNDP]
GO
/****** Object:  UserDefinedFunction [dbo].[GetDownlineOrder]    Script Date: 11/7/2018 1:26:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create FUNCTION [dbo].[GetCurrentMonthDownlineOrder]
(
	-- Add the parameters for the function here
	@distid varchar(50)

)
RETURNS TABLE 
AS
RETURN
(
    -- Insert statements for procedure here
	with q (sponsor_id, dist_id, distlevel, name,level)
as
(
	select distinct sponsor_id, dist_id, distlevel,name, 0 as level
	from tblappliciant where dist_id=@distid
	union all
	select  d.sponsor_id, d.dist_id, d.distlevel, d.name, level +1
	from tblappliciant as d 
	inner join q as m
	on d.sponsor_id = m.dist_id
	where d.distlevel<5
	
)
select ord_id, c.dist_id, c.name, total_dist, total_cc, order_date  from v_cfund as c
inner join q as d
on c.dist_id = d.dist_id
where c.order_date>='2018-07-01' and c.order_date<'2018-08-01'
)
