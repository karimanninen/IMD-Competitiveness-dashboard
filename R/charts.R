# ============================================================================
# CHARTS.R - All Chart Functions for GCC Competitiveness Dashboard
# ============================================================================

library(plotly)
library(dplyr)
library(tidyr)
library(scales)

# Country color palette
country_colors <- c(
  "UAE" = "#000000",
  "Qatar" = "#99154C",
  "Saudi Arabia" = "#008035",
  "Bahrain" = "#E20000",
  "Kuwait" = "#00B1E6",
  "Oman" = "#a3a3a3",
  "GCC Average" = "#B8A358",
  "GCC (Weighted)" = "#e41a1c",
  "GCC (Simple)" = "#377eb8"
)

# ============================================================================
# 1. WORLD RANKING CHART
# ============================================================================
create_world_ranking_chart <- function(data, gcc_method = "GCC (Weighted)", n_countries = 30) {
  
  world_data <- data$world_rankings_with_gcc %>%
    filter(Rank <= n_countries | grepl("GCC", Country))
  
  # Determine colors
  world_data <- world_data %>%
    mutate(
      Color = case_when(
        Country == gcc_method ~ "#e41a1c",
        Country %in% c("UAE", "Qatar", "Saudi Arabia", "Bahrain", "Kuwait", "Oman") ~ "#377eb8",
        TRUE ~ "#999999"
      ),
      Label = paste0(Country, " (", round(Score, 1), ")")
    )
  
  plot_ly(
    data = world_data,
    x = ~reorder(Country, -Score),
    y = ~Score,
    type = "bar",
    marker = list(color = ~Color),
    text = ~round(Score, 1),
    textposition = "outside",
    hoverinfo = "text",
    hovertext = ~paste0(Country, "<br>Score: ", round(Score, 1), "<br>Rank: ", Rank)
  ) %>%
    layout(
      title = list(
        text = "GCC as a Unified Entity: World Ranking Position",
        font = list(size = 16)
      ),
      xaxis = list(
        title = "",
        tickangle = -45,
        tickfont = list(size = 10)
      ),
      yaxis = list(
        title = "Competitiveness Score",
        range = c(0, 105)
      ),
      showlegend = FALSE,
      margin = list(b = 120)
    )
}

# ============================================================================
# 2. TRAJECTORY CHART (5-Year Trends)
# ============================================================================
create_trajectory_chart <- function(data, highlight = "All") {
  
  # Get overall rankings over time
  trend_data <- data$rankings_5yr %>%
    filter(Factor == "Overall") %>%
    select(Country, Y2021, Y2022, Y2023, Y2024, Y2025) %>%
    pivot_longer(cols = starts_with("Y"), names_to = "Year", values_to = "Rank") %>%
    mutate(Year = as.numeric(gsub("Y", "", Year))) %>%
    filter(!is.na(Rank))
  
  # Determine which countries to show
  if (!("All" %in% highlight) && length(highlight) > 0) {
    trend_data <- trend_data %>%
      mutate(
        Show = Country %in% highlight,
        Alpha = if_else(Show, 1, 0.2),
        Width = if_else(Show, 3, 1)
      )
  } else {
    trend_data <- trend_data %>%
      mutate(Show = TRUE, Alpha = 1, Width = 2)
  }
  
  # Create plot
  p <- plot_ly()
  
  for (ctry in unique(trend_data$Country)) {
    ctry_data <- trend_data %>% filter(Country == ctry)
    color <- if (ctry %in% names(country_colors)) country_colors[ctry] else "#999999"
    alpha <- ctry_data$Alpha[1]
    width <- ctry_data$Width[1]
    
    p <- p %>%
      add_trace(
        data = ctry_data,
        x = ~Year,
        y = ~Rank,
        type = "scatter",
        mode = "lines+markers",
        name = ctry,
        line = list(color = color, width = width),
        marker = list(color = color, size = 8),
        opacity = alpha,
        hoverinfo = "text",
        hovertext = ~paste0(Country, "<br>Year: ", Year, "<br>Rank: ", Rank)
      )
  }
  
  p %>%
    layout(
      title = list(
        text = "GCC Competitiveness Journey: From 2021 to 2025",
        font = list(size = 16)
      ),
      xaxis = list(
        title = "Year",
        tickvals = 2021:2025
      ),
      yaxis = list(
        title = "Global Rank (lower is better)",
        autorange = "reversed",
        range = c(45, 0)
      ),
      legend = list(
        orientation = "h",
        y = -0.2
      ),
      hovermode = "closest"
    )
}

# ============================================================================
# 3. COMPARISON CHART (Simple vs GDP-Weighted)
# ============================================================================
create_comparison_chart <- function(data) {
  
  comparison_data <- data$factors_2025 %>%
    filter(Country %in% c("GCC (Simple)", "GCC (Weighted)")) %>%
    select(Country, Overall_Score, EconPerf_Score, GovEff_Score, BusEff_Score, Infra_Score) %>%
    pivot_longer(cols = -Country, names_to = "Dimension", values_to = "Score") %>%
    mutate(
      Dimension = case_when(
        Dimension == "Overall_Score" ~ "Overall",
        Dimension == "EconPerf_Score" ~ "Economic\nPerformance",
        Dimension == "GovEff_Score" ~ "Government\nEfficiency",
        Dimension == "BusEff_Score" ~ "Business\nEfficiency",
        Dimension == "Infra_Score" ~ "Infrastructure"
      ),
      Dimension = factor(Dimension, levels = c("Overall", "Economic\nPerformance", 
                                                "Government\nEfficiency", "Business\nEfficiency", 
                                                "Infrastructure"))
    )
  
  plot_ly(
    data = comparison_data,
    x = ~Dimension,
    y = ~Score,
    color = ~Country,
    colors = c("GCC (Simple)" = "#377eb8", "GCC (Weighted)" = "#e41a1c"),
    type = "bar",
    text = ~round(Score, 1),
    textposition = "outside",
    hoverinfo = "text",
    hovertext = ~paste0(Country, "<br>", Dimension, ": ", round(Score, 1))
  ) %>%
    layout(
      title = list(text = "Simple Average vs GDP-Weighted", font = list(size = 14)),
      xaxis = list(title = ""),
      yaxis = list(title = "Score", range = c(0, 100)),
      barmode = "group",
      legend = list(orientation = "h", y = -0.15)
    )
}

# ============================================================================
# 4. GDP PIE CHART
# ============================================================================
create_gdp_pie_chart <- function(data) {
  
  gdp_data <- data$gdp_weights %>%
    mutate(
      Color = country_colors[Country],
      Label = paste0(Country, "\n$", round(GDP_2024, 0), "B")
    )
  
  plot_ly(
    data = gdp_data,
    labels = ~Country,
    values = ~GDP_2024,
    type = "pie",
    textinfo = "label+percent",
    textposition = "inside",
    marker = list(colors = ~Color),
    hoverinfo = "text",
    hovertext = ~paste0(Country, "<br>GDP: $", round(GDP_2024, 1), "B<br>Weight: ", round(Weight_Pct, 1), "%")
  ) %>%
    layout(
      title = list(text = "GDP Distribution (2024)", font = list(size = 14)),
      showlegend = FALSE
    )
}

# ============================================================================
# 5. DIMENSIONS CHART (Bar chart with scores and ranks)
# ============================================================================
create_dimensions_chart <- function(data, gcc_method = "GCC (Weighted)") {
  
  dim_data <- data$factors_2025 %>%
    filter(Country == gcc_method) %>%
    select(EconPerf_Score, EconPerf_Rank, GovEff_Score, GovEff_Rank, 
           BusEff_Score, BusEff_Rank, Infra_Score, Infra_Rank) %>%
    pivot_longer(cols = everything(), names_to = "Metric", values_to = "Value") %>%
    mutate(
      Dimension = case_when(
        grepl("EconPerf", Metric) ~ "Economic Performance",
        grepl("GovEff", Metric) ~ "Government Efficiency",
        grepl("BusEff", Metric) ~ "Business Efficiency",
        grepl("Infra", Metric) ~ "Infrastructure"
      ),
      Type = if_else(grepl("Score", Metric), "Score", "Rank")
    ) %>%
    pivot_wider(names_from = Type, values_from = Value)
  
  # Color based on score
  dim_data <- dim_data %>%
    mutate(
      Color = case_when(
        Score >= 80 ~ "#27ae60",
        Score >= 70 ~ "#2ecc71",
        Score >= 60 ~ "#f39c12",
        TRUE ~ "#e74c3c"
      )
    )
  
  plot_ly(
    data = dim_data,
    x = ~Dimension,
    y = ~Score,
    type = "bar",
    marker = list(color = ~Color),
    text = ~paste0(round(Score, 1), "\n(Rank: ", round(Rank), ")"),
    textposition = "outside",
    hoverinfo = "text",
    hovertext = ~paste0(Dimension, "<br>Score: ", round(Score, 1), "<br>Rank: ", round(Rank))
  ) %>%
    layout(
      title = list(text = "GCC Performance by Dimension", font = list(size = 14)),
      xaxis = list(title = ""),
      yaxis = list(title = "Score", range = c(0, 100)),
      showlegend = FALSE
    )
}

# ============================================================================
# 6. COUNTRY RADAR CHART
# ============================================================================
create_country_radar <- function(data, country) {
  
  country_data <- data$factors_2025 %>%
    filter(Country == country) %>%
    select(EconPerf_Score, GovEff_Score, BusEff_Score, Infra_Score)
  
  # Prepare for radar
  values <- as.numeric(unlist(country_data[1, ]))
  categories <- c("Economic Performance", "Government Efficiency", 
                  "Business Efficiency", "Infrastructure")
  
  # Close the polygon by repeating first value
  values <- c(values, values[1])
  categories <- c(categories, categories[1])
  
  # FIX: Use [[ ]] to get just the color value, not a named vector
  color <- if (country %in% names(country_colors)) {
    as.character(country_colors[[country]])
  } else {
    "#1a5276"
  }
  
  plot_ly(
    type = "scatterpolar",
    r = values,
    theta = categories,
    fill = "toself",
    fillcolor = paste0(color, "40"),
    line = list(color = color, width = 2),
    marker = list(color = color, size = 8),
    name = country,
    hoverinfo = "text",
    hovertext = paste0(categories[-length(categories)], ": ", round(values[-length(values)], 1))
  ) %>%
    layout(
      polar = list(
        radialaxis = list(
          visible = TRUE,
          range = c(0, 100),
          tickvals = seq(0, 100, 25)
        ),
        angularaxis = list(
          tickfont = list(size = 11)
        )
      ),
      showlegend = FALSE,
      title = list(text = paste(country, "- Factor Profile"), font = list(size = 14))
    )
}


# ============================================================================
# 7. COUNTRY TREND CHART (5-year by factor)
# ============================================================================
create_country_trend <- function(data, country) {
  
  trend_data <- data$rankings_5yr %>%
    filter(Country == country) %>%
    select(Factor, Y2021, Y2022, Y2023, Y2024, Y2025) %>%
    pivot_longer(cols = starts_with("Y"), names_to = "Year", values_to = "Rank") %>%
    mutate(Year = as.numeric(gsub("Y", "", Year))) %>%
    filter(!is.na(Rank))
  
  factor_colors <- c(
    "Overall" = "#1a5276",
    "Econ Perf" = "#2980b9",
    "Gov Eff" = "#27ae60",
    "Bus Eff" = "#8e44ad",
    "Infra" = "#e67e22"
  )
  
  plot_ly(
    data = trend_data,
    x = ~Year,
    y = ~Rank,
    color = ~Factor,
    colors = factor_colors,
    type = "scatter",
    mode = "lines+markers",
    hoverinfo = "text",
    hovertext = ~paste0(Factor, "<br>Year: ", Year, "<br>Rank: ", Rank)
  ) %>%
    layout(
      title = list(text = paste(country, "- Factor Rankings Over Time"), font = list(size = 14)),
      xaxis = list(title = "Year", tickvals = 2021:2025),
      yaxis = list(title = "Rank (lower is better)", autorange = "reversed"),
      legend = list(orientation = "h", y = -0.2),
      hovermode = "closest"
    )
}

# ============================================================================
# 8. SUBFACTOR CHART
# ============================================================================
create_subfactor_chart <- function(data, country, factor_filter = "All") {
  
  subfactor_data <- data$subfactors_2025 %>%
    filter(Country == country)
  
  if (factor_filter != "All") {
    subfactor_data <- subfactor_data %>%
      filter(Factor == factor_filter)
  }
  
  # Color by factor
  factor_colors <- c(
    "Economic Performance" = "#2980b9",
    "Government Efficiency" = "#27ae60",
    "Business Efficiency" = "#8e44ad",
    "Infrastructure" = "#e67e22"
  )
  
  subfactor_data <- subfactor_data %>%
    mutate(Color = factor_colors[Factor])
  
  plot_ly(
    data = subfactor_data,
    x = ~reorder(Sub_Factor, Score_2025),
    y = ~Score_2025,
    type = "bar",
    marker = list(color = ~Color),
    text = ~round(Score_2025, 1),
    textposition = "outside",
    hoverinfo = "text",
    hovertext = ~paste0(Sub_Factor, "<br>Factor: ", Factor, "<br>Score: ", round(Score_2025, 1), "<br>Rank: ", Rank_2025)
  ) %>%
    layout(
      title = list(text = paste(country, "- Sub-Factor Scores"), font = list(size = 14)),
      xaxis = list(title = "", tickangle = -45),
      yaxis = list(title = "Score", range = c(0, 100)),
      showlegend = FALSE,
      margin = list(b = 150)
    ) %>%
    layout(xaxis = list(categoryorder = "total ascending"))
}

# ============================================================================
# 9. HEATMAP CHART
# ============================================================================
create_heatmap_chart <- function(data) {
  
  heatmap_data <- data$factors_2025 %>%
    filter(!grepl("GCC", Country)) %>%
    select(Country, Overall_Score, EconPerf_Score, GovEff_Score, BusEff_Score, Infra_Score) %>%
    pivot_longer(cols = -Country, names_to = "Dimension", values_to = "Score") %>%
    mutate(
      Dimension = case_when(
        Dimension == "Overall_Score" ~ "Overall",
        Dimension == "EconPerf_Score" ~ "Econ Perf",
        Dimension == "GovEff_Score" ~ "Gov Eff",
        Dimension == "BusEff_Score" ~ "Bus Eff",
        Dimension == "Infra_Score" ~ "Infrastructure"
      ),
      Dimension = factor(Dimension, levels = c("Overall", "Econ Perf", "Gov Eff", "Bus Eff", "Infrastructure")),
      Country = factor(Country, levels = c("UAE", "Qatar", "Saudi Arabia", "Bahrain", "Oman", "Kuwait"))
    )
  
  plot_ly(
    data = heatmap_data,
    x = ~Dimension,
    y = ~Country,
    z = ~Score,
    type = "heatmap",
    colorscale = list(c(0, "#d73027"), c(0.5, "#fee08b"), c(1, "#1a9850")),
    zmin = 40,
    zmax = 100,
    text = ~round(Score, 1),
    texttemplate = "%{text}",
    hoverinfo = "text",
    hovertext = ~paste0(Country, "<br>", Dimension, ": ", round(Score, 1))
  ) %>%
    layout(
      title = list(text = "GCC Countries: Competitiveness Heatmap", font = list(size = 14)),
      xaxis = list(title = ""),
      yaxis = list(title = "", autorange = "reversed")
    )
}

# ============================================================================
# 10. GAP CHART
# ============================================================================
create_gap_chart <- function(data, gcc_method = "GCC (Weighted)") {
  
  gap_data <- data$factors_2025 %>%
    filter(Country == gcc_method) %>%
    select(Overall_Score, EconPerf_Score, GovEff_Score, BusEff_Score, Infra_Score) %>%
    pivot_longer(cols = everything(), names_to = "Dimension", values_to = "Score") %>%
    mutate(
      Gap = 100 - Score,
      Dimension = case_when(
        Dimension == "Overall_Score" ~ "Overall",
        Dimension == "EconPerf_Score" ~ "Economic Performance",
        Dimension == "GovEff_Score" ~ "Government Efficiency",
        Dimension == "BusEff_Score" ~ "Business Efficiency",
        Dimension == "Infra_Score" ~ "Infrastructure"
      ),
      Dimension = factor(Dimension, levels = c("Infrastructure", "Economic Performance", 
                                                "Government Efficiency", "Business Efficiency", "Overall"))
    )
  
  plot_ly(data = gap_data) %>%
    add_bars(
      y = ~Dimension,
      x = ~Score,
      name = "Achieved",
      marker = list(color = "#1a5276"),
      orientation = "h",
      text = ~paste0(round(Score, 1), "%"),
      textposition = "inside",
      hoverinfo = "text",
      hovertext = ~paste0(Dimension, "<br>Score: ", round(Score, 1))
    ) %>%
    add_bars(
      y = ~Dimension,
      x = ~Gap,
      name = "Gap to 100",
      marker = list(color = "#d3d3d3"),
      orientation = "h",
      text = ~paste0(round(Gap, 1), "%"),
      textposition = "inside",
      hoverinfo = "text",
      hovertext = ~paste0(Dimension, "<br>Gap: ", round(Gap, 1))
    ) %>%
    layout(
      title = list(text = "GCC Performance Gap Analysis", font = list(size = 14)),
      xaxis = list(title = "Percentage", range = c(0, 100)),
      yaxis = list(title = ""),
      barmode = "stack",
      legend = list(orientation = "h", y = -0.15)
    )
}

# ============================================================================
# 11. OVERLAY RADAR CHART (Country vs GCC)
# ============================================================================
create_overlay_radar_chart <- function(data, selected_country, gcc_method = "GCC (Weighted)") {
  
  # Get country data
  country_data <- data$factors_2025 %>%
    filter(Country == selected_country) %>%
    select(EconPerf_Score, GovEff_Score, BusEff_Score, Infra_Score)
  
  # Get GCC data
  gcc_data <- data$factors_2025 %>%
    filter(Country == gcc_method) %>%
    select(EconPerf_Score, GovEff_Score, BusEff_Score, Infra_Score)
  
  categories <- c("Economic Performance", "Government Efficiency", 
                  "Business Efficiency", "Infrastructure", "Economic Performance")
  
  country_values <- c(as.numeric(unlist(country_data[1, ])), as.numeric(unlist(country_data[1, 1])))
  gcc_values <- c(as.numeric(unlist(gcc_data[1, ])), as.numeric(unlist(gcc_data[1, 1])))
  
  # FIX: Use [[ ]] to get just the color value
  country_color <- if (selected_country %in% names(country_colors)) {
    as.character(country_colors[[selected_country]])
  } else {
    "#1a5276"
  }
  
  plot_ly(type = "scatterpolar") %>%
    add_trace(
      r = gcc_values,
      theta = categories,
      fill = "toself",
      fillcolor = "rgba(184, 163, 88, 0.2)",
      line = list(color = "#B8A358", width = 2, dash = "dash"),
      name = gcc_method
    ) %>%
    add_trace(
      r = country_values,
      theta = categories,
      fill = "toself",
      fillcolor = paste0(country_color, "40"),
      line = list(color = country_color, width = 2),
      name = selected_country
    ) %>%
    layout(
      polar = list(
        radialaxis = list(visible = TRUE, range = c(0, 100))
      ),
      legend = list(orientation = "h", y = -0.1),
      title = list(text = paste(selected_country, "vs", gcc_method), font = list(size = 14))
    )
}