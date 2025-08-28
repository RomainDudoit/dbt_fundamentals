with payments as 
(
    select * from {{ ref('stg_stripe_payments') }}
)

{# #select * from payments #}
select sum(amount) from payments
where status ='success'
