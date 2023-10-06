SELECT shortratename as rate, "sub-region" as region, count(*) as reservations
FROM reservations
INNER JOIN rates on reservations.rateid = rates.rateid
INNER JOIN regions ON reservations.nationalitycode = regions."alpha-2"
group by shortratename, "sub-region"
order by "sub-region" asc, reservations desc