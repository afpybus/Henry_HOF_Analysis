# Derrick Henry Hall of Fame Analysis

**Analysis Date:** January 11, 2026
**Author:** Alyssa Pybus

## Summary

This project analyzes whether Derrick Henry should and will be inducted into the NFL Hall of Fame based on his career statistics compared to historical Hall of Fame running backs.

## Key Findings

### Current Status (Through 2024 Season)

**Career Statistics:**
- **Seasons Played:** 9
- **Career Rushing Yards:** 12,425 yards (97.5% of HOF median)
- **Career Rushing TDs:** 113 (124.2% of HOF median)
- **Yards per Carry:** 4.87
- **Major Accolades:**
  - 2x NFL Rushing Champion (2019, 2020)
  - 1x 2,000-yard season (2,027 yards in 2020)

### The Verdict

| Question | Answer |
|----------|--------|
| **Should he make the Hall of Fame?** | Not a lock yet - needs more accumulation |
| **Will he make the Hall of Fame?** | **YES**, trending toward HOF with 2+ productive years |
| **First ballot?** | Unlikely without MVP award or additional rushing titles |

### What He Needs for LOCK Status

Derrick Henry is **only 314 yards away from the Hall of Fame median** for rushing yards (12,739 yards). To become a Hall of Fame lock, he needs:

1. **2+ more seasons with 1,000+ rushing yards** each
2. **Reach 13,000+ career rushing yards** (needs ~575 more)
3. **Reach 100+ career rushing TDs** ✓ Already achieved (113 TDs)
4. **Maintain elite yards-per-carry average** ✓ Currently at 4.87 YPC

### Career Projections

Three scenarios for Henry's career finish:

| Scenario | Additional Years | Total Yards | Total TDs | HOF Status |
|----------|-----------------|-------------|-----------|------------|
| **Conservative** | 2 years @ 900 yds/yr | 14,225 | 129 | ✓ Exceeds median |
| **Moderate** | 2 years @ 1,200 yds/yr | 14,825 | 133 | ✓ Exceeds median |
| **Optimistic** | 3 years @ 1,300 yds/yr | 16,325 | 143 | ✓ Top 5 all-time |

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

**Derrick Henry is NOT a Hall of Fame lock yet**, but he's clearly trending in the right direction. With just **2-3 more productive seasons** (1,000+ yards), he will comfortably exceed the Hall of Fame benchmarks.

His peak performance (2019-2020) was HOF-caliber, but he needs more longevity and accumulation to secure his place.

**Current Projection:** EVENTUAL Hall of Famer, but likely **not first ballot** unless he wins MVP or another rushing title.

## Data Sources

- **NFL Statistics:** [nflreadr](https://nflreadr.nflverse.com/) package (2016-2024 seasons)
- **Hall of Fame Data:** Historical records for modern-era (post-1970) Hall of Fame running backs

## Project Structure

```
Henry_HOF_Analysis/
├── README.md
├── LICENSE
├── scripts/
│   └── henry_hof_analysis.R    # Main analysis script
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

*Analysis conducted using official NFL statistics through the 2024 season.*
