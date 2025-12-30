
# Function to calculate richness, total individuals, and Shannon diversity
calculate_diversity <- function(grid) {
  tab <- table(as.vector(grid))
  S <- length(tab)                # Richness
  N <- sum(tab)                   # Total individuals
  H <- -sum((tab/N) * log(tab/N)) # Shannon diversity

  return(list(Richness = S, Total = N, Shannon = round(H, 3)))
}
