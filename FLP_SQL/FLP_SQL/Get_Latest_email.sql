use marketingemail

truncate table tbl_addr_mailinglists

go

insert into tbl_addr_mailinglists
select distinct ltrim(rtrim(email)) from flpwh.dbo.tblAppliciant where (country='HKG' or country ='MAC') and (((left(ltrim(email),1) <>'*') and (left(ltrim(email),1) <>'-') ) and len(ltrim(email))>0)