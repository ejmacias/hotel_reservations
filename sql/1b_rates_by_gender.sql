SELECT shortratename as rate, gender, count(*) as reservations
FROM reservations
INNER JOIN rates on reservations.rateid = rates.rateid
group by shortratename, gender
order by gender asc, reservations desc