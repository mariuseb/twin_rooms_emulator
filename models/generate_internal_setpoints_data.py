#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
This script generates internal load and set point data for data.csv in BOPTEST.
Simulate the test case and output in sim.csv the following variables:

    flo.zone.qGai_flow[x] for all x in [1-3] and all zone in zones
    flo.intGaiFra.y
    hvac.occSch.occupied

"""

import pandas as pd

mapper_names = {'qGai_flow[1]':'InternalGainsRad',
                'qGai_flow[2]':'InternalGainsCon',
                'qGai_flow[3]':'InternalGainsLat'}
mapper_zones = {"1": "1", "2": "2", "3": "3"}

area = {
    "1":66.7,
    "2":66.7,
    "3":200
}

df = pd.read_csv('sim.csv',index_col='Time')
datetime_start = pd.Timestamp("2022-01-01 00:00")
dt_index = pd.to_datetime(df.index, origin=datetime_start, unit="s")
df["dt_index"] = dt_index
df["day"] = df["dt_index"].apply(lambda x: x.dayofweek)
# set unoccupied on weekends:
df["hvac.occSch.occupied"].loc[(df.day == 6) | (df.day == 5)] = 0
# Internal Loads
mapper = {}
for key in df.columns:
    for name in mapper_names.keys():
        if name in key:
            for zone in mapper_zones.keys():
                if zone in key.lower():
                    mapper[key] = mapper_names[name]+'[{0}]'.format(mapper_zones[zone])
                    if 'qGai_flow' in key:
                        df[key] = df[key].values*area[mapper_zones[zone]]
df = df.rename(columns=mapper)
df.index.name = 'time'

# Set points
for _zone in range(1,4):
    zone = str(_zone)
    df['LowerSetp[{0}]'.format(mapper_zones[zone])] = 15+273.15
    df['LowerSetp[{0}]'.format(mapper_zones[zone])][df['hvac.occSch.occupied']>0] = 22+273.15
    df['UpperSetp[{0}]'.format(mapper_zones[zone])] = 30+273.15
    df['UpperSetp[{0}]'.format(mapper_zones[zone])][df['hvac.occSch.occupied']>0] = 24+273.15
    df['UpperCO2[{0}]'.format(mapper_zones[zone])] = 894

# Occupancy
density = 0.05
for key in df.columns:
    if 'flo.intGaiFra.y[1]' in key:
        for zone in area.keys():
            df['Occupancy[{0}]'.format(zone)] = (df[key].values*area[zone]*density).astype(int)

df = df.drop(columns=['hvac.occSch.occupied'])
df = df.drop(columns=['flo.intGaiFra.y[1]'])
df = df.drop(columns=['dt_index'])
df = df.drop(columns=['day'])
df = df.loc[:,~df.columns.duplicated()].copy()
df.to_csv('Resources/internal_setpoints_occupancy.csv')
