# neutRal
Code for neutral models development

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
## Interaction among species

#### 1. `simulate_competition()`
This function simulates the dynamics of species interactions on a grid, incorporating **competition** between species. The model runs over a set number of steps and includes two main events: **immigration** and **local dispersal**. The main idea behind the competition mechanism is that when a species tries to spread into a neighboring cell, it competes with the existing species in that cell. The species with the higher population density has a better chance of occupying the cell.

##### Key Arguments:
- **`n`**: The size of the grid (n x n).
- **`steps`**: Number of iterations (steps) to simulate.
- **`m`**: Immigration probability (probability that a species tries to immigrate into a new cell).
- **`nu`**: Speciation probability (probability that immigration results in the creation of a new species).
- **`seed`**: Random seed for reproducibility.

##### Function Description:
- Initializes the grid with unique species (maximal diversity).
- Simulates immigration events, where species try to colonize empty cells or existing species in neighboring cells.
- Includes a competition event, where the species in a target cell might be replaced by the most abundant species in the grid.
- Simulates local dispersal from neighboring cells, influenced by species competition.

---

#### 2. `plot_competition_grid()`
This function generates a **heatmap-style visualization** of the grid after the species competition dynamics have been simulated. Each cell's color corresponds to a unique species, showing how the species' distribution changes over time.

##### Key Arguments:
- **`grid`**: The grid of species after running the simulation (`simulate_competition()`).
- **`n`**: The size of the grid (n x n).
- **`steps`**: Number of iterations (steps) the model ran.
- **`m`**: Immigration probability.
- **`nu`**: Speciation probability.

##### Function Description:
- Converts the grid into a dataframe format suitable for visualization.
- Uses `ggplot2` to create a **raster plot**, where each species is assigned a different color.
- The plot provides a clear visual representation of species distribution across the grid after running the competition model.

---

#### 3. `calculate_competition_diversity()`
This function calculates key **biodiversity metrics** for the grid after running the species competition simulation. It computes the following:
- **Richness (S)**: The number of unique species present in the grid.
- **Total individuals (N)**: The total number of species individuals present in the grid.
- **Shannon diversity (H)**: A measure of diversity that considers both the number of species and their relative abundance.

##### Key Arguments:
- **`grid`**: The grid of species after the simulation.

##### Function Description:
- Computes a **species frequency table** to count the occurrence of each species.
- Calculates and returns:
  - **Richness**: The number of unique species in the grid.
  - **Total**: The total number of individuals in the grid.
  - **Shannon diversity**: A measure of diversity that accounts for both the number of species and their relative abundance.

---

### Summary of Function Workflow

1. **`simulate_competition()`** simulates the spatial dynamics of species with competition, determining how species spread, compete, and colonize new spaces.
2. **`plot_competition_grid()`** visualizes the results of the simulation as a heatmap, showing the spatial distribution of species across the grid.
3. **`calculate_competition_diversity()`** computes important diversity metrics like richness, total individuals, and Shannon diversity to quantify the biodiversity in the simulated grid.

These functions work together to simulate, visualize, and analyze the dynamics of species competition in a spatially explicit model.
