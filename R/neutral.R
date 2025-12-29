# Spatial neutral model (grid-based) + map visualization
# install.packages(c("ggplot2"))  # if needed
library(ggplot2)

simulate_neutral_grid <- function(n = 80, steps = 200000, m = 0.01, nu = 0.001, seed = 1) {
  set.seed(seed)

  # Start with unique species everywhere (max diversity initial condition)
  grid <- matrix(1:(n*n), nrow = n, ncol = n)
  next_species_id <- n*n + 1

  # Helper: pick a random von Neumann neighbor (up/down/left/right) with wrap-around
  pick_neighbor <- function(i, j) {
    # wrap-around (toroidal world)
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

  # Main neutral dynamics
  for (t in seq_len(steps)) {
    # death event
    i <- sample.int(n, 1)
    j <- sample.int(n, 1)

    if (runif(1) < m) {
      # immigration / metacommunity event
      if (runif(1) < nu) {
        # speciation: brand new species ID
        grid[i, j] <- next_species_id
        next_species_id <- next_species_id + 1
      } else {
        # draw an existing species (simple proxy metacommunity draw)
        grid[i, j] <- sample(grid, 1)
      }
    } else {
      # local dispersal from a neighbor
      nb <- pick_neighbor(i, j)
      grid[i, j] <- grid[nb[1], nb[2]]
    }
  }

  grid
}

# ---- Run model ----
n <- 80
steps <- 250000
m <- 0.01     # immigration probability
nu <- 0.001   # speciation probability (given immigration)

final_grid <- simulate_neutral_grid(n = n, steps = steps, m = m, nu = nu, seed = 42)

# ---- Make a "map" ----
df <- expand.grid(x = 1:n, y = 1:n)
df$species <- as.vector(final_grid)

# Convert species IDs to a categorical factor for discrete coloring
df$species_f <- factor(df$species)

ggplot(df, aes(x = x, y = y, fill = species_f)) +
  geom_raster() +
  coord_equal() +
  labs(
    title = "Spatial Neutral Model (grid community map)",
    subtitle = paste0("n=", n, ", steps=", steps, ", m=", m, ", nu=", nu),
    x = "X", y = "Y", fill = "Species"
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold")
  )


tab <- table(as.vector(final_grid))
S <- length(tab)                # richness
N <- sum(tab)                   # total individuals
H <- -sum((tab/N) * log(tab/N)) # Shannon diversity

cat("Richness S =", S, "\n")
cat("Total N =", N, "\n")
cat("Shannon H =", round(H, 3), "\n")
