select
	case
    	when occupiedspace_sum is NULL or occupiedspace_sum < 1 then 'missing beds info'
        else 'valid beds info'
	end as valid_occupiedspace,
    count(*) as reservations
from reservations
GROUP by valid_occupiedspace