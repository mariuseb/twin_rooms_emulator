import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

forecast = pd.read_csv("internal_setpoints_occupancy.csv", index_col=0)
forecast.drop(columns=["reaAuxPow"], inplace=True)
forecast["reaAuxPow[1]"] = 0
forecast["reaAuxPow[2]"] = 0
forecast.to_csv("internal_setpoints_occupancy.csv", index=True)

print(forecast)