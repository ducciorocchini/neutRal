# Spatial neutral model (grid-based) with map visualization
simulate_neutral_grid <- function(n = 80, steps = 200000, m = 0.01, nu = 0.001, seed = 1) {
  set.seed(seed)

  # Initialize the grid with unique species (max diversity)
  grid <- matrix(1:(n*n), nrow = n, ncol = n)
  next_species_id <- n*n + 1

  # Helper function to pick a random von Neumann neighbor (up/down/left/right with wrap-around)
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

  # Main neutral dynamics loop
  for (t in seq_len(steps)) {
    # Death event (random cell selected)
    i <- sample.int(n, 1)
    j <- sample.int(n, 1)

    if (runif(1) < m) {
      # Immigration / metacommunity event
      if (runif(1) < nu) {
        # Speciation: assign a new species
        grid[i, j] <- next_species_id
        next_species_id <- next_species_id + 1
      } else {
        # Immigration: draw an existing species
        grid[i, j] <- sample(grid, 1)
      }
    } else {
      # Local dispersal from a neighboring cell
      nb <- pick_neighbor(i, j)
      grid[i, j] <- grid[nb[1], nb[2]]
    }
  }

  return(grid)
}
