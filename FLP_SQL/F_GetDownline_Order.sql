-- ================================================
-- Template generated from Template Explorer using:
-- Create Multi-Statement Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION dbo.GetDownlineOrder
(
	-- Add the parameters for the function here
	@dist_id varchar(50)

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
order by c.dist_id
)
