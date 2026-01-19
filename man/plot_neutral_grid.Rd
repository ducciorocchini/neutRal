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

