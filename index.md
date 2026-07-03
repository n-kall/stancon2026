
# "Bayesian model diagnostics: Workflows and software tools"

blah blah blah

## overview

When working with Bayesian models, a range of related tasks must be addressed beyond inference itself. These include:

* Diagnosing the quality of the inferencial method (MCMC, VI, ...). As we usually use numerical methods to perform inference.
* Model checking and criticism, which includes posterior predictive checks, prior predictive checks, prior/likelihood sensitivity analysis.
* Model comparison
* etc...

To simplify the workflow of performing these tasks, we can use some tools. The ones we are going to cover in this tutorial are: 

* R
    * posterior: Conversion, manipulation, and summarization of draws from posterior and prior distributions.
    * bayesplot: Visual checks and summaries.
    * loo: Model comparison using leave-one-out cross-validation and related methods.
    * priorsense: Prior diagnostics and sensitivity analysis.

* Python
    * arviz-base: Data related functionality, including converters from different PPLs.
    * arviz-stats: Statistical functions and diagnostics.
    * arviz-plots: Visual checks and summaries built on top of arviz-stats and arviz-base.
    * arviz: a meta-package that imports all the above and provides a single namespace for users.