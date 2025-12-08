# ============================================================================
# DATA LOADER MODULE - GCC Competitiveness Dashboard
# IMD World Competitiveness Ranking 2025
# ============================================================================

load_wcr_data <- function() {
  
  WCR_data <- list()
  
  # ==========================================================================
  # GDP WEIGHTS
  # ==========================================================================
  WCR_data$gdp_weights <- data.frame(
    Country = c("UAE", "Qatar", "Saudi Arabia", "Bahrain", "Oman", "Kuwait"),
    GDP_2024 = c(552.3, 219.2, 1085.4, 46.9, 109.7, 160.2),  # US$ billions
    stringsAsFactors = FALSE
  )
  
  # Calculate weight percentages
  total_gdp <- sum(WCR_data$gdp_weights$GDP_2024)
  WCR_data$gdp_weights$Weight_Pct <- round(WCR_data$gdp_weights$GDP_2024 / total_gdp * 100, 1)
  
  # ==========================================================================
  # OVERALL RANKINGS (2020-2025)
  # ==========================================================================
  base_rankings <- data.frame(
    Country = rep(c("UAE", "Saudi Arabia", "Qatar", "Bahrain", "Kuwait", "Oman"), each = 6),
    Year = rep(2020:2025, 6),
    Overall_Rank = c(
      9, 9, 12, 10, 7, 5,      # UAE
      24, 32, 24, 17, 16, 17,  # Saudi Arabia
      14, 17, 18, 12, 11, 9,   # Qatar
      NA, NA, 30, 25, 21, 22,  # Bahrain
      NA, NA, NA, 38, 37, 36,  # Kuwait
      NA, NA, NA, NA, NA, 28   # Oman
    ),
    stringsAsFactors = FALSE
  )
  
  # Calculate GCC aggregates for overall rankings
  gcc_overall_agg <- base_rankings %>%
    group_by(Year) %>%
    summarise(
      Overall_Rank = mean(Overall_Rank, na.rm = TRUE),
      N_Countries = sum(!is.na(Overall_Rank)),
      .groups = 'drop'
    ) %>%
    mutate(Country = "GCC Average")
  
  WCR_data$overall_rankings <- bind_rows(
    base_rankings %>% mutate(N_Countries = NA_integer_), 
    gcc_overall_agg
  ) %>%
    arrange(Year, Country)
  
  # ==========================================================================
  # MAIN FACTOR SCORES AND RANKINGS (2025)
  # ==========================================================================
  country_factors <- data.frame(
    Country = c("UAE", "Saudi Arabia", "Qatar", "Bahrain", "Kuwait", "Oman"),
    Year = 2025,
    Overall_Rank = c(5, 17, 9, 22, 36, 28),
    Overall_Score = c(96.09, 82.09, 89.93, 76.56, 68.69, 72.86),
    EconPerf_Rank = c(2, 17, 7, 18, 43, 48),
    EconPerf_Score = c(79.64, 62.29, 69.53, 61.10, 49.60, 48.63),
    GovEff_Rank = c(4, 17, 7, 28, 19, 16),
    GovEff_Score = c(87.28, 69.26, 82.88, 57.73, 67.26, 69.97),
    BusEff_Rank = c(3, 12, 5, 14, 31, 21),
    BusEff_Score = c(92.55, 81.40, 91.41, 78.13, 56.86, 65.72),
    Infra_Rank = c(23, 31, 30, 36, 43, 38),
    Infra_Score = c(69.00, 59.50, 60.00, 53.38, 45.14, 51.21),
    stringsAsFactors = FALSE
  )
  
  # Merge with GDP weights
  country_factors <- country_factors %>%
    left_join(WCR_data$gdp_weights, by = "Country")
  
  # Calculate GCC aggregates
  gcc_simple <- country_factors %>%
    summarise(
      Country = "GCC (Simple)",
      Year = 2025,
      Overall_Rank = mean(Overall_Rank),
      Overall_Score = mean(Overall_Score),
      EconPerf_Rank = mean(EconPerf_Rank),
      EconPerf_Score = mean(EconPerf_Score),
      GovEff_Rank = mean(GovEff_Rank),
      GovEff_Score = mean(GovEff_Score),
      BusEff_Rank = mean(BusEff_Rank),
      BusEff_Score = mean(BusEff_Score),
      Infra_Rank = mean(Infra_Rank),
      Infra_Score = mean(Infra_Score),
      GDP_2024 = sum(GDP_2024),
      Weight_Pct = 100
    )
  
  gcc_weighted <- country_factors %>%
    summarise(
      Country = "GCC (Weighted)",
      Year = 2025,
      Overall_Rank = weighted.mean(Overall_Rank, GDP_2024),
      Overall_Score = weighted.mean(Overall_Score, GDP_2024),
      EconPerf_Rank = weighted.mean(EconPerf_Rank, GDP_2024),
      EconPerf_Score = weighted.mean(EconPerf_Score, GDP_2024),
      GovEff_Rank = weighted.mean(GovEff_Rank, GDP_2024),
      GovEff_Score = weighted.mean(GovEff_Score, GDP_2024),
      BusEff_Rank = weighted.mean(BusEff_Rank, GDP_2024),
      BusEff_Score = weighted.mean(BusEff_Score, GDP_2024),
      Infra_Rank = weighted.mean(Infra_Rank, GDP_2024),
      Infra_Score = weighted.mean(Infra_Score, GDP_2024),
      GDP_2024 = sum(GDP_2024),
      Weight_Pct = 100
    )
  
  WCR_data$factors_2025 <- bind_rows(country_factors, gcc_simple, gcc_weighted)
  
  # ==========================================================================
  # SUB-FACTOR SCORES AND RANKINGS (2025)
  # ==========================================================================
  subfactor_list <- c(
    "Domestic Economy", "International Trade", "International Investment", "Employment", "Prices",
    "Public Finance", "Tax Policy", "Institutional Framework", "Business Legislation", "Societal Framework",
    "Productivity & Efficiency", "Labor Market", "Finance", "Management Practices", "Attitudes & Values",
    "Basic Infrastructure", "Technological Infrastructure", "Scientific Infrastructure", "Health & Environment", "Education"
  )
  
  factor_list <- c(
    rep("Economic Performance", 5),
    rep("Government Efficiency", 5),
    rep("Business Efficiency", 5),
    rep("Infrastructure", 5)
  )
  
  country_subfactors <- data.frame(
    Country = rep(c("UAE", "Saudi Arabia", "Qatar", "Bahrain", "Kuwait", "Oman"), each = 20),
    Factor = rep(factor_list, 6),
    Sub_Factor = rep(subfactor_list, 6),
    Score_2025 = c(
      # UAE
      62.3, 75.5, 55.2, 83.6, 57.9,
      78.5, 81.3, 65.6, 68.0, 61.2,
      80.7, 76.9, 69.0, 60.4, 81.3,
      68.9, 65.6, 52.8, 56.2, 63.2,
      # Saudi Arabia
      59.2, 56.0, 57.8, 55.6, 60.7,
      69.5, 67.6, 58.6, 67.6, 44.2,
      66.0, 64.2, 63.4, 64.0, 81.6,
      67.6, 59.5, 52.1, 47.5, 55.4,
      # Qatar
      61.8, 53.5, 47.4, 81.5, 64.0,
      71.9, 86.5, 64.9, 67.5, 52.2,
      70.0, 68.2, 65.4, 76.0, 85.7,
      69.4, 62.6, 42.8, 50.6, 57.9,
      # Bahrain
      52.1, 58.9, 53.3, 50.5, 71.3,
      33.7, 78.7, 48.8, 70.6, 45.6,
      67.6, 64.2, 54.0, 67.2, 77.6,
      59.2, 62.2, 36.2, 50.8, 57.6,
      # Kuwait
      31.1, 53.8, 50.4, 55.9, 64.9,
      72.2, 79.6, 50.4, 49.7, 50.4,
      54.0, 55.3, 56.4, 53.9, 55.6,
      52.0, 55.3, 38.3, 42.9, 56.1,
      # Oman
      44.1, 43.9, 46.1, 48.2, 71.3,
      74.3, 78.4, 51.4, 58.1, 47.2,
      51.8, 65.0, 52.5, 58.4, 70.6,
      66.5, 60.1, 43.1, 40.0, 50.7
    ),
    Rank_2025 = c(
      # UAE
      10, 2, 25, 1, 22,
      2, 3, 15, 12, 19,
      4, 1, 10, 24, 5,
      3, 12, 28, 33, 22,
      # Saudi Arabia
      25, 29, 16, 29, 19,
      13, 12, 27, 13, 55,
      15, 9, 19, 17, 3,
      7, 23, 29, 47, 39,
      # Qatar
      12, 38, 43, 2, 10,
      10, 2, 16, 14, 35,
      11, 2, 17, 5, 1,
      2, 16, 45, 42, 31,
      # Bahrain
      37, 17, 27, 45, 3,
      67, 5, 47, 9, 52,
      14, 11, 35, 14, 8,
      23, 14, 56, 40, 33,
      # Kuwait
      65, 35, 37, 27, 9,
      9, 4, 38, 44, 37,
      31, 31, 32, 35, 31,
      41, 35, 52, 52, 37,
      # Oman
      58, 61, 49, 51, 4,
      7, 6, 37, 29, 46,
      35, 5, 40, 28, 14,
      8, 22, 44, 55, 43
    ),
    stringsAsFactors = FALSE
  )
  
  # Add GDP weights to subfactors
  country_subfactors <- country_subfactors %>%
    left_join(WCR_data$gdp_weights, by = "Country")
  
  # Calculate GCC aggregates for subfactors
  gcc_subfactor_simple <- country_subfactors %>%
    group_by(Factor, Sub_Factor) %>%
    summarise(
      Country = "GCC (Simple)",
      Score_2025 = mean(Score_2025, na.rm = TRUE),
      Rank_2025 = mean(Rank_2025, na.rm = TRUE),
      .groups = 'drop'
    )
  
  gcc_subfactor_weighted <- country_subfactors %>%
    group_by(Factor, Sub_Factor) %>%
    summarise(
      Country = "GCC (Weighted)",
      Score_2025 = weighted.mean(Score_2025, GDP_2024, na.rm = TRUE),
      Rank_2025 = weighted.mean(Rank_2025, GDP_2024, na.rm = TRUE),
      .groups = 'drop'
    )
  
  WCR_data$subfactors_2025 <- bind_rows(
    country_subfactors %>% select(-GDP_2024, -Weight_Pct),
    gcc_subfactor_simple,
    gcc_subfactor_weighted
  ) %>%
    arrange(Country, Factor, Sub_Factor)
  
  # ==========================================================================
  # FIVE-YEAR FACTOR RANKINGS
  # ==========================================================================
  base_5yr <- data.frame(
    Country = rep(c("UAE", "Qatar", "Saudi Arabia", "Bahrain", "Oman", "Kuwait"), each = 5),
    Factor = rep(c("Overall", "Econ Perf", "Gov Eff", "Bus Eff", "Infra"), 6),
    Y2021 = c(9, 30, 3, 8, 28,
              17, 6, 6, 15, 40,
              32, 24, 26, 15, 36,
              NA, NA, NA, NA, NA,
              NA, NA, NA, NA, NA,
              NA, NA, NA, NA, NA),
    Y2022 = c(12, 15, 17, 6, 26,
              18, 7, 7, 14, 38,
              24, 19, 16, 9, 34,
              30, 39, 20, 24, 39,
              NA, NA, NA, NA, NA,
              NA, NA, NA, NA, NA),
    Y2023 = c(10, 36, 16, 4, 26,
              12, 4, 4, 12, 33,
              17, 11, 13, 6, 34,
              25, 23, 20, 22, 37,
              NA, NA, NA, NA, NA,
              38, 19, 42, 42, 49),
    Y2024 = c(7, 11, 10, 2, 25,
              11, 4, 4, 11, 33,
              16, 12, 12, 4, 34,
              21, 18, 21, 16, 39,
              NA, NA, NA, NA, NA,
              37, 31, 36, 36, 46),
    Y2025 = c(5, 2, 4, 3, 23,
              9, 7, 7, 5, 30,
              17, 17, 17, 12, 31,
              22, 18, 28, 14, 36,
              28, 48, 16, 21, 38,
              36, 43, 19, 31, 43),
    stringsAsFactors = FALSE
  )
  
  WCR_data$rankings_5yr <- base_5yr
  
  # ==========================================================================
  # WORLD RANKINGS 2025 (Top 40 + GCC countries)
  # ==========================================================================
  WCR_data$world_rankings_2025 <- data.frame(
    Rank = 1:40,
    Country = c("Switzerland", "Singapore", "Hong Kong SAR", "Denmark", "UAE",
                "Taiwan", "Ireland", "Sweden", "Qatar", "Netherlands",
                "Canada", "Norway", "USA", "Finland", "Iceland", "China", "Saudi Arabia",
                "Australia", "Germany", "Luxembourg", "Lithuania", "Bahrain", "Malaysia",
                "Belgium", "Czech Republic", "Austria", "Korea Rep.", "Oman", "United Kingdom",
                "Thailand", "New Zealand", "France", "Estonia", "Kazakhstan", "Japan",
                "Kuwait", "Portugal", "Latvia", "Spain", "Indonesia"),
    Score = c(100.00, 99.44, 99.22, 97.51, 96.09, 93.71, 91.31, 90.20, 89.93, 89.75,
              88.73, 86.17, 84.27, 83.83, 83.49, 82.13, 82.09, 78.36, 78.24, 78.17,
              77.68, 76.56, 74.81, 74.57, 73.66, 73.55, 73.39, 72.86, 71.95, 71.32,
              70.23, 69.93, 69.65, 68.99, 68.74, 68.69, 67.84, 67.03, 65.80, 64.32),
    stringsAsFactors = FALSE
  ) %>%
    mutate(
      Region = case_when(
        Country %in% c("UAE", "Qatar", "Saudi Arabia", "Bahrain", "Oman", "Kuwait") ~ "GCC Member",
        TRUE ~ "Other"
      )
    )
  
  # Add GCC aggregates to world rankings
  gcc_world_simple <- data.frame(
    Rank = NA,
    Country = "GCC (Simple)",
    Score = WCR_data$factors_2025$Overall_Score[WCR_data$factors_2025$Country == "GCC (Simple)"],
    Region = "GCC Aggregate"
  )
  
  gcc_world_weighted <- data.frame(
    Rank = NA,
    Country = "GCC (Weighted)",
    Score = WCR_data$factors_2025$Overall_Score[WCR_data$factors_2025$Country == "GCC (Weighted)"],
    Region = "GCC Aggregate"
  )
  
  WCR_data$world_rankings_with_gcc <- bind_rows(
    WCR_data$world_rankings_2025,
    gcc_world_simple,
    gcc_world_weighted
  ) %>%
    arrange(desc(Score)) %>%
    mutate(Rank = row_number())
  
  # ==========================================================================
  # METADATA
  # ==========================================================================
  WCR_data$metadata <- list(
    source = "IMD World Competitiveness Ranking",
    year = 2025,
    total_countries = 69,
    gcc_countries = c("UAE", "Qatar", "Saudi Arabia", "Bahrain", "Kuwait", "Oman"),
    dimensions = c("Economic Performance", "Government Efficiency", "Business Efficiency", "Infrastructure"),
    subfactors_count = 20,
    methodology = "The IMD World Competitiveness Ranking measures how economies manage their resources and competencies to increase their prosperity. The ranking is based on 256 criteria across four main factors.",
    data_updated = Sys.Date()
  )
  
  return(WCR_data)
}

# Color palette for GCC countries
gcc_colors <- c(
  "UAE" = "#000000",
  "Qatar" = "#99154C",
  "Saudi Arabia" = "#008035",
  "Bahrain" = "#E20000",
  "Oman" = "#a3a3a3",
  "Kuwait" = "#00B1E6",
  "GCC Average" = "#B8A358",
  "GCC (Simple)" = "#B8A358",
  "GCC (Weighted)" = "#D4A017"
)

# Dimension colors
dimension_colors <- c(
  "Overall" = "#1a5276",
  "Economic Performance" = "#2980b9",
  "Government Efficiency" = "#27ae60",
  "Business Efficiency" = "#8e44ad",
  "Infrastructure" = "#e67e22"
)
