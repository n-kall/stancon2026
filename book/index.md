#  Material {.unnumbered .unlisted}

The material for this tutorial consists of the [slides](slides/slides.html), exercises, and this book.

## Exercises

The exercises are available in both Python and R:

* Download and expand [this zip file](exercises/workflow_exercises.zip)
* This contains the exercises in different formats
* For RStudio, first open the file `stancon2026-workflow-tools.Rproj`, then open `exercises-r.qmd`
* For Python, use the `exercises-python.ipynb` file
* The first chunk will install the required packages. For R: `bayesplot`, `posterior`, and `priorsense`; for Python: `arviz`

The exercise can also be viewed online: [R](exercises/exercises-r.html) or [Python](exercises/exercises-python.html)

Solutions are available here: [R](exercises/solutions-r.html), [Python](exercises/solutions-python.html)


## Overview

When working with Bayesian models, a range of related tasks must be addressed beyond inference itself. These include:

* Diagnosing the quality of the inferencial method (MCMC, VI, ...). As we usually use numerical methods to perform inference.
* Model checking and criticism, which includes posterior predictive checks, prior predictive checks, prior/likelihood sensitivity analysis.
* Model comparison

To simplify the workflow of performing these tasks, we can use some tools. The ones we are going to cover in this tutorial are: 

* R
    * [posterior](https://mc-stan.org/posterior/): Conversion, manipulation, and summarization of draws from posterior and prior distributions.
    * [bayesplot](https://mc-stan.org/bayesplot/): Visual checks and summaries.
    * [priorsense](https://n-kall.github.io/priorsense/): Prior diagnostics and sensitivity analysis.

* Python
    * [arviz](https://python.arviz.org/en/latest/): a meta-package that imports all the packages bellow under a unified namespace.
        * [arviz-base](https://python.arviz.org/projects/base/en/latest/): Data related functionality, including converters from different PPLs.
        * [arviz-stats](https://python.arviz.org/projects/stats/en/latest/): Statistical functions and diagnostics.
        * [arviz-plots](https://python.arviz.org/projects/plots/en/latest/): Visual checks and summaries built on top of arviz-stats and arviz-base.
