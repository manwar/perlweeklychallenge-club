
import pandas as pd
import numpy as np


df = pd.read_csv("Temperature.txt", sep = ",", header = None, names = ["Date", "Temperature"])
df.sort_values(by = ["Date"], inplace = True)
df["Match"] = (df.Temperature > df.Temperature.shift())

nIndxArr = np.where(df["Match"] == True)

arrData = df["Date"].iloc[nIndxArr]

print (np.stack(arrData).astype(str))
