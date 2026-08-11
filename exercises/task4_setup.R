library(tidyverse)
library(cmdstanr)
library(priorsense)
library(bayesplot)
library(posterior)

clean_dat <- read_csv("data/bird_counts.csv")

model <- cmdstan_model("birds_per_year.stan")

stan_data <- list(
    N = nrow(clean_dat),
    n_years = length(unique(clean_dat$Year)),
    year = clean_dat$Year - min(clean_dat$Year) + 1,
    n_species = length(species),
    species = clean_dat$species_id,
    count = clean_dat$count
)


SEED <- 123

fit1 <- model$sample(
    data = c(
        stan_data,
        mu_prior_mean = log(1000),
        mu_prior_sd = log(100),
        sigma_prior = 1,
        likelihood = 1
    ),
    iter_warmup = 20,
    iter_sampling = 400,
    seed = SEED
)

fit2 <- model$sample(
    data = c(
        stan_data,
        mu_prior_mean = log(1000),
        mu_prior_sd = log(100),
        sigma_prior = 2,
        likelihood = 1
    ),
    iter_warmup = 8000,
    iter_sampling = 1000,
    seed = SEED
)

fit3 <- model$sample(
    data = c(
        stan_data,
        mu_prior_mean = log(1000),
        mu_prior_sd = log(100),
        sigma_prior = 0.005,
        likelihood = 2
    ),
    iter_warmup = 8000,
    iter_sampling = 500,
    seed = SEED
)

fit4 <- model$sample(
    data = c(
        stan_data,
        mu_prior_mean = log(1000),
        mu_prior_sd = log(100),
        sigma_prior = 2,
        likelihood = 2
    ),
    iter_warmup = 8000,
    iter_sampling = 500,
    seed = SEED
)


diagnose_model <- function(draws) {
    sum <- summarise_draws(draws, rhat, ess_tail, ess_bulk, pareto_min_ss)

    ps <- powerscale_plot_dens(draws, variable = c("mu", "sigma"))

    yrep <- draws |>
        subset_draws(variable = "y_rep") |>
        as_draws_matrix()

    ppc1 <- ppc_intervals_grouped(
        y = stan_data$count,
        yrep = yrep,
        group = stan_data$species
    )

    ppc2 <- bayesplot::ppc_rootogram_grouped(
        y = stan_data$count,
        yrep = yrep,
        group = stan_data$species
    )

    ppc3 <- ppc_pit_ecdf_grouped(
        y = stan_data$count,
        yrep = yrep,
        group = stan_data$species,
        method = "correlated"
    )

    return(list(sum, list(ps), ppc1, ppc2, ppc3))
}

draws4 <- fit1$draws()
draws2 <- fit2$draws() |> thin_draws(2.5)
draws1 <- fit3$draws() |> thin_draws(1.25)
draws3 <- fit4$draws() |> thin_draws(1.25)

saveRDS(draws1, "draws1.rds")
saveRDS(draws2, "draws2.rds")
saveRDS(draws3, "draws3.rds")
saveRDS(draws4, "draws4.rds")


diag1 <- diagnose_model(draws1)

diag2 <- diagnose_model(draws2)

diag3 <- diagnose_model(draws3)

diag4 <- diagnose_model(draws4)
