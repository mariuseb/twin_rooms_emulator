import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

prices = pd.read_csv("prices_old.csv", index_col=0)
first = pd.read_csv("prices_2026-01-01_to_2026-06-30_NO3.csv", index_col=0)
second = pd.read_csv("prices_2022-01-01_to_2022-12-31_NO3.csv", index_col=0)
first.index = pd.to_datetime(first.index).tz_localize(None)
second.index = pd.to_datetime(second.index).tz_localize(None)
# convert to timedelta:
first.index = first.index - first.index[0]
second.index = second.index - second.index[0]
# upsample second:
second = second.resample(rule="15min").ffill()
split = first.index[-1] + pd.Timedelta(minutes=15)

hist = pd.concat([
    first, second.loc[split:]
])
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

hist.index = np.arange(0, len(hist)*900.0, 900.0)
prices["PriceElectricPowerHighlyDynamic"] = hist/1000
prices["PriceElectricPowerHighlyDynamic"] = prices["PriceElectricPowerHighlyDynamic"].ffill()
prices.to_csv("prices.csv", index=True)

print(hist)