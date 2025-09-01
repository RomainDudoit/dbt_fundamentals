import holidays
import pandas

def is_holiday(date_col):
    # Chez Jaffle
    french_holidays = holidays.France()
    is_holiday = (date_col in french_holidays)
    return is_holiday

# python models don't use jinja. here we are using dbt.config to create 
# model configurations. be sure to materialize python models as tables. 
def model(dbt, session):
    dbt.config(
        materialized = "table",
        packages = ["pandas","holidays"]
    )

    #orders_df = dbt.ref("stg_orders")
    #df = orders_df.to_pandas()

    us_holidays= holidays.US()
    df = dbt.ref("date_spine").to_pandas()
    df["IS_HOLIDAY"] = df["DATE_DAY"].apply(lambda date: date in us_holidays)

    return df

    #select * from {{ref('is_holiday_2024')}} where is_holiday : to test on another model
    #____________________________________________________________________

    # apply our function
    # (columns need to be in uppercase on Snowpark)
    #df["IS_HOLIDAY"] = df["ORDER_DATE"].apply(is_holiday)
    #df["ORDER_DATE"].dt.tz_localize('UTC') # convert from Number/Long to tz-aware Datetime

    # return final dataset (Pandas DataFrame)
    #return df