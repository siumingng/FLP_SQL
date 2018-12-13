use flpndp

select '" "' as 'EDORID', '" "' as 'EDRFID',ord_id as 'EDORD#', ROW_NUMBER() OVER (PARTITION BY ord_id order by prod_id desc) as 'EDLNUM',
'"' + Right('000' + ltrim(prod_id),3) +'"' as 'EDPRNM', qty+bo_qty as 'EDQUTY','"E"' as 'EDUNIT', Convert(varchar ,discounted_subtotal /(qty+ bo_qty)) as 'EDSRPC',
CASE
		when case_credit >=1 then Cast(CONVERT(DECIMAL(10,3),case_credit) as varchar)
		when case_credit < 1 then  SUBSTRING(Cast(CONVERT(DECIMAL(10,3),case_credit) as varchar),2,4)
	end as 'EDPRCC',
'" "' as 'EDTXCH','.00' as 'EDVTAX' from
tbl_orderline_new
where ord_id in 
(select ord_id from  v_ordermain_new where   ord_id>=9808724  and ord_id<=9808726  and order_status='A' and source='POS' 
)
order by ord_id