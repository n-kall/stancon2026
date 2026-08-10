# Material

The material for this tutorial consists of the slides, exercises, and this book.

## Exercises

The exercises are available in both Python and R:

* Download and expand [the exercises](exercises/workflow_exercises.zip)
* This contains the exercises in different formats
* Use your preferred editor to open the chosen notebook
* The first chunk will install the required packages
* Solutions are available here: [R](exercises/solutions-r.html), [Python](exercises/solutions-python.html)

## Slides

The slides are available [here](slides/slides.html)

## Web book
Use the side bar to read further about any of the topics discussed.

# Overview

When working with Bayesian models, a range of related tasks must be addressed beyond inference itself. These include:

* Diagnosing the quality of the inferencial method (MCMC, VI, ...). As we usually use numerical methods to perform inference.
* Model checking and criticism, which includes posterior predictive checks, prior predictive checks, prior/likelihood sensitivity analysis.
* Model comparison

To simplify the workflow of performing these tasks, we can use some tools. The ones we are going to cover in this tutorial are: 

* R
    * [posterior](https://mc-stan.org/posterior/): Conversion, manipulation, and summarization of draws from posterior and prior distributions.
    * [bayesplot](https://mc-stan.org/bayesplot/): Visual checks and summaries.
    * [loo](https://mc-stan.org/loo/): Model comparison using leave-one-out cross-validation and related methods.
    * [priorsense](https://n-kall.github.io/priorsense/): Prior diagnostics and sensitivity analysis.

* Python
    * [arviz-base](https://python.arviz.org/projects/base/en/latest/): Data related functionality, including converters from different PPLs.
    * [arviz-stats](https://python.arviz.org/projects/stats/en/latest/): Statistical functions and diagnostics.
    * [arviz-plots](https://python.arviz.org/projects/plots/en/latest/): Visual checks and summaries built on top of arviz-stats and arviz-base.
    * [arviz](https://python.arviz.org/en/latest/): a meta-package that imports all the above and provides a single namespace for users.
