select * from {{'snowplow','events'}}
{{limit_data_in_dev('collector_tstamp')}}