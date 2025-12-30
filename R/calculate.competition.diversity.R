# Function to calculate biodiversity metrics (richness, total individuals, Shannon diversity)
calculate_competition_diversity <- function(grid) {
  tab <- table(as.vector(grid))
  S <- length(tab)                # Richness (number of species)
  N <- sum(tab)                   # Total individuals
  H <- -sum((tab/N) * log(tab/N)) # Shannon diversity

  return(list(Richness = S, Total = N, Shannon = round(H, 3)))
}
