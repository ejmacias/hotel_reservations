select
  	case agegroup
  		when 0 then '0-25'
		when 25 then '25-35'
  		when 35 then '35-45'
  		when 45 then '45-55'
  		when 55 then '55-65'
  		when 65 then '65-100'
  		else '100+'
  	end as age,
    round(100 * count(*) filter (where isonlinecheckin = 1) / cast(count(*) as float), 1) as "%_online_checkin_rate"
from reservations
GROUP by age
order by agegroup asc