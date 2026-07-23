library(posterior)

sim_many_short_chains <- function(
    n_draws_per_chain,
    n_superchains,
    n_chains_per_superchain
) {
    sample <- matrix(
        nrow = n_draws_per_chain,
        ncol = n_chains_per_superchain * n_superchains
    )

    superchain_means <- rnorm(n_superchains, sd = 0.01)
    superchain_sds <- abs(rnorm(n_superchains, 0, 0.1))

    for (s in 1:n_superchains) {
        for (c in 1:n_chains_per_superchain) {
            index <- (s - 1) * (n_chains_per_superchain) + c
            sample[, index] <- rnorm(
                n_draws_per_chain,
                superchain_means[s],
                superchain_sds[s]
            )
        }
    }

    sample <- as.array(sample)
    dim(sample) <- c(
        n_draws_per_chain,
        n_chains_per_superchain * n_superchains,
        1
    )

    sample <- as_draws(sample) |>
        set_variables("x")

    attr(sample, "superchain_ids") <- rep(
        1:n_superchains,
        each = n_chains_per_superchain
    )

    return(sample)
}

set.seed(123)

x <- sim_many_short_chains(10, n_superchains = 10, 20)

saveRDS(x, "models/prerun/many_short_chains.rds")
