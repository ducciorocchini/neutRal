# Function to visualize the competition grid
plot_competition_grid <- function(grid, n, steps, m, nu) {
  # Convert the grid to a dataframe for visualization
  df <- expand.grid(x = 1:n, y = 1:n)
  df$species <- as.vector(grid)

  # Convert species IDs to a categorical factor for coloring
  df$species_f <- factor(df$species)

  ggplot(df, aes(x = x, y = y, fill = species_f)) +
    geom_raster() +
    coord_equal() +
    labs(
      title = "Species Competition Model (grid community map)",
      subtitle = paste0("n=", n, ", steps=", steps, ", m=", m, ", nu=", nu),
      x = "X", y = "Y", fill = "Species"
    ) +
    theme_minimal() +
    theme(
      legend.position = "none",
      plot.title = element_text(face = "bold")
    )
}
