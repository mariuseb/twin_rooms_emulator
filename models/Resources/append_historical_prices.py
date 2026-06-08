import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

prices = pd.read_csv("prices_old.csv", index_col=0)
hist = pd.read_csv("prices_2022-01-01_to_2026-06-08_NO3.csv", index_col=0)
hist.index = pd.to_datetime(hist.index).tz_localize(None)
#hist = hist.resample(rule="15min").ffill()

# get 2026:
this_year_inds = [ndx for ndx in hist.index if ndx.year == 2026]
this_year = hist.loc[this_year_inds]
"""
last_year_inds = [ndx for ndx in hist.index if ndx.year == 2025]
last_year = hist.loc[last_year_inds]

merge_ndx = this_year.index[-1] + pd.Timedelta(minutes=15)
merge_ndx = pd.Timestamp(
    str(merge_ndx).replace("2026", "2025")
)
comb = pd.concat([this_year, last_year.loc[merge_ndx:]])
comb.index = range(0,len(comb.index)*900, 900)
"""

this_year.index = np.arange(0, len(this_year)*900.0, 900.0)
prices["PriceElectricHistorical"] = 1
prices.loc[this_year.index, "PriceElectricHistorical"] = this_year.values/1000
prices["PriceElectricPowerHighlyDynamic"] = prices["PriceElectricHistorical"] 
prices.drop(columns=["PriceElectricHistorical"], inplace=True)
prices.to_csv("prices.csv", index=True)

print(hist)