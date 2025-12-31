#' Calculate biodiversity metrics from a community grid
#'
#' This function computes basic biodiversity metrics from a spatially explicit
#' community represented as a grid of species identities. The metrics include
#' species richness, total number of individuals, and Shannon diversity.
#'
#' @param grid A matrix representing a community, where each cell contains a
#'   species identifier.
#'
#' @return A named list containing:
#'   \describe{
#'     \item{Richness}{Species richness ($S$).}
#'     \item{Total}{Total number of individuals ($N$).}
#'     \item{Shannon}{Shannon diversity index ($H$), rounded to three decimals.}
#'   }
#'
#' @details
#' The total number of individuals corresponds to the total number of cells in
#' the grid. Shannon diversity is computed using natural logarithms.
#'
#' @seealso \code{\link{simulate_neutral_grid}}, \code{\link{plot_neutral_grid}}
#'
#' @export
# Function to calculate richness, total individuals, and Shannon diversity
calculate_diversity <- function(grid) {
  tab <- table(as.vector(grid))
  S <- length(tab)                # Richness
  N <- sum(tab)                   # Total individuals
  H <- -sum((tab/N) * log(tab/N)) # Shannon diversity

  return(list(Richness = S, Total = N, Shannon = round(H, 3)))
}
