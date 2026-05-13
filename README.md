# Bayesian model diagnostics: Workflows and software tools

## Topics

* Posterior draws objects and manipulation
* Sampling diagnostics (R-hat and variants, ESS, pareto-k, MCSE)
* Model evaluation (model performance, posterior predictive checks, prior sensitivity)

## Structure
* Part 1 (9:00-10:00)
* Part 2 (10:00-11:00)
* Part 3 (11:00-12:00)

### Part 1: Overview of tool landscape and posterior draws objects
* Python: ArviZ
* R: posterior, bayesplot, loo, priorsense
* General structure of draws objects / DataTree
### Part 2: Covergence diagnostics and uncertainty quantification
* Checking convergence
  - rank-normalized R-hat
  - pareto-k
  - nested R-hat
* Posterior summaries and uncertainty quantification
  - mean, median, quantiles with MCSE
### Part 3: Model evaluation and critique
* model performance (R2, loo)
* posterior predictive checks (PIT-ECDF, calibration)
* prior and likelihood sensitivity (power-scaling)
