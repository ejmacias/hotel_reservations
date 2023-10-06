SELECT shortratename as rate, age, count(*) as reservations
FROM (
  select
  	rateid,
  	agegroup,
  	case agegroup
  		when 0 then '0-25'
		when 25 then '25-35'
  		when 35 then '35-45'
  		when 45 then '45-55'
  		when 55 then '55-65'
  		when 65 then '65-100'
  		else '100+'
  	end as age
  from reservations ) sub_reservations
INNER JOIN rates on sub_reservations.rateid = rates.rateid
group by shortratename, age
order by agegroup asc, reservations desc