library(ncdf4)
library(posterior)

path <- "../models/prerun/pit_ecdf_quartet.nc"
vars <- paste0("y", 0:3)

nc <- nc_open(path)

posterior_predictive <- lapply(vars, function(v) {
    x <- ncvar_get(nc, paste0("posterior_predictive/", v))
    x <- aperm(x, c(2, 3, 1))

    dimnames(x) <- list(
        iteration = NULL,
        chain = NULL,
        variable = paste0(v, "[", seq_len(dim(x)[3]), "]")
    )

    as_draws_array(x)
})
names(posterior_predictive) <- vars

observed_data <- lapply(vars, function(v) {
    ncvar_get(nc, paste0("observed_data/", v))
})
names(observed_data) <- vars

nc_close(nc)

data_i <- list(
    observed_data = observed_data,
    posterior_predictive = posterior_predictive
)

saveRDS(data_i, "pit_ecdf_quartet.rds")
