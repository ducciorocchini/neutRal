## Running a neutral community simulation

This example demonstrates the basic workflow of the **neutRal** package:
simulating a spatially explicit neutral community, visualizing its final state, and
quantifying its biodiversity.

---

### Code: simulate → plot → calculate diversity

```r

library(neutRal)
library(ggplot2)

# Run simulation
sim <- simulate_neutral_grid(
  n = 80,
  steps = 200000,
  m = 0.01,
  nu = 0.001,
  seed = 1
)

# Plot final community state
plot_neutral_grid(
  grid  = sim$grid,
  n     = sim$params$n,
  steps = sim$params$steps,
  m     = sim$params$m,
  nu    = sim$params$nu
)

# Calculate biodiversity metrics
calculate_diversity(sim$grid)
