renv::init(force = TRUE, bare = TRUE, bioconductor = FALSE)
install.packages(
    c("bayesplot", "posterior", "priorsense", "loo", "rmarkdown"),
    repos = c(
        'https://stan-dev.r-universe.dev',
        "https://n-kall.r-universe.dev",
        'https://cloud.r-project.org'
    )
)

renv::snapshot()
