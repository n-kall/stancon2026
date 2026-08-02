import pandas as pd
import numpy as np
import arviz as az
import xarray as xr

df = pd.read_csv("../models/prerun/drt.csv")

variables = ["xn", "xt3", "xt2_5", "xt2", "xt1_5", "xt1"]
n_chains = df[".chain"].nunique()
n_draws  = df[".iteration"].nunique()

# Reshape each variable to (chain, draw)
data = {}
for v in variables:
    data[v] = (
        df.sort_values([".chain", ".iteration"])
        .groupby(".chain")[v]
        .apply(np.array)
        .values
        .tolist()  # list of arrays, one per chain
    )
    data[v] = np.array(data[v])  # shape: (chain, draw)

# Build xarray Dataset then DataTree
ds = xr.Dataset(
    {v: (["chain", "draw"], data[v]) for v in variables},
    coords={"chain": range(n_chains), "draw": range(n_draws)}
)

drt = az.from_dict({"posterior": ds})
drt.to_netcdf("../models/prerun/drt.nc")