select
	"sub-region" as region,
    round(avg(nightcost_sum / occupiedspace_sum), 2) as revenue_per_capacity,
    count(*) as reservations
from reservations
inner join regions on reservations.nationalitycode = regions."alpha-2"
where occupiedspace_sum >= 1
GROUP by "sub-region"
having reservations >= 10
order by revenue_per_capacity DESC