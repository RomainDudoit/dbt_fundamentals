{%test greater_than_five (model,column_name)%}

    select {{column_name}}
    from {{model}}
    where amount <=5

{% endtest %}