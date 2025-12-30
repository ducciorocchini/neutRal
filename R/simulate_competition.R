# Function to simulate species competition on a grid
simulate_competition <- function(n = 80, steps = 200000, m = 0.01, nu = 0.001, seed = 1) {
  set.seed(seed)
  
  # Initialize the grid with unique species (max diversity)
  grid <- matrix(1:(n*n), nrow = n, ncol = n)
  next_species_id <- n*n + 1
  
  # Helper function to pick a random von Neumann neighbor
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
  
  # Main competition dynamics loop
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
        # Immigration: Species competing for the same cell
        # Draw from a neighboring species (local competition)
        neighbor_species <- grid[pick_neighbor(i, j)[1], pick_neighbor(i, j)[2]]
        
        # Competition: species with higher population density has a better chance
        species_counts <- table(as.vector(grid))
        most_abundant_species <- names(species_counts[which.max(species_counts)])
        
        # If the neighboring species is more abundant, the current species will be replaced
        if (runif(1) < 0.5 && as.character(grid[i, j]) != most_abundant_species) {
          grid[i, j] <- most_abundant_species
        } else {
          grid[i, j] <- sample(c(grid[i, j], neighbor_species), 1)
        }
      }
    } else {
      # Local dispersal: Species moves into an adjacent cell based on competition
      nb <- pick_neighbor(i, j)
      grid[i, j] <- sample(c(grid[nb[1], nb[2]], grid[i, j]), 1)  # Competition for the neighboring cell
    }
  }
  
  return(grid)
}
