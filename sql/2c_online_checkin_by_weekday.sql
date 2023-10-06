select
	strftime('%w', startutc) AS day_number,
    case cast(strftime('%w', startutc) as integer)
    	when 0 then 'Sun'
        when 1 then 'Mon'
        when 2 then 'Tue'
        when 3 then 'Wed'
        when 4 then 'Thu'
        when 5 then 'Fri'
        else 'Sat'
	end as weekday,
    round(100 * count(*) filter (where isonlinecheckin = 1) / cast(count(*) as float), 1) as "%_online_checkin_rate",
    count(*) as total_checkins
from reservations
group by cast(strftime('%w', startutc) as integer)
order by day_number asc