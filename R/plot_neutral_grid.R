plot_neutral_grid <- function(grid, n, steps, m, nu) {

  df <- expand.grid(x = 1:n, y = 1:n)
  df$species <- as.vector(t(grid))
  df$species_f <- factor(df$species)

  ggplot(df, aes(x = x, y = y, fill = species_f)) +
    geom_raster() +
    coord_equal() +
    labs(
      title = "Spatial Neutral Model (grid community map)",
      subtitle = bquote(
        n == .(n) ~ "," ~ steps == .(steps) * "\n" *
        m == .(m) ~ "," ~ nu == .(nu)
      ),
      x = "X",
      y = "Y",
      fill = "Species"
    ) +
    theme_minimal() +
    theme(
      legend.position = "none",
      plot.title = element_text(face = "bold"),
      plot.subtitle = element_text(size = 10)
    )
}
