select
	case isonlinecheckin
    	when 0 then 'in person'
        else 'online'
	end as "check-in",
	round(avg(nightcost_sum), 2) as "Avg room revenue"
from reservations
group by isonlinecheckin