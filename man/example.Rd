library(ggplot2)

# 1) SIMULATE (competition model)
n <- 80
steps <- 200000
m <- 0.01
nu <- 0.001
seed <- 1

comp_grid <- simulate_competition(
  n = n,
  steps = steps,
  m = m,
  nu = nu,
  seed = seed
)

# 2) PLOT (one map of the final competition grid)
p_comp <- plot_competition_grid(
  grid  = comp_grid,
  n     = n,
  steps = steps,
  m     = m,
  nu    = nu
)
print(p_comp)

# 3) DIVERSITY (computed from the same grid that is plotted)
div_comp <- calculate_diversity(comp_grid)
div_comp
