select *
from {{ ref('orders_snapshot') }}
order by id
