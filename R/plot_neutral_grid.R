#' Plot a spatially explicit neutral community
#'
#' This function visualizes the spatial configuration of a simulated neutral
#' community on a square lattice. Each cell in the grid is colored according
#' to its species identity. Simulation parameters are used only to annotate
#' the plot and do not affect the graphical computation.
#'
#' @param grid A matrix representing the final community state, where each
#'   cell contains a species identifier.
#' @param n An integer specifying the number of cells along each side of the
#'   square grid.
#' @param steps The number of simulation steps used to generate the grid.
#'   This parameter is used for plot annotation only.
#' @param m The immigration probability used in the simulation. This parameter
#'   is used for plot annotation only.
#' @param nu The speciation probability (conditional on immigration) used in
#'   the simulation. This parameter is used for plot annotation only.
#'
#' @return A \code{ggplot} object representing the spatial distribution of
#'   species across the grid.
#'
#' @details
#' The function does not modify the input grid and does not perform any
#' simulation. All parameters except \code{grid} are included solely to provide
#' informative annotations in the resulting plot.
#'
#' @seealso \code{\link{simulate_neutral_grid}}, \code{\link{calculate_diversity}}
#'
#' @importFrom ggplot2 ggplot aes geom_raster coord_equal labs theme_minimal theme
#' @export
plot_neutral_grid <- function(grid, n, steps, m, nu) {

  df <- expand.grid(x = 1:n, y = 1:n)
  df$species <- as.vector(t(grid))
  df$species_f <- factor(df$species)

  ggplot(df, aes(x = x, y = y, fill = species_f)) +
    geom_raster() +
    coord_equal() +
    labs(
      title = "Spatial Neutral Model (grid community map)",
      subtitle = paste0(
        "n = ", n, ", steps = ", steps, "\n",
        "m = ", m, ", \u03BD = ", nu
      ),
      x = "X", y = "Y", fill = "Species"
    ) +
    theme_minimal() +
    theme(
      legend.position = "none",
      plot.title = element_text(face = "bold"),
      plot.subtitle = element_text(size = 10)
    )
}
