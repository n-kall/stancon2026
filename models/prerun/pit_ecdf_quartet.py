import arviz as az
import preliz as pz

SEED = 3592
observed = pz.Normal(0, 1).rvs(200, random_state=SEED)

predictions = {}
for i, (mu, sigma) in enumerate([
                                (0.5, 1),  # shifted to the right
                                (-0.5, 1), # shifted to the left
                                (0, 2),    # wider 
                                (0, 0.5),  # narrower
                                ]):
    predictions[f"y{i}"] =  pz.Normal(mu, sigma).rvs((4, 500, 200), random_state=SEED)

dt_i = az.from_dict({
    "posterior_predictive":predictions,
    "observed_data": {f"y{i}": observed for i in range(len(predictions))}
})

dt_i.to_netcdf("pit_ecdf_quartet.nc")