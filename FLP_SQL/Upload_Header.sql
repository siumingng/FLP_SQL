use flpndp

select  '" "' as 'EHORID', '" "' as 'EHRFID','" "' as 'EHREQ#','"HKG"' as 'EHSRCO',CONVERT(VARCHAR(10),order_date , 112) as 'EHORDT',
ord_id as 'EHORD#','""' as 'EHDCTY','"' + dist_id +'"' as 'EHDSID','"' + name + '"' as 'EHNAME', '"W"' as 'EHORTP', '" "' as 'EHPMTP','"P"' as 'EHDLTP','" "' as 'EHWBST',
 CASE   
      WHEN loc_id='HK' THEN '"1"'   
      WHEN loc_id='YL' THEN '"2"'   
   END as 'EHAREA' ,
   '" "' as 'EHSHMT','" "' as 'EHSHNM','" "' as 'EHADDR','" "' as 'EHSHCT','" "' as 'EHSHST','" "' as 'EHSHCN','" "' as 'EHSHZP',0 as 'EHWGHT',
   CASE
		when total_cc >=1 then Cast(CONVERT(DECIMAL(10,3),total_cc) as varchar)
		when total_cc < 1 then  SUBSTRING(Cast(CONVERT(DECIMAL(10,3),total_cc) as varchar),2,4)
	end as 'EHCACR' ,
   CASE   
      WHEN discount_level=0 THEN '"NEWDST"'
	  WHEN discount_level=0.05 THEN '"WHLD05"'
	   WHEN discount_level=0.08 THEN '"WHLD08"'
	    WHEN discount_level=0.13 THEN '"WHLD13"'
		 WHEN discount_level=0.18 THEN '"WHLD18"'          
   END as 'EHPRTY' ,
   '.00' as 'EHTVAT','.00' as 'EHSHCG','.00' as 'EHSHVT','.00' as 'EHSBTT',total_dist-total_discount as 'EHTTOD',distlevel as 'EHDLVL',total_discount as 'EHDAMT','.00' as 'EHDBAL'
from v_ordermain_new where ord_id>=9808724  and ord_id<=9808726
and order_status='A' and source='POS' 
order by ord_id