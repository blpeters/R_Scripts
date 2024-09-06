library(grid)
library(tidyverse)
library(shadowtext)
library(forcats)
library(extrafont)


teams <- read_csv("data/top10WinPer_Forbes2023.csv")
teams <- teams %>% replace(is.na(.), 0)
teams <- mutate(teams, Win_percentage = Wins / (Wins + Losses + Ties))
teams$Win_percentage <- round((teams$Win_percentage * 100), digits = 1)
teams$Team <- factor(teams$Team, levels = c("Dallas Cowboys",
                                            "New York Yankees",
                                            "Golden State Warriors",
                                            "New England Patriots",
                                            "Los Angeles Rams",
                                            "New York Giants",
                                            "Chicago Bears",
                                            "Las Vegas Raiders",
                                            "New York Knicks",
                                            "New York Jets"))

# Set Team Colors
team_cols <- c("#869397", "#132448", "#fdb927", "#002244", "#b3995d", "#0b2265", "#c83803", "#000000", "#006bb6", "#003f2d")


ggplot(teams) +
  geom_col(aes(x = Team, y = Win_percentage, fill = Team), width = 1) +
  coord_flip(ylim = c(40,60)) +
  scale_x_discrete(limits = rev) +  # Put Top teams at top of page
  scale_y_continuous(position = "right") +
  scale_fill_manual(values = team_cols) +  # Use team colors from above
  theme(  # Adjust axis, labels, grid, etc.
    panel.background = element_rect(fill = "white"),
    panel.grid.major.x = element_line(color = "#A8BAC4", size = 0.3),
    legend.position = "none",
    axis.ticks.length = unit(0, "mm"),
    axis.title = element_blank(),
    axis.line.y.left = element_line(color = "black"),
    axis.text.y = element_blank(),
    axis.text.x = element_text(family="Agency FB", size=16)
  ) +
  geom_text(  # Label the bars
    data = teams,
    aes(x = Team, 0, label = Team),
    hjust = 0,
    nudge_y = 39.2,
    colour = "white",
    family = "Agency FB",
    size = 10
  ) +
  geom_text(
    aes(x = Team, y = Win_percentage, label = Win_percentage),
    nudge_y = .5,
    family = "Agency FB",
    size = 6
  ) +
  labs(  # Add Annotations
    title = "Top 10 Most Valuable Sports Franchises",
    subtitle = "By All-Time Win %"
  ) +
  theme(
    plot.title = element_text(
      family = "Agency FB", 
      face = "bold",
      size = 22
    ),
    plot.subtitle = element_text(
      family = "Agency FB",
      size = 20
    )
  )
    




