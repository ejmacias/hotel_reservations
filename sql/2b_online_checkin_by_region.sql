select
	"sub-region" as region,
    round(100 * count(*) filter (where isonlinecheckin = 1) / cast(count(*) as float), 1) as "%_online_checkin_rate",
    count(*) as reservations
from reservations
inner join regions on reservations.nationalitycode = regions."alpha-2"
GROUP by "sub-region"
having reservations >= 10
order by "%_online_checkin_rate" DESC