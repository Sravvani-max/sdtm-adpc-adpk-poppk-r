source("R/load_packages.R")

library(ggplot2)

adpc <- read_csv("data/adam/adpc.csv")

pk_plot <- adpc %>%
  filter(!is.na(AVAL))

p <- ggplot(
  pk_plot,
  aes(
    x = ATPTN,
    y = AVAL,
    group = USUBJID,
    color = TRT01A
  )
) +
  geom_line(alpha = 0.7) +
  geom_point(size = 2) +
  labs(
    title = "Spaghetti Plot of Concentration-Time Profiles",
    x = "Nominal Time (Hours)",
    y = "Plasma Concentration (ng/mL)",
    color = "Treatment"
  ) +
  theme_minimal()

print(p)

ggsave(
  filename = "output/plots/spaghetti_plot.png",
  plot = p,
  width = 8,
  height = 5
)