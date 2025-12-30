# Load necessary library
library(ggplot2)

# Function to simulate neutral grid
simulate_neutral_grid <- function(n = 80, steps = 200000, m = 0.01, nu = 0.001, seed = 1) {
  set.seed(seed)
  
  # Initialize grid with unique species (maximal diversity)
  grid <- matrix(1:(n*n), nrow = n, ncol = n)
  next_species_id <- n*n + 1
  
  # Helper: pick a random von Neumann neighbor
  pick_neighbor <- function(i, j) {
    up    <- ifelse(i == 1, n, i - 1)
    down  <- ifelse(i == n, 1, i + 1)
    left  <- ifelse(j == 1, n, j - 1)
    right <- ifelse(j == n, 1, j + 1)
    
    nbrs <- rbind(
      c(up, j),
      c(down, j),
      c(i, left),
      c(i, right)
    )
    k <- sample(1:4, 1)
    nbrs[k, ]
  }

  # Create an empty list to store images at each step
  plots <- list()
  
  # Main neutral dynamics simulation
  for (t in seq_len(steps)) {
    i <- sample.int(n, 1)
    j <- sample.int(n, 1)
    
    if (runif(1) < m) {
      # Immigration / metacommunity event
      if (runif(1) < nu) {
        # Speciation event: Assign new species
        grid[i, j] <- next_species_id
        next_species_id <- next_species_id + 1
      } else {
        # Immigration: Species from the grid
        grid[i, j] <- sample(grid, 1)
      }
    } else {
      # Local dispersal: Spread to a neighboring cell
      nb <- pick_neighbor(i, j)
      grid[i, j] <- grid[nb[1], nb[2]]
    }
    
    # Every 1000 steps, capture a plot of the grid
    if (t %% 1000 == 0) {
      df <- expand.grid(x = 1:n, y = 1:n)
      df$species <- as.vector(grid)
      df$species_f <- factor(df$species)
      
      p <- ggplot(df, aes(x = x, y = y, fill = species_f)) +
        geom_raster() +
        coord_equal() +
        labs(title = paste("Species Spread at Step", t), x = "X", y = "Y", fill = "Species") +
        theme_minimal() +
        theme(legend.position = "none")
      
      # Save the plot in the list
      plots[[length(plots) + 1]] <- p
    }
  }
  
  return(plots)
}
