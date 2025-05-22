import pandas as pd

int_gains = pd.read_csv("intGains.txt", sep="\t", header=1, names=['1','2','3','4','5'], index_col=0)
int_gains.loc[0:167] = 0

filename = "intGains_first_week_zero.txt"
int_gains.to_csv(filename, sep="\t", header=False, float_format='%.4f')

# append remaining to rest of file
with open(filename, 'r+') as f:
    content = f.read()
    f.seek(0, 0)
    f.write("double tab1(8760,5)".rstrip('\r\n') + '\n' + content)

with open(filename, 'r+') as f:
    content = f.read()
    f.seek(0, 0)
    f.write("#1".rstrip('\r\n') + '\n' + content)
    
