use FLPNDP

SET NOCOUNT ON;

    -- Insert statements for procedure here
	with q (sponsor_id, dist_id, distlevel, name,level)
as
(
	select distinct sponsor_id, dist_id, distlevel,name, 0 as level
	from tblappliciant where dist_id='852000000245'
	union all
	select  d.sponsor_id, d.dist_id, d.distlevel, d.name, level +1
	from tblappliciant as d 
	inner join q as m
	on d.sponsor_id = m.dist_id
	where d.distlevel<5
	
)
select SUM(total_cc)  from v_cfund as c
inner join q as d
on c.dist_id = d.dist_id
where c.dist_id <> '852000000245'
