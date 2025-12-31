# neutRal
The neutRal package enables users to simulate spatially explicit neutral models of community dynamics, visualize outcomes, and compute basic biodiversity metrics.

## Structure of the package
```
neutRal/
├── R/
│ ├── simulate_neutral_grid.R             
│ ├── plot_neutral_grid.R                  
│ ├── calculate_diversity.R               
├── man/                                      
│ ├── example.Rd
├── tests/                                     # to be done
│ ├── test_simulate_neutral_grid.R
│ ├── test_plot_neutral_grid.R
│ ├── test_calculate_diversity.R
│ ├── test_simulate_competition.R
│ ├── test_plot_competition_grid.R
│ └── test_calculate_competition_diversity.R
├── DESCRIPTION                                # to be done
└── NAMESPACE                                  # to be done
```

## Explanation of the single species neutral functions:

- **`simulate_neutral_grid()`**:  
  This function runs the spatial neutral model with specified parameters. It simulates the community dynamics based on immigration, speciation, and local dispersal events, updating the grid over the given number of steps.

- **`plot_neutral_grid()`**:  
  This function generates a heatmap using `ggplot2`, where each cell's color corresponds to a species, based on the grid after the simulation.

- **`calculate_diversity()`**:  
  This function calculates three important biodiversity metrics:
  - **Richness (S)**: The number of unique species in the grid.
  - **Total individuals (N)**: The total number of individuals (cells occupied by species).
  - **Shannon diversity (H)**: A measure of species diversity considering the relative abundance of each species.

### Key Parameters:

- **`n`**: Size of the grid (`n x n`).
- **`steps`**: Number of iterations (steps) to simulate.
- **`m`**: Immigration probability (how likely a new species or an immigrant species is introduced to the grid).
- **`nu`**: Speciation probability (given immigration, the chance of introducing a new species).

### Usage:

1. Run the model with your desired parameters (e.g., grid size, steps, and probabilities).
2. Visualize the final grid as a "map" of species distribution.
3. Calculate and display the diversity metrics.

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
