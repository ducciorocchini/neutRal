# Load required libraries
library(ggplot2)
library(patchwork)

# -----------------------------
# Simulation settings
# -----------------------------
n     <- 80
steps <- 200000
seed  <- 1

# -----------------------------
# Top row: vary m (nu fixed)
# -----------------------------
nu_fixed <- 0.001

sim_m1 <- simulate_neutral_grid(
  n = n, steps = steps, m = 0.01, nu = nu_fixed, seed = seed
)
sim_m2 <- simulate_neutral_grid(
  n = n, steps = steps, m = 0.10, nu = nu_fixed, seed = seed
)

p_m1 <- plot_neutral_grid(sim_m1$grid, n, steps, m = 0.01, nu = nu_fixed) +
  ggtitle(expression(m == 0.01))

p_m2 <- plot_neutral_grid(sim_m2$grid, n, steps, m = 0.10, nu = nu_fixed) +
  ggtitle(expression(m == 0.10))

# -----------------------------
# Bottom row: vary nu (m fixed)
# -----------------------------
m_fixed <- 0.01

sim_nu1 <- simulate_neutral_grid(
  n = n, steps = steps, m = m_fixed, nu = 0.001, seed = seed
)
sim_nu2 <- simulate_neutral_grid(
  n = n, steps = steps, m = m_fixed, nu = 0.010, seed = seed
)

p_nu1 <- plot_neutral_grid(sim_nu1$grid, n, steps, m = m_fixed, nu = 0.001) +
  ggtitle(expression(nu == 0.001))

p_nu2 <- plot_neutral_grid(sim_nu2$grid, n, steps, m = m_fixed, nu = 0.010) +
  ggtitle(expression(nu == 0.010))

# -----------------------------
# Combine plots (2 x 2 layout)
# -----------------------------
((p_m1 | p_m2) / (p_nu1 | p_nu2)) +
  plot_annotation(
    # title = "Effects of immigration (m) and speciation (ν) on spatial neutral communities",
    theme = theme(plot.title = element_text(hjust = 0.5, face = "bold"))
  )
