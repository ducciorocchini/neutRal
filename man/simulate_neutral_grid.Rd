\name{simulate_neutral_grid}
\alias{simulate_neutral_grid}
\title{Simulate spatially explicit neutral community dynamics}
\description{
Simulates a spatially explicit neutral community on a square lattice using
local dispersal (von Neumann neighborhood with periodic boundaries) and
occasional immigration events. Immigration can generate new species via
speciation with probability \code{nu} (conditional on immigration).
Optionally, intermediate snapshots of the grid can be saved.
}
\usage{
simulate_neutral_grid(
  n = 80,
  steps = 200000,
  m = 0.01,
  nu = 0.001,
  seed = 1,
  snapshot_every = NULL
)
}
\arguments{
\item{n}{Number of cells along each side of the grid.}

\item{steps}{Number of simulation steps.}

\item{m}{Immigration probability.}

\item{nu}{Speciation probability (conditional on immigration).}

\item{seed}{Random seed.}

\item{snapshot_every}{Interval for saving snapshots. If \code{NULL}, no snapshots
are saved.}
}
\value{
A list containing:
\describe{
  \item{grid}{The final community grid (matrix of species identifiers).}
  \item{snapshots}{A list of intermediate grids saved during the simulation (may be empty).}
  \item{snapshot_steps}{An integer vector of the time steps at which snapshots were saved.}
  \item{params}{A list of the simulation parameters used (\code{n}, \code{steps}, \code{m}, \code{nu}, \code{seed}).}
}
}
\examples{
# Quick run for documentation/examples
res <- simulate_neutral_grid(n = 30, steps = 5000, m = 0.02, nu = 0.002, seed = 1)

# Diversity metrics on the final grid
calculate_diversity(res$grid)

# Plot the final community
plot_neutral_grid(res$grid, n = res$params$n, steps = res$params$steps,
                  m = res$params$m, nu = res$params$nu)
}
