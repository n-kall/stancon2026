setwd("exercises/rendered")

repos <- c(CRAN = "https://cloud.r-project.org", STAN = "https://stan-dev.r-universe.dev", NKALL = "https://n-kall.r-universe.dev")
options(repos = repos)

renv::init(force = TRUE, bare = TRUE, bioconductor = FALSE)
renv::install(c(
    "STAN::posterior",
    "STAN::loo",
    "STAN::bayesplot",
    "NKALL::priorsense"
))

renv::snapshot()
