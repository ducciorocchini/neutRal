# Function to simulate a spatially explicit neutral model
simulate_neutral_grid <- function(n = 80, steps = 200000,
                                  m = 0.01, nu = 0.001,
                                  seed = 1, snapshot_every = NULL) {
  set.seed(seed)

  # Initialize grid with unique species (maximal diversity)
  grid <- matrix(1:(n * n), nrow = n, ncol = n)
  next_species_id <- n * n + 1

  # Helper: pick a random von Neumann neighbor (periodic boundaries)
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
    nbrs[sample(1:4, 1), ]
  }

  # Optional storage of intermediate grids
  snapshots <- list()
  snapshot_steps <- integer(0)

  # Main neutral dynamics simulation
  for (t in seq_len(steps)) {
    i <- sample.int(n, 1)
    j <- sample.int(n, 1)

    if (runif(1) < m) {
      # Immigration / metacommunity event
      if (runif(1) < nu) {
        # Speciation
        grid[i, j] <- next_species_id
        next_species_id <- next_species_id + 1
      } else {
        # Immigration from local pool
        grid[i, j] <- sample(grid, 1)
      }
    } else {
      # Local dispersal
      nb <- pick_neighbor(i, j)
      grid[i, j] <- grid[nb[1], nb[2]]
    }

    # Save snapshot if requested
    if (!is.null(snapshot_every) && t %% snapshot_every == 0) {
      snapshots[[length(snapshots) + 1]] <- grid
      snapshot_steps <- c(snapshot_steps, t)
    }
  }

  # Return results
  list(
    grid = grid,
    snapshots = snapshots,
    snapshot_steps = snapshot_steps,
    params = list(n = n, steps = steps, m = m, nu = nu, seed = seed)
  )
}
