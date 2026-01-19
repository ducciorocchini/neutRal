\name{calculate_diversity}
\alias{calculate_diversity}
\title{Calculate biodiversity metrics from a community grid}
\description{
This function computes basic biodiversity metrics from a spatially explicit
community represented as a grid of species identities. The metrics include
species richness, total number of individuals, and Shannon diversity.
}
\usage{
calculate_diversity(grid)
}
\arguments{
\item{grid}{A matrix representing a community, where each cell contains a
species identifier.}
}
\details{
The total number of individuals corresponds to the total number of cells in
the grid. Shannon diversity is computed using natural logarithms.
}
\value{
A named list containing:
\describe{
  \item{Richness}{Species richness (\eqn{S}).}
  \item{Total}{Total number of individuals (\eqn{N}).}
  \item{Shannon}{Shannon diversity index (\eqn{H}), rounded to three decimals.}
}
}
\seealso{
\code{\link{simulate_neutral_grid}}, \code{\link{plot_neutral_grid}}
}
\examples{
# Example grid (toy community)
set.seed(1)
grid <- matrix(sample(1:10, 25, replace = TRUE), nrow = 5)

calculate_diversity(grid)
}
