# Derrick Henry Hall of Fame Analysis

**Analysis Date:** January 11, 2026
**Author:** Alyssa Pybus

## Summary

This project analyzes whether Derrick Henry should and will be inducted into the NFL Hall of Fame based on his career statistics compared to historical Hall of Fame running backs.

## Key Findings

### Current Status (Through 2025 Season)

**Career Statistics:**
- **Seasons Played:** 10
- **Career Rushing Yards:** 14,020 yards (110.1% of HOF median) ✓ **EXCEEDS MEDIAN**
- **Career Rushing TDs:** 129 (141.8% of HOF median) ✓ **EXCEEDS MEDIAN**
- **Yards per Carry:** 4.90
- **Major Accolades:**
  - 2x NFL Rushing Champion (2019, 2020)
  - 1x 2,000-yard season (2,027 yards in 2020)

### The Verdict

| Question | Answer |
|----------|--------|
| **Should he make the Hall of Fame?** | **YES** - now exceeds HOF median benchmarks |
| **Will he make the Hall of Fame?** | **YES** - strong Hall of Fame case with current stats |
| **First ballot?** | Possible but not guaranteed - needs 1-2 more strong seasons |

### What He Needs for LOCK Status

Derrick Henry has **already exceeded the Hall of Fame median** for both rushing yards (14,020 vs 12,739) and touchdowns (129 vs 91). To become a **first-ballot lock**, he needs:

1. **1-2 more productive seasons** (1,000+ rushing yards each)
2. **Reach 15,000+ career rushing yards** (needs ~980 more)
3. **Another rushing title or MVP award** (currently has 2 rushing titles)
4. **Maintain elite yards-per-carry average** ✓ Currently at 4.90 YPC

### Career Projections

Three scenarios for Henry's career finish:

| Scenario | Additional Years | Total Yards | Total TDs | HOF Status |
|----------|-----------------|-------------|-----------|------------|
| **Conservative** | 2 years @ 900 yds/yr | 15,820 | 145 | ✓ Strong HOF case |
| **Moderate** | 2 years @ 1,200 yds/yr | 16,420 | 149 | ✓ Top 5 all-time |
| **Optimistic** | 3 years @ 1,300 yds/yr | 17,920 | 159 | ✓ Top 3 all-time |

**All realistic scenarios result in Hall of Fame-worthy totals.**

## Visualizations

### 1. Derrick Henry vs. Hall of Fame Running Backs

![Henry vs HOF RBs](plots/henry_vs_hof_yards.png)

This chart shows Derrick Henry's current career rushing yards compared to all modern-era Hall of Fame running backs. He's already in the top half and needs just 314 more yards to exceed the median.

### 2. Season-by-Season Progression

![Season Progression](plots/henry_season_progression.png)

Henry's career trajectory shows elite peak performance (2019-2020) with his 2,000-yard season in 2020. He's maintained 1,000+ yard production in recent seasons.

### 3. Career Projection Scenarios

![Projections](plots/henry_projections.png)

Even conservative projections show Henry finishing with Hall of Fame-caliber career totals, well above the median for both rushing yards and touchdowns.

## Key Strengths

✓ **2x NFL Rushing Champion** - Demonstrates elite peak performance
✓ **2,000-yard season** - Rare achievement (only 8 players in NFL history)
✓ **Physical dominance** - Changed how defenses game-plan
✓ **Elite efficiency** - 4.87 yards per carry is exceptional
✓ **Already exceeds HOF median for TDs** - 113 TDs (median: 91)

## Key Weaknesses

✗ **No MVP award** - Weakens resume compared to other HOF RBs
✗ **Limited receiving production** - One-dimensional offensive threat
✗ **Late career starter** - Limited opportunities early in career
✗ **Needs more accumulation** - Just short of median rushing yards
✗ **Fewer Pro Bowls** - Than typical first-ballot Hall of Famers

## Bottom Line

**Derrick Henry HAS NOW EXCEEDED the Hall of Fame benchmarks** for both rushing yards (110.1% of median) and touchdowns (141.8% of median). He has a **strong Hall of Fame case** with his current statistics.

His peak performance (2019-2020, 2024) was elite, and with 10 seasons of production, he has both the peak and longevity needed for enshrinement.

**Current Projection:** Hall of Famer. With 1-2 more productive seasons, he could become a **first-ballot** selection. He's already cemented his place among the all-time great running backs.

## Data Sources

- **NFL Statistics:** [nflreadr](https://nflreadr.nflverse.com/) package (2016-2025 seasons)
- **Hall of Fame Data:** Historical records for modern-era (post-1970) Hall of Fame running backs
  - Source: [Pro Football Reference](https://www.pro-football-reference.com/) and [NFL Hall of Fame](https://www.profootballhof.com/)
  - Data stored in: [scripts/hof_data.R](scripts/hof_data.R) for easy verification
  - All statistics cross-referenced across multiple sources

## Project Structure

```
Henry_HOF_Analysis/
├── README.md
├── LICENSE
├── scripts/
│   ├── henry_hof_analysis.R    # Main analysis script
│   └── hof_data.R              # Hall of Fame reference data (external)
├── output/
│   ├── henry_career_stats.csv
│   ├── henry_season_stats.csv
│   ├── hof_benchmarks.csv
│   ├── henry_hof_comparison.csv
│   └── henry_projections.csv
└── plots/
    ├── henry_vs_hof_yards.png
    ├── henry_season_progression.png
    └── henry_projections.png
```

## Reproducibility

To reproduce this analysis:

1. Install R and required packages: `nflreadr`, `dplyr`, `tidyr`, `ggplot2`, `scales`, `knitr`
2. Run the analysis script:
   ```r
   Rscript scripts/henry_hof_analysis.R
   ```
3. Results will be generated in `output/` and `plots/` directories

## License

MIT License - Copyright (c) 2026 Alyssa Pybus

---

*Analysis conducted using official NFL statistics through the 2025 season.*
