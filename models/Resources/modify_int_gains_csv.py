import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

gai = pd.read_csv("int_gains.csv", index_col=0, sep=",", lineterminator=";")
#forecast.drop(columns=["reaAuxPow[1]", "reaAuxPow[2]"], inplace=True)
#forecast["reaAuxPow[1]"] = 0
#forecast["reaAuxPow[2]"] = 0
#forecast.to_csv("internal_setpoints_occupancy.csv", index=True)

print(gai)