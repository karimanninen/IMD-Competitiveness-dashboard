# ============================================================================
# CHARTS MODULE - GCC Competitiveness Dashboard
# IMD World Competitiveness Ranking 2025
# ============================================================================

# ==========================================================================
# CHART 1: World Ranking Position
# ==========================================================================
create_world_ranking_chart <- function(data, gcc_method = "GCC (Weighted)", n_countries = 30) {
  
  world_data <- data$world_rankings_with_gcc %>%
    filter(Rank <= n_countries | grepl("GCC", Country) | Region == "GCC Member")
  
  # Set colors based on region
  world_data <- world_data %>%
    mutate(
      Color = case_when(
        Country == gcc_method ~ "#e41a1c",
        Country %in% c("GCC (Simple)", "GCC (Weighted)") & Country != gcc_method ~ "#999999",
        Region == "GCC Member" ~ "#377eb8",
        TRUE ~ "#999999"
      ),
      Alpha = case_when(
        Country == gcc_method ~ 1,
        Region == "GCC Member" ~ 0.8,
        TRUE ~ 0.5
      )
    )
  
  plot_ly(
    data = world_data,
    x = ~reorder(Country, -Score),
    y = ~Score,
    type = "bar",
    marker = list(color = ~Color),
    text = ~paste0(Country, "<br>Rank: #", Rank, "<br>Score: ", round(Score, 1)),
    hoverinfo = "text"
  ) %>%
    layout(
      title = list(
        text = "<b>GCC as a Unified Entity: World Ranking Position</b><br><sup>If GCC were a single country, where would it rank globally?</sup>",
        x = 0
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

# ==========================================================================
# CHART 2: Country Trajectory (5-year trend)
# ==========================================================================
create_trajectory_chart <- function(data, highlight = "All") {
  
  # Define colors locally to avoid scope issues
  country_colors <- c(
    "UAE" = "#000000",
    "Qatar" = "#99154C",
    "Saudi Arabia" = "#008035",
    "Bahrain" = "#E20000",
    "Oman" = "#a3a3a3",
    "Kuwait" = "#00B1E6",
    "GCC Average" = "#B8A358"
  )
  
  rankings <- data$overall_rankings %>%
    filter(Year >= 2021) %>%
    filter(!is.na(Overall_Rank))
  
  # Determine if we should highlight specific countries
  # Handle cases where highlight is NULL, empty, or "All"
  if (is.null(highlight)) {
    highlight_countries <- unique(rankings$Country)
  } else if (length(highlight) == 0) {
    highlight_countries <- unique(rankings$Country)
  } else if (length(highlight) == 1 && highlight[1] == "All") {
    highlight_countries <- unique(rankings$Country)
  } else {
    highlight_countries <- highlight
  }
  
  p <- plot_ly()
  
  for (country in unique(rankings$Country)) {
    country_data <- rankings %>% filter(Country == country)
    
    # Get color for this country
    if (country %in% names(country_colors)) {
      color <- country_colors[[country]]
    } else {
      color <- "#888888"
    }
    
    # Set opacity and line width based on whether country is highlighted
    if (country %in% highlight_countries) {
      alpha <- 1
      lw <- 3
    } else {
      alpha <- 0.2
      lw <- 1
    }
    
    p <- p %>%
      add_trace(
        data = country_data,
        x = ~Year,
        y = ~Overall_Rank,
        type = "scatter",
        mode = "lines+markers",
        name = country,
        line = list(color = color, width = lw),
        marker = list(color = color, size = 8),
        opacity = alpha,
        text = ~paste0(Country, " (", Year, ")<br>Rank: #", round(Overall_Rank, 1)),
        hoverinfo = "text"
      )
  }
  
  p %>%
    layout(
      title = list(
        text = "<b>GCC Competitiveness Journey: 2021-2025</b><br><sup>Tracking each country's ranking trajectory in the global arena</sup>",
        x = 0
      ),
      xaxis = list(
        title = "Year",
        tickmode = "linear",
        dtick = 1
      ),
      yaxis = list(
        title = "Global Rank (Lower is Better)",
        autorange = "reversed",
        range = c(45, 0)
      ),
      legend = list(
        orientation = "h",
        y = -0.2
      ),
      shapes = list(
        list(type = "rect", x0 = 2020.5, x1 = 2025.5, y0 = 0, y1 = 10,
             fillcolor = "#27ae60", opacity = 0.1, line = list(width = 0)),
        list(type = "rect", x0 = 2020.5, x1 = 2025.5, y0 = 10, y1 = 20,
             fillcolor = "#f39c12", opacity = 0.1, line = list(width = 0))
      )
    )
}

# ==========================================================================
# CHART 3: Dimensions Comparison (Bar Chart)
# ==========================================================================
create_dimensions_chart <- function(data, gcc_method = "GCC (Weighted)") {
  
  gcc_data <- data$factors_2025 %>%
    filter(Country == gcc_method) %>%
    select(ends_with("_Score"), ends_with("_Rank")) %>%
    pivot_longer(
      cols = everything(),
      names_to = c("Dimension", ".value"),
      names_pattern = "(.+)_(Score|Rank)"
    ) %>%
    mutate(
      Dimension = case_when(
        Dimension == "Overall" ~ "Overall",
        Dimension == "EconPerf" ~ "Economic Performance",
        Dimension == "GovEff" ~ "Government Efficiency",
        Dimension == "BusEff" ~ "Business Efficiency",
        Dimension == "Infra" ~ "Infrastructure"
      ),
      Performance = case_when(
        Score >= 80 ~ "Strong",
        Score >= 65 ~ "Good",
        TRUE ~ "Moderate"
      ),
      Color = case_when(
        Performance == "Strong" ~ "#27ae60",
        Performance == "Good" ~ "#f39c12",
        TRUE ~ "#e67e22"
      )
    )
  
  plot_ly(
    data = gcc_data,
    x = ~Dimension,
    y = ~Score,
    type = "bar",
    marker = list(color = ~Color),
    text = ~paste0("Score: ", round(Score, 1), "<br>Rank: #", round(Rank, 0)),
    hoverinfo = "text+name"
  ) %>%
    add_trace(
      y = ~Rank,
      type = "scatter",
      mode = "markers+text",
      yaxis = "y2",
      marker = list(color = "#c0392b", size = 12, symbol = "diamond"),
      text = ~paste0("#", round(Rank, 0)),
      textposition = "top center",
      name = "Rank"
    ) %>%
    layout(
      title = list(
        text = paste0("<b>GCC GDP-Weighted Competitiveness Performance</b><br><sup>Scores and Average Rankings across Five Dimensions (69 countries ranked)</sup>"),
        x = 0
      ),
      xaxis = list(title = ""),
      yaxis = list(
        title = "Score (0-100)",
        range = c(0, 100)
      ),
      yaxis2 = list(
        title = "Average Rank (lower is better)",
        overlaying = "y",
        side = "right",
        range = c(50, 0)
      ),
      showlegend = FALSE,
      barmode = "group"
    )
}

# ==========================================================================
# CHART 4: Country Heatmap
# ==========================================================================
create_heatmap_chart <- function(data) {
  
  heatmap_data <- data$factors_2025 %>%
    filter(!grepl("GCC", Country)) %>%
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
      Country = factor(Country, levels = c("UAE", "Qatar", "Saudi Arabia", "Bahrain", "Oman", "Kuwait"))
    )
  
  plot_ly(
    data = heatmap_data,
    x = ~Dimension,
    y = ~Country,
    z = ~Score,
    type = "heatmap",
    colorscale = list(
      c(0, "#d73027"),
      c(0.4, "#fee08b"),
      c(0.6, "#d9ef8b"),
      c(1, "#1a9850")
    ),
    zmin = 40,
    zmax = 100,
    text = ~round(Score, 1),
    texttemplate = "%{text}",
    hoverinfo = "text",
    hovertext = ~paste0(Country, "<br>", Dimension, "<br>Score: ", round(Score, 1))
  ) %>%
    layout(
      title = list(
        text = "<b>GCC Countries: Competitiveness Heatmap 2025</b><br><sup>Color intensity shows relative performance</sup>",
        x = 0
      ),
      xaxis = list(title = ""),
      yaxis = list(title = "", autorange = "reversed")
    )
}

# ==========================================================================
# CHART 5: Gap Analysis
# ==========================================================================
create_gap_chart <- function(data, gcc_method = "GCC (Weighted)") {
  
  gcc_data <- data$factors_2025 %>%
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
      )
    )
  
  plot_ly(data = gcc_data) %>%
    add_trace(
      y = ~Dimension,
      x = ~Score,
      type = "bar",
      orientation = "h",
      name = "Achieved",
      marker = list(color = "#2980b9"),
      text = ~paste0(round(Score, 1), "%"),
      textposition = "inside",
      hoverinfo = "text",
      hovertext = ~paste0(Dimension, "<br>Score: ", round(Score, 1))
    ) %>%
    add_trace(
      y = ~Dimension,
      x = ~Gap,
      type = "bar",
      orientation = "h",
      name = "Gap to 100",
      marker = list(color = "#bdc3c7"),
      text = ~paste0(round(Gap, 1), "%"),
      textposition = "inside",
      hoverinfo = "text",
      hovertext = ~paste0(Dimension, "<br>Gap: ", round(Gap, 1))
    ) %>%
    layout(
      title = list(
        text = "<b>GCC Performance Gap Analysis</b><br><sup>Achieved scores vs. potential improvement to perfect score (100)</sup>",
        x = 0
      ),
      xaxis = list(
        title = "Percentage",
        range = c(0, 100)
      ),
      yaxis = list(title = ""),
      barmode = "stack",
      legend = list(orientation = "h", y = -0.15)
    )
}

# ==========================================================================
# CHART 6: Radar Comparison
# ==========================================================================
create_radar_chart <- function(data, selected_country = "UAE", gcc_method = "GCC (Weighted)") {
  
  radar_data <- data$factors_2025 %>%
    filter(Country %in% c(selected_country, gcc_method)) %>%
    select(Country, EconPerf_Score, GovEff_Score, BusEff_Score, Infra_Score) %>%
    pivot_longer(cols = -Country, names_to = "Dimension", values_to = "Score") %>%
    mutate(
      Dimension = case_when(
        Dimension == "EconPerf_Score" ~ "Economic Performance",
        Dimension == "GovEff_Score" ~ "Government Efficiency",
        Dimension == "BusEff_Score" ~ "Business Efficiency",
        Dimension == "Infra_Score" ~ "Infrastructure"
      )
    )
  
  # Create radar chart using polar coordinates
  p <- plot_ly(type = "scatterpolar", mode = "lines+markers")
  
  for (country in unique(radar_data$Country)) {
    country_data <- radar_data %>% 
      filter(Country == country) %>%
      bind_rows(radar_data %>% filter(Country == country) %>% slice(1))
    
    color <- if(country %in% names(gcc_colors)) gcc_colors[country] else "#888888"
    
    p <- p %>%
      add_trace(
        r = c(country_data$Score, country_data$Score[1]),
        theta = c(country_data$Dimension, country_data$Dimension[1]),
        name = country,
        fill = "toself",
        fillcolor = paste0(color, "33"),
        line = list(color = color, width = 2),
        marker = list(color = color, size = 8)
      )
  }
  
  p %>%
    layout(
      title = list(
        text = paste0("<b>", selected_country, " vs ", gcc_method, "</b><br><sup>Dimension comparison</sup>"),
        x = 0.5
      ),
      polar = list(
        radialaxis = list(
          visible = TRUE,
          range = c(0, 100)
        )
      ),
      legend = list(orientation = "h", y = -0.1)
    )
}

# ==========================================================================
# CHART 7: Sub-factor Breakdown
# ==========================================================================
create_subfactor_chart <- function(data, selected_country = "UAE", selected_factor = "All") {
  
  subfactor_data <- data$subfactors_2025 %>%
    filter(Country == selected_country)
  
  if (selected_factor != "All") {
    subfactor_data <- subfactor_data %>% filter(Factor == selected_factor)
  }
  
  subfactor_data <- subfactor_data %>%
    mutate(
      Color = case_when(
        Score_2025 >= 75 ~ "#27ae60",
        Score_2025 >= 60 ~ "#f39c12",
        Score_2025 >= 50 ~ "#e67e22",
        TRUE ~ "#c0392b"
      )
    )
  
  plot_ly(
    data = subfactor_data,
    y = ~reorder(Sub_Factor, Score_2025),
    x = ~Score_2025,
    type = "bar",
    orientation = "h",
    marker = list(color = ~Color),
    text = ~paste0(round(Score_2025, 1), " (Rank #", Rank_2025, ")"),
    textposition = "outside",
    hoverinfo = "text",
    hovertext = ~paste0(Sub_Factor, "<br>Factor: ", Factor, "<br>Score: ", round(Score_2025, 1), "<br>Rank: #", Rank_2025)
  ) %>%
    layout(
      title = list(
        text = paste0("<b>", selected_country, ": Sub-Factor Performance 2025</b>"),
        x = 0
      ),
      xaxis = list(
        title = "Score (0-100)",
        range = c(0, 100)
      ),
      yaxis = list(title = ""),
      margin = list(l = 180)
    )
}

# ==========================================================================
# CHART 8: 5-Year Factor Trend
# ==========================================================================
create_factor_trend_chart <- function(data, selected_country = "UAE") {
  
  trend_data <- data$rankings_5yr %>%
    filter(Country == selected_country) %>%
    pivot_longer(
      cols = starts_with("Y"),
      names_to = "Year",
      values_to = "Rank"
    ) %>%
    mutate(
      Year = as.numeric(gsub("Y", "", Year)),
      Factor = factor(Factor, levels = c("Overall", "Econ Perf", "Gov Eff", "Bus Eff", "Infra"))
    ) %>%
    filter(!is.na(Rank))
  
  plot_ly(
    data = trend_data,
    x = ~Year,
    y = ~Rank,
    color = ~Factor,
    colors = c("#1a5276", "#2980b9", "#27ae60", "#8e44ad", "#e67e22"),
    type = "scatter",
    mode = "lines+markers",
    text = ~paste0(Factor, " (", Year, ")<br>Rank: #", Rank),
    hoverinfo = "text"
  ) %>%
    layout(
      title = list(
        text = paste0("<b>", selected_country, ": 5-Year Factor Rankings</b><br><sup>Performance trend across all dimensions</sup>"),
        x = 0
      ),
      xaxis = list(
        title = "Year",
        tickmode = "linear",
        dtick = 1
      ),
      yaxis = list(
        title = "Rank (Lower is Better)",
        autorange = "reversed"
      ),
      legend = list(orientation = "h", y = -0.2)
    )
}

# ==========================================================================
# CHART 9: Simple vs Weighted Comparison
# ==========================================================================
create_method_comparison_chart <- function(data) {
  
  comparison_data <- data$factors_2025 %>%
    filter(Country %in% c("GCC (Simple)", "GCC (Weighted)")) %>%
    select(Country, Overall_Score, EconPerf_Score, GovEff_Score, BusEff_Score, Infra_Score) %>%
    pivot_longer(cols = -Country, names_to = "Dimension", values_to = "Score") %>%
    mutate(
      Method = gsub("GCC \\(|\\)", "", Country),
      Dimension = case_when(
        Dimension == "Overall_Score" ~ "Overall",
        Dimension == "EconPerf_Score" ~ "Economic\nPerformance",
        Dimension == "GovEff_Score" ~ "Government\nEfficiency",
        Dimension == "BusEff_Score" ~ "Business\nEfficiency",
        Dimension == "Infra_Score" ~ "Infrastructure"
      )
    )
  
  plot_ly(
    data = comparison_data,
    x = ~Dimension,
    y = ~Score,
    color = ~Method,
    colors = c("#377eb8", "#e41a1c"),
    type = "bar",
    text = ~round(Score, 1),
    textposition = "outside",
    hoverinfo = "text+name",
    hovertext = ~paste0(Dimension, "<br>Score: ", round(Score, 1))
  ) %>%
    layout(
      title = list(
        text = "<b>GCC Aggregation Methods Comparison</b><br><sup>Simple Average vs GDP-Weighted Average</sup>",
        x = 0
      ),
      xaxis = list(title = ""),
      yaxis = list(
        title = "Score (0-100)",
        range = c(0, 105)
      ),
      barmode = "group",
      legend = list(orientation = "h", y = -0.15)
    )
}

# ==========================================================================
# CHART 10: GDP Weights Pie Chart
# ==========================================================================
create_gdp_weights_chart <- function(data) {
  
  gdp_data <- data$gdp_weights %>%
    mutate(
      Label = paste0(Country, "\n$", round(GDP_2024, 0), "B\n(", Weight_Pct, "%)")
    )
  
  plot_ly(
    data = gdp_data,
    labels = ~Country,
    values = ~GDP_2024,
    type = "pie",
    marker = list(
      colors = c(gcc_colors["UAE"], gcc_colors["Qatar"], gcc_colors["Saudi Arabia"],
                 gcc_colors["Bahrain"], gcc_colors["Oman"], gcc_colors["Kuwait"])
    ),
    textinfo = "label+percent",
    textposition = "inside",
    hoverinfo = "text",
    hovertext = ~paste0(Country, "<br>GDP: $", round(GDP_2024, 1), " billion<br>Weight: ", Weight_Pct, "%")
  ) %>%
    layout(
      title = list(
        text = "<b>GCC GDP Distribution 2024</b><br><sup>Used for weighted aggregation</sup>",
        x = 0.5
      ),
      showlegend = TRUE,
      legend = list(orientation = "h", y = -0.1)
    )
}
