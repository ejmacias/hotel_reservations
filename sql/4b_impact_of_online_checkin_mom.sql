WITH
	online_checkin_revenue_factor(factor) as (
		select
        	1 +
      		(avg(nightcost_sum) filter (where isonlinecheckin = 1) - avg(nightcost_sum) filter (where isonlinecheckin = 0))
        	/
        	avg(nightcost_sum) filter (where isonlinecheckin = 0)
    	from reservations
	)

SELECT
	month,
    actual_revenue,
    round(100 * online_checkin_rate, 1) as "%_online_checkin_rate",
    round(
		online_checkin_revenue
    	+
    	(2 * online_checkin_rate * total_reservations - online_checkins) / physical_checkins * physical_checkin_revenue * (select factor from online_checkin_revenue_factor)
    	+
    	(physical_checkins - (2 * online_checkin_rate * total_reservations - online_checkins)) / physical_checkins * physical_checkin_revenue
	, 2) as est_revenue_2x_online_checkins,
    round(
		online_checkin_revenue
    	+
    	(5 * online_checkin_rate * total_reservations - online_checkins) / physical_checkins * physical_checkin_revenue * (select factor from online_checkin_revenue_factor)
    	+
    	(physical_checkins - (5 * online_checkin_rate * total_reservations - online_checkins)) / physical_checkins * physical_checkin_revenue
	, 2) as est_revenue_5x_online_checkins

from (
  SELECT
      strftime('%Y-%m', startutc) as month,
      round(sum(nightcost_sum), 2) as actual_revenue,
      count(*) filter (where isonlinecheckin = 1) / cast(count(*) as float) as online_checkin_rate,
      coalesce(sum(nightcost_sum) filter (where isonlinecheckin = 1), 0) as online_checkin_revenue,
      coalesce(sum(nightcost_sum) filter (where isonlinecheckin = 0), 0) as physical_checkin_revenue,
      count(*) as total_reservations,
      count(*) filter (where isonlinecheckin = 1) as online_checkins,
      count(*) filter (where isonlinecheckin = 0) AS physical_checkins
  from reservations
  group by month
) sub 
 order by month ASC