import numpy as np
import preliz as pz
import arviz as az

rng = np.random.default_rng(3591)

good_sample = pz.Gamma(2, 5).rvs((4, 1000), random_state=rng)
bad_sample_0 = pz.Normal(np.sort(good_sample, axis=None),
    0.05).rvs(4000, random_state=rng).reshape(4, -1)

bad_sample_1 = good_sample.copy()
for i in pz.DiscreteUniform(0, 900).rvs(4, random_state=rng):
    bad_sample_1[0, i:i+50] = pz.Beta(i, 150).rvs(50, random_state=rng)

sample = az.from_dict({"posterior": {
    "good_sample": good_sample,
    "bad_sample_0": bad_sample_0,
    "bad_sample_1": bad_sample_1
}})

sample.to_netcdf("../models/prerun/sample.nc")
