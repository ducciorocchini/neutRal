# neutRal
Code for neutral models development

## Example usage: 

```r

n <- 80
steps <- 250000
m <- 0.01     # Immigration probability
nu <- 0.001   # Speciation probability

# Run the simulation
final_grid <- simulate_neutral_grid(n = n, steps = steps, m = m, nu = nu, seed = 42)

# Visualize the grid
plot_neutral_grid(final_grid, n, steps, m, nu)

# Calculate diversity metrics
diversity <- calculate_diversity(final_grid)

# Print diversity metrics
cat("Richness S =", diversity$Richness, "\n")
cat("Total N =", diversity$Total, "\n")
cat("Shannon H =", diversity$Shannon, "\n")

```
