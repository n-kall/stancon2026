import arviz as az
import numpy as np
import preliz as pz
import matplotlib.pyplot as plt

def generate_autocorrelated_sample(original, rho):
    """
    Generates an autocorrelated sample from original.

    Parameters:
    ----------
    sample: numpy array,
        The original sample
    rho: float,
        Desired autocorrelation value

    Returns:
    --------
    new_sample: numpy array, autocorrelated sample
    """
    n = len(original)
    y = np.copy(original)
    mean = np.mean(original)
    for i in range(1, n):
        y[i] += rho * (y[i - 1] - mean) + np.random.randn()

    return y

##
# Average error as a function of the sample size for different autocorrelation values.
##
mean = 0
lag = 30
size = 300

iid_samples = pz.Normal(mean, 1).rvs((1000, size))

rhos = np.linspace(0, 0.90, 7)
N = len(rhos)

fig, ax = plt.subplots(figsize=(12, 4))

for k, rho in enumerate(rhos):
    auto_samples = np.stack(
        [generate_autocorrelated_sample(iid_sample, rho) for iid_sample in iid_samples]
    )
    auto_error = []
    for i in range(1, size):
        auto_error.append(
            np.mean(((np.mean(auto_samples[:, :i] - mean, 1) ** 2) ** 0.5))
        )

    ax.plot(auto_error[lag:], color=plt.cm.viridis_r(k / N))

sm = plt.cm.ScalarMappable(cmap=plt.cm.viridis_r)
cbar = plt.colorbar(sm, ax=ax, label="Autocorrelation", ticks=[0, 1])
cbar.ax.set_yticklabels(["Low", "High"])
cbar.ax.tick_params(length=0)

ax.set(
    yticks=[],
    ylabel="Error",
    xticks=[],
    xlabel="Sample size",
    ylim=(0, None),
    xlim=(-2, None),
)
ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)
ax.plot(1, 0, ">k", transform=ax.get_yaxis_transform(), clip_on=False)
ax.plot(-2, 1, "^k", transform=ax.get_xaxis_transform(), clip_on=False)

plt.savefig("../sections/img/autocorrelation_error.png",bbox_inches="tight")


##
# Effective sample size as a function of the sample size for different autocorrelation values.
##

mean = 0
size = 300

iid_samples = pz.Normal(mean, 1).rvs((500, size))

rhos = np.linspace(0, 0.90, 7)
N = len(rhos)

fig, ax = plt.subplots(figsize=(12, 4))

for k, rho in enumerate(rhos):
    auto_samples = np.stack(
        [generate_autocorrelated_sample(iid_sample, rho) for iid_sample in iid_samples]
    )
    auto_error = []

    for i in range(50, size, 10):
        auto_error.append(az.ess(auto_samples[:, :i]) / 500)

    ax.plot(range(50, size, 10), auto_error, color=plt.cm.viridis_r(k / N))

sm = plt.cm.ScalarMappable(cmap=plt.cm.viridis_r)
cbar = plt.colorbar(sm, ax=ax, label="Autocorrelation", ticks=[0, 1])
cbar.ax.set_yticklabels(["Low", "High"])
cbar.ax.tick_params(length=0)

ax.set(
    yticks=[],
    ylabel="Effective sample size",
    xticks=[],
    xlabel="Sample size",
    ylim=(0, None),
    xlim=(48, None),
)

ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)
ax.plot(1, 0, ">k", transform=ax.get_yaxis_transform(), clip_on=False)
ax.plot(48, 1, "^k", transform=ax.get_xaxis_transform(), clip_on=False)

plt.savefig("../sections/img/ess_ss.png",bbox_inches="tight")