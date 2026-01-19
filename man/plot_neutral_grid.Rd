\name{plot_neutral_grid}
\alias{plot_neutral_grid}
\title{Plot a spatially explicit neutral community}
\description{
This function visualizes the spatial configuration of a simulated neutral
community on a square lattice. Each cell in the grid is colored according
to its species identity. Simulation parameters are used only to annotate
the plot and do not affect the graphical computation.
}
\usage{
plot_neutral_grid(grid, n, steps, m, nu)
}
\arguments{
\item{grid}{A matrix representing the final community state, where each
cell contains a species identifier.}

\item{n}{An integer specifying the number of cells along each side of the
square grid.}

\item{steps}{The number of simulation steps used to generate the grid.
This parameter is used for plot annotation only.}

\item{m}{The immigration probability used in the simulation. This parameter
is used for plot annotation only.}

\item{nu}{The speciation probability (conditional on immigration) used in
the simulation. This parameter is used for plot annotation only.}
}
\details{
The function does not modify the input grid and does not perform any
simulation. All parameters except \code{grid} are included solely to provide
informative annotations in the resulting plot.
}
\value{
A \code{ggplot} object representing the spatial distribution of species across
the grid.
}
\seealso{
\code{\link{simulate_neutral_grid}}, \code{\link{calculate_diversity}}
}
\examples{
# Simulate a small grid and plot it
res <- simulate_neutral_grid(n = 20, steps = 2000, m = 0.02, nu = 0.005, seed = 1)
plot_neutral_grid(res$grid, n = res$params$n, steps = res$params$steps,
                  m = res$params$m, nu = res$params$nu)
}
📁 man/simulate_neutral_grid.Rd
r
Copia codice
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
