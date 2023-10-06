select gender, count(*) as reservations
from reservations
group by gender