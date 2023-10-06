select
	case
    	when nationalitycode is NULL then 'missing nationality'
        else 'valid nationality'
	end as is_valid_nationality,
    count(*)
from reservations
GROUP by is_valid_nationality