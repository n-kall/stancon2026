library(posterior)

N=1000
phi=0.3
set.seed(6534)
dr<-array(data=replicate(4,as.numeric(arima.sim(n = N,
                                                list(ar = c(phi)),
                                                sd = sqrt((1-phi^2))))),
         dim=c(N,4,1)) |>
  as_draws_df() |>
  set_variables('xn')


drt <- dr |>
  mutate_variables(xt3=qt(pnorm(xn), df=3),
                   xt2_5=qt(pnorm(xn), df=2.5),
                   xt2=qt(pnorm(xn), df=2),
                   xt1_5=qt(pnorm(xn), df=1.5),
                   xt1=qt(pnorm(xn), df=1))

saveRDS(drt, "../models/prerun/drt.rds")
write.csv(as_draws_df(drt), "../models/prerun/drt.csv", row.names = FALSE)