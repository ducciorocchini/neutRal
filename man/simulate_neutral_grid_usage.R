# Run the simulation for a grid of size 80x80 and 20000 steps
n <- 80
steps <- 20000
m <- 0.01     # Immigration probability
nu <- 0.001   # Speciation probability

plots <- simulate_neutral_grid(n = n, steps = steps, m = m, nu = nu, seed = 42)

# Check how many plots were generated
cat("Total plots generated:", length(plots), "\n")

# Display the plot for the last step (step 20000)
last_plot_index <- length(plots)  # The last index in the list corresponds to step 20000
print(plots[[last_plot_index]])
