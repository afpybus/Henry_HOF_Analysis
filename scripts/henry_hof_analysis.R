# ==============================================================================
# Derrick Henry Hall of Fame Analysis
# ==============================================================================
# Author: Alyssa Pybus
# Date: January 11, 2026
# Purpose: Analyze whether Derrick Henry should and will be inducted into the
#          NFL Hall of Fame based on career statistics and historical comparisons
# ==============================================================================

# Set CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org"))

# Load required packages
if (!require("pacman")) install.packages("pacman")
pacman::p_load(
  nflreadr,
  dplyr,
  tidyr,
  ggplot2,
  scales,
  knitr
)

# Configuration
OUTPUT_DIR <- "../output"
PLOTS_DIR <- "../plots"
CURRENT_SEASON <- 2025

# Create output directories if they don't exist
dir.create(OUTPUT_DIR, showWarnings = FALSE, recursive = TRUE)
dir.create(PLOTS_DIR, showWarnings = FALSE, recursive = TRUE)

cat("Starting Derrick Henry Hall of Fame Analysis...\n\n")

# ==============================================================================
# SECTION 1: Load Player Statistics
# ==============================================================================

cat("Loading NFL player statistics...\n")

# Load player stats for Henry's career
# IMPORTANT: Filter for regular season only (exclude playoffs) to match HOF benchmark standards
player_stats <- load_player_stats(seasons = 2016:CURRENT_SEASON) %>%
  filter(season_type == "REG")  # Regular season only - HOF stats are based on regular season

# ==============================================================================
# SECTION 2: Calculate Derrick Henry Career Statistics
# ==============================================================================

cat("Calculating Derrick Henry's career statistics...\n")

# Get Henry's career totals
henry_career <- player_stats %>%
  filter(player_display_name == "Derrick Henry") %>%
  summarize(
    player_name = "Derrick Henry",
    seasons_played = n_distinct(season),
    games_played = n(),
    rush_attempts = sum(carries, na.rm = TRUE),
    rush_yards = sum(rushing_yards, na.rm = TRUE),
    rush_tds = sum(rushing_tds, na.rm = TRUE),
    rush_yards_per_carry = rush_yards / rush_attempts,
    rush_yards_per_game = rush_yards / games_played,
    receptions = sum(receptions, na.rm = TRUE),
    rec_yards = sum(receiving_yards, na.rm = TRUE),
    rec_tds = sum(receiving_tds, na.rm = TRUE),
    total_yards = rush_yards + rec_yards,
    total_tds = rush_tds + rec_tds
  )

# Get season-by-season stats
henry_seasons <- player_stats %>%
  filter(player_display_name == "Derrick Henry") %>%
  group_by(season) %>%
  summarize(
    games = n(),
    rush_attempts = sum(carries, na.rm = TRUE),
    rush_yards = sum(rushing_yards, na.rm = TRUE),
    rush_tds = sum(rushing_tds, na.rm = TRUE),
    yards_per_carry = rush_yards / rush_attempts,
    yards_per_game = rush_yards / games
  ) %>%
  arrange(season)

cat("\n=== DERRICK HENRY CAREER STATISTICS ===\n")
print(as.data.frame(henry_career))
cat("\n")

# ==============================================================================
# SECTION 3: Hall of Fame Running Back Benchmarks
# ==============================================================================

cat("Loading Hall of Fame running back reference data...\n")

# Load external Hall of Fame data from separate file for easy verification
# This data is manually entered and kept separate for review purposes
source("hof_data.R")

# Calculate benchmarks
hof_benchmarks <- hof_rbs %>%
  summarize(
    min_rush_yards = min(rush_yards),
    median_rush_yards = median(rush_yards),
    mean_rush_yards = mean(rush_yards),
    min_rush_tds = min(rush_tds),
    median_rush_tds = median(rush_tds),
    mean_rush_tds = mean(rush_tds),
    median_seasons = median(seasons)
  )

cat("\n=== HALL OF FAME BENCHMARKS ===\n")
print(as.data.frame(hof_benchmarks))
cat("\n")

# ==============================================================================
# SECTION 4: Compare Henry to HOF Standards
# ==============================================================================

cat("Comparing Henry to Hall of Fame standards...\n")

henry_comparison <- data.frame(
  metric = c("Career Rush Yards", "Career Rush TDs", "Seasons Played"),
  henry_current = c(
    henry_career$rush_yards,
    henry_career$rush_tds,
    henry_career$seasons_played
  ),
  hof_median = c(
    hof_benchmarks$median_rush_yards,
    hof_benchmarks$median_rush_tds,
    hof_benchmarks$median_seasons
  )
) %>%
  mutate(
    gap = hof_median - henry_current,
    pct_of_median = round((henry_current / hof_median) * 100, 1)
  )

cat("\n=== HENRY VS. HOF BENCHMARKS ===\n")
print(as.data.frame(henry_comparison))
cat("\n")

# ==============================================================================
# SECTION 5: Project Career Finish
# ==============================================================================

cat("Projecting Derrick Henry's career trajectory...\n")

projections <- data.frame(
  scenario = c(
    "Conservative (2 yrs, 900 yds/yr)",
    "Moderate (2 yrs, 1200 yds/yr)",
    "Optimistic (3 yrs, 1300 yds/yr)"
  ),
  years_added = c(2, 2, 3),
  yards_per_year = c(900, 1200, 1300),
  tds_per_year = c(8, 10, 10)
) %>%
  mutate(
    projected_total_yards = henry_career$rush_yards + (years_added * yards_per_year),
    projected_total_tds = henry_career$rush_tds + (years_added * tds_per_year),
    final_seasons = henry_career$seasons_played + years_added,
    exceeds_median_yards = projected_total_yards >= hof_benchmarks$median_rush_yards,
    exceeds_median_tds = projected_total_tds >= hof_benchmarks$median_rush_tds
  )

cat("\n=== CAREER PROJECTION SCENARIOS ===\n")
print(as.data.frame(projections))
cat("\n")

# ==============================================================================
# SECTION 6: Generate Visualizations
# ==============================================================================

cat("Generating visualizations...\n")

# Plot 1: Henry vs HOF RBs - Career Rushing Yards
plot_data <- hof_rbs %>%
  bind_rows(data.frame(
    player_name = "Derrick Henry*",
    rush_yards = henry_career$rush_yards,
    rush_tds = henry_career$rush_tds,
    seasons = henry_career$seasons_played,
    rush_titles = 2,
    first_ballot = NA
  )) %>%
  arrange(desc(rush_yards)) %>%
  mutate(
    player_name = factor(player_name, levels = rev(player_name)),
    is_henry = grepl("Henry", player_name)
  )

p1 <- ggplot(plot_data, aes(x = player_name, y = rush_yards, fill = is_henry)) +
  geom_col() +
  geom_hline(yintercept = hof_benchmarks$median_rush_yards,
             linetype = "dashed", color = "red", linewidth = 1) +
  annotate("text", x = 3, y = hof_benchmarks$median_rush_yards + 800,
           label = paste("HOF Median:", format(hof_benchmarks$median_rush_yards, big.mark = ",")),
           color = "red", size = 4) +
  scale_fill_manual(values = c("gray60", "#0066CC"), guide = "none") +
  scale_y_continuous(labels = comma, expand = expansion(mult = c(0, 0.1))) +
  coord_flip() +
  labs(
    title = "Derrick Henry vs. Hall of Fame Running Backs",
    subtitle = "Career Rushing Yards Comparison (* = Active Player)",
    x = NULL,
    y = "Career Rushing Yards"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0),
    plot.subtitle = element_text(size = 11, hjust = 0),
    plot.margin = margin(10, 20, 10, 10),
    axis.text.y = element_text(size = 10)
  )

ggsave(file.path(PLOTS_DIR, "henry_vs_hof_yards.png"), p1,
       width = 12, height = 10, dpi = 300, bg = "white")

# Plot 2: Season progression
p2 <- ggplot(henry_seasons, aes(x = season, y = rush_yards)) +
  geom_line(linewidth = 1.5, color = "#0066CC") +
  geom_point(size = 4, color = "#0066CC") +
  geom_hline(yintercept = 1000, linetype = "dashed", color = "gray50", linewidth = 0.8) +
  geom_hline(yintercept = 1500, linetype = "dashed", color = "orange", linewidth = 0.8) +
  geom_hline(yintercept = 2000, linetype = "dashed", color = "red", linewidth = 0.8) +
  annotate("text", x = 2016.3, y = 1050, label = "1,000 yards", color = "gray50", hjust = 0, size = 3.5) +
  annotate("text", x = 2016.3, y = 1550, label = "1,500 yards", color = "orange", hjust = 0, size = 3.5) +
  annotate("text", x = 2016.3, y = 2050, label = "2,000 yards", color = "red", hjust = 0, size = 3.5) +
  scale_y_continuous(labels = comma, limits = c(0, NA), expand = expansion(mult = c(0, 0.1))) +
  scale_x_continuous(breaks = 2016:2024) +
  labs(
    title = "Derrick Henry Season-by-Season Rushing Performance",
    subtitle = "2016-2024 NFL Seasons",
    x = "Season",
    y = "Rushing Yards"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    plot.subtitle = element_text(size = 11),
    plot.margin = margin(10, 20, 10, 10),
    panel.grid.minor = element_blank()
  )

ggsave(file.path(PLOTS_DIR, "henry_season_progression.png"), p2,
       width = 12, height = 7, dpi = 300, bg = "white")

# Plot 3: Projections
proj_plot_data <- projections %>%
  select(scenario, projected_total_yards, projected_total_tds) %>%
  pivot_longer(cols = c(projected_total_yards, projected_total_tds),
               names_to = "metric", values_to = "value") %>%
  mutate(
    metric_label = ifelse(metric == "projected_total_yards", "Rushing Yards", "Rushing TDs"),
    scenario = factor(scenario, levels = unique(scenario))
  )

p3 <- ggplot(proj_plot_data, aes(x = scenario, y = value, fill = scenario)) +
  geom_col(show.legend = TRUE) +
  geom_hline(data = data.frame(
    metric_label = c("Rushing Yards", "Rushing TDs"),
    threshold = c(hof_benchmarks$median_rush_yards, hof_benchmarks$median_rush_tds)
  ), aes(yintercept = threshold), linetype = "dashed", color = "red", linewidth = 1) +
  geom_text(data = data.frame(
    metric_label = c("Rushing Yards", "Rushing TDs"),
    threshold = c(hof_benchmarks$median_rush_yards, hof_benchmarks$median_rush_tds),
    label = c(paste("HOF Median:", format(hof_benchmarks$median_rush_yards, big.mark = ",")),
              paste("HOF Median:", hof_benchmarks$median_rush_tds))
  ), aes(x = 2, y = threshold + ifelse(metric_label == "Rushing Yards", 800, 5),
         label = label), color = "red", size = 3.5, inherit.aes = FALSE) +
  facet_wrap(~metric_label, scales = "free_y") +
  scale_fill_manual(values = c("#66C2A5", "#FC8D62", "#8DA0CB")) +
  scale_y_continuous(labels = comma, expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "Derrick Henry Career Projection Scenarios",
    subtitle = "Projected career totals compared to HOF median",
    x = NULL,
    y = "Career Total",
    fill = "Scenario"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    plot.subtitle = element_text(size = 11),
    plot.margin = margin(10, 20, 10, 10),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    legend.position = "bottom"
  )

ggsave(file.path(PLOTS_DIR, "henry_projections.png"), p3,
       width = 12, height = 7, dpi = 300, bg = "white")

# Plot 4: Hall of Fame Probability Over Time by Team
cat("Generating Hall of Fame probability timeline...\n")

# Get team info for each season
henry_team_progression <- player_stats %>%
  filter(player_display_name == "Derrick Henry") %>%
  group_by(season, team) %>%
  summarize(
    rush_yards = sum(rushing_yards, na.rm = TRUE),
    rush_tds = sum(rushing_tds, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(season) %>%
  mutate(
    # Calculate cumulative stats
    cumulative_yards = cumsum(rush_yards),
    cumulative_tds = cumsum(rush_tds),
    seasons_played = row_number(),

    # Calculate HOF probability based on proximity to benchmarks
    # Using a simple model:
    # - If >= median yards AND median TDs: 80-100% based on additional factors
    # - If close to median: 50-80%
    # - If below: 0-50% based on distance
    yards_pct = cumulative_yards / hof_benchmarks$median_rush_yards * 100,
    tds_pct = cumulative_tds / hof_benchmarks$median_rush_tds * 100,

    # Probability calculation (simplified model)
    base_prob = pmin(100, (yards_pct + tds_pct) / 2),

    # Adjust for rushing titles (Henry won in 2019 and 2020)
    title_bonus = case_when(
      season >= 2020 ~ 10,  # After 2 rushing titles
      season == 2019 ~ 5,   # After 1 rushing title
      TRUE ~ 0
    ),

    # Final probability estimate
    hof_probability = pmin(100, pmax(0, base_prob + title_bonus)),

    # Clean team names
    team_name = case_when(
      team == "TEN" ~ "Tennessee Titans",
      team == "BAL" ~ "Baltimore Ravens",
      TRUE ~ team
    )
  )

# Create the probability timeline plot
# First, get coordinates for connecting segment between Titans and Ravens
titans_last <- henry_team_progression %>% filter(team_name == "Tennessee Titans") %>% slice_tail(n = 1)
ravens_first <- henry_team_progression %>% filter(team_name == "Baltimore Ravens") %>% slice_head(n = 1)

p4 <- ggplot(henry_team_progression, aes(x = season, y = hof_probability, color = team_name)) +
  geom_line(linewidth = 2) +
  annotate("segment",
           x = titans_last$season, y = titans_last$hof_probability,
           xend = ravens_first$season, yend = ravens_first$hof_probability,
           color = "#4B92DB", linewidth = 2) +
  geom_point(size = 4) +
  geom_hline(yintercept = 50, linetype = "dashed", color = "gray50", linewidth = 0.8) +
  geom_hline(yintercept = 80, linetype = "dashed", color = "darkgreen", linewidth = 0.8) +
  annotate("text", x = 2016.5, y = 53, label = "50% - Possible HOFer",
           color = "gray50", hjust = 0, size = 3.5) +
  annotate("text", x = 2016.5, y = 83, label = "80% - Likely HOFer",
           color = "darkgreen", hjust = 0, size = 3.5) +
  scale_color_manual(
    values = c("Tennessee Titans" = "#4B92DB", "Baltimore Ravens" = "#241773"),
    name = "Team"
  ) +
  scale_y_continuous(limits = c(0, 100), breaks = seq(0, 100, 20),
                     labels = function(x) paste0(x, "%")) +
  scale_x_continuous(breaks = 2016:2025) +
  labs(
    title = "Derrick Henry's Hall of Fame Probability Over Time",
    subtitle = "Estimated probability based on cumulative statistics and accolades",
    x = "Season",
    y = "Hall of Fame Probability",
    caption = "Probability model based on rushing yards, TDs, and rushing titles relative to HOF benchmarks"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    plot.subtitle = element_text(size = 11),
    plot.caption = element_text(size = 9, color = "gray40", hjust = 0),
    plot.margin = margin(10, 20, 10, 10),
    panel.grid.minor = element_blank(),
    legend.position = "bottom",
    legend.title = element_text(face = "bold")
  )

ggsave(file.path(PLOTS_DIR, "henry_hof_probability.png"), p4,
       width = 12, height = 7, dpi = 300, bg = "white")

# Export the probability data
write.csv(henry_team_progression %>%
            select(season, team_name, cumulative_yards, cumulative_tds, hof_probability),
          file.path(OUTPUT_DIR, "henry_hof_probability_timeline.csv"), row.names = FALSE)

# ==============================================================================
# SECTION 7: Export Results
# ==============================================================================

cat("Exporting results...\n")

write.csv(henry_career, file.path(OUTPUT_DIR, "henry_career_stats.csv"), row.names = FALSE)
write.csv(henry_seasons, file.path(OUTPUT_DIR, "henry_season_stats.csv"), row.names = FALSE)
write.csv(hof_benchmarks, file.path(OUTPUT_DIR, "hof_benchmarks.csv"), row.names = FALSE)
write.csv(henry_comparison, file.path(OUTPUT_DIR, "henry_hof_comparison.csv"), row.names = FALSE)
write.csv(projections, file.path(OUTPUT_DIR, "henry_projections.csv"), row.names = FALSE)

# ==============================================================================
# SECTION 8: Final Summary Report
# ==============================================================================

cat("\n")
cat("================================================================================\n")
cat("                    DERRICK HENRY HALL OF FAME ANALYSIS\n")
cat("                           Final Summary Report\n")
cat("================================================================================\n\n")

cat("CURRENT CAREER STATISTICS:\n")
cat(sprintf("  Seasons Played: %d\n", henry_career$seasons_played))
cat(sprintf("  Career Rushing Yards: %s\n", format(henry_career$rush_yards, big.mark = ",")))
cat(sprintf("  Career Rushing TDs: %d\n", henry_career$rush_tds))
cat(sprintf("  Yards per Carry: %.2f\n", henry_career$rush_yards_per_carry))
cat(sprintf("  Rushing Titles: 2 (2019, 2020)\n\n"))

cat("HALL OF FAME COMPARISON:\n")
cat(sprintf("  Current yards: %s (%.1f%% of HOF median)\n",
    format(henry_career$rush_yards, big.mark = ","),
    (henry_career$rush_yards / hof_benchmarks$median_rush_yards) * 100))
cat(sprintf("  Needs for median: ~%s more yards\n",
    format(max(0, hof_benchmarks$median_rush_yards - henry_career$rush_yards), big.mark = ",")))
cat(sprintf("  Current TDs: %d (%.1f%% of HOF median)\n\n",
    henry_career$rush_tds,
    (henry_career$rush_tds / hof_benchmarks$median_rush_tds) * 100))

cat("FINAL VERDICT:\n")
cat("  SHOULD HE MAKE IT?: Not a lock yet - needs more accumulation\n")
cat("  WILL HE MAKE IT?: Trending YES with 2+ productive years\n")
cat("  FIRST BALLOT?: Unlikely without MVP or more rushing titles\n\n")

cat("WHAT HE NEEDS FOR LOCK STATUS:\n")
cat("  - 2+ more seasons with 1,000+ rushing yards\n")
cat("  - Reach 13,000+ career rushing yards\n")
cat("  - Reach 100+ career rushing TDs\n")
cat("  - Maintain elite yards-per-carry average\n\n")

cat("KEY STRENGTHS:\n")
cat("  + 2x NFL rushing champion (2019, 2020)\n")
cat("  + 2,000-yard season in 2020\n")
cat("  + Physical dominance and game-changing ability\n")
cat("  + Elite yards per carry\n\n")

cat("KEY WEAKNESSES:\n")
cat("  - No MVP award\n")
cat("  - Limited receiving production\n")
cat("  - Needs more career accumulation\n")
cat("  - Late career starter (limited early usage)\n\n")

cat("================================================================================\n")
cat("Analysis complete! Check output/ and plots/ directories for detailed results.\n")
cat("================================================================================\n")
