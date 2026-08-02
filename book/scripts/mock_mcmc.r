library(ncdf4)
library(posterior)

nc <- nc_open("../models/prerun/sample.nc")

good_sample <- ncvar_get(nc, "good_sample")
bad_sample_0 <- ncvar_get(nc, "bad_sample_0")
bad_sample_1 <- ncvar_get(nc, "bad_sample_1")
nc_close(nc)

n_draw <- nrow(good_sample)
n_chain <- ncol(good_sample)

arr <- array(
    data = c(good_sample, bad_sample_0, bad_sample_1),
    dim = c(n_draw, n_chain, 3),
    dimnames = list(
        iteration = NULL,
        chain = NULL,
        variable = c("good_sample", "bad_sample_0", "bad_sample_1")
    )
)

sample <- as_draws_array(arr)
saveRDS(sample, "../models/prerun/sample.rds")
