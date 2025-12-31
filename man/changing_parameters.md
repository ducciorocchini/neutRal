## Exploring the effects of immigration (m) and speciation (ν), with richness and Shannon diversity

This example generates **four neutral community simulations** and displays their final spatial
configurations in a **2×2 layout**:

- **Top row:** only the immigration probability \(m\) is varied (speciation \(\nu\) fixed).
- **Bottom row:** only the speciation probability \(\nu\) is varied (immigration \(m\) fixed).

For each simulation, we also compute and display:
- **Richness** \(S\) (number of species present)
- **Shannon diversity** \(H'\)

These biodiversity metrics are calculated from the **same final grid** that is visualized.

---

### Code: simulate → calculate diversity → plot (2×2)

```r
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

sim_m1 <- simulate_neutral_grid(n = n, steps = steps, m = 0.01, nu = nu_fixed, seed = seed)
sim_m2 <- simulate_neutral_grid(n = n, steps = steps, m = 0.10, nu = nu_fixed, seed = seed)

div_m1 <- calculate_diversity(sim_m1$grid)
div_m2 <- calculate_diversity(sim_m2$grid)

p_m1 <- plot_neutral_grid(sim_m1$grid, n, steps, m = 0.01, nu = nu_fixed) +
  ggtitle(expression(m == 0.01)) +
  labs(caption = paste0("S = ", div_m1$Richness, "   |   H' = ", div_m1$Shannon))

p_m2 <- plot_neutral_grid(sim_m2$grid, n, steps, m = 0.10, nu = nu_fixed) +
  ggtitle(expression(m == 0.10)) +
  labs(caption = paste0("S = ", div_m2$Richness, "   |   H' = ", div_m2$Shannon))

# -----------------------------
# Bottom row: vary nu (m fixed)
# -----------------------------
m_fixed <- 0.01

sim_nu1 <- simulate_neutral_grid(n = n, steps = steps, m = m_fixed, nu = 0.001, seed = seed)
sim_nu2 <- simulate_neutral_grid(n = n, steps = steps, m = m_fixed, nu = 0.010, seed = seed)

div_nu1 <- calculate_diversity(sim_nu1$grid)
div_nu2 <- calculate_diversity(sim_nu2$grid)

p_nu1 <- plot_neutral_grid(sim_nu1$grid, n, steps, m = m_fixed, nu = 0.001) +
  ggtitle(expression(nu == 0.001)) +
  labs(caption = paste0("S = ", div_nu1$Richness, "   |   H' = ", div_nu1$Shannon))

p_nu2 <- plot_neutral_grid(sim_nu2$grid, n, steps, m = m_fixed, nu = 0.010) +
  ggtitle(expression(nu == 0.010)) +
  labs(caption = paste0("S = ", div_nu2$Richness, "   |   H' = ", div_nu2$Shannon))

# -----------------------------
# Combine plots (2×2 layout)
# -----------------------------
((p_m1 | p_m2) / (p_nu1 | p_nu2)) +
  plot_annotation(
    title = "Effects of immigration (m) and speciation (ν) on spatial neutral communities",
    theme = theme(plot.title = element_text(hjust = 0.5, face = "bold"))
  ) &
  theme(
    plot.caption = element_text(hjust = 0.5, size = 10),
    plot.title = element_text(face = "bold")
  )
Interpretation (what to expect)
Varying 
𝑚
m (top row) typically changes the degree of spatial mixing/clustering.

Varying 
𝜈
ν (bottom row) often changes richness 
𝑆
S and Shannon 
𝐻
′
H 
′
  more
strongly than the large-scale geometry of patches in the final map.

Because the diversity metrics are printed in each panel (caption line), the effect of 
𝜈
ν
is visible even when spatial patterns appear similar.
