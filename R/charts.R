# ============================================================================
# CHARTS.R - All Chart Functions for GCC Competitiveness Dashboard
# BILINGUAL VERSION (English / Arabic)
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
create_world_ranking_chart <- function(data, gcc_method = "GCC (Weighted)", n_countries = 30, lang = "en") {

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
      Country_Display = translate_countries(Country, lang),
      Label = paste0(Country_Display, " (", round(Score, 1), ")")
    )

  plot_ly(
    data = world_data,
    x = ~reorder(Country_Display, -Score),
    y = ~Score,
    type = "bar",
    marker = list(color = ~Color),
    text = ~round(Score, 1),
    textposition = "outside",
    hoverinfo = "text",
    hovertext = ~paste0(Country_Display, "<br>", t("score", lang), ": ", round(Score, 1), "<br>", t("rank", lang), ": ", Rank)
  ) %>%
    layout(
      title = list(
        text = t("chart_world_title", lang),
        font = list(size = 16, family = get_font(lang))
      ),
      xaxis = list(
        title = "",
        tickangle = -45,
        tickfont = list(size = 10, family = get_font(lang))
      ),
      yaxis = list(
        title = t("competitiveness_score", lang),
        range = c(0, 105),
        titlefont = list(family = get_font(lang))
      ),
      showlegend = FALSE,
      margin = list(b = 120),
      font = list(family = get_font(lang))
    )
}

# ============================================================================
# 2. TRAJECTORY CHART (5-Year Trends)
# ============================================================================
create_trajectory_chart <- function(data, highlight = "All", lang = "en") {

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
    ctry_display <- translate_country(ctry, lang)

    p <- p %>%
      add_trace(
        data = ctry_data,
        x = ~Year,
        y = ~Rank,
        type = "scatter",
        mode = "lines+markers",
        name = ctry_display,
        line = list(color = color, width = width),
        marker = list(color = color, size = 8),
        opacity = alpha,
        hoverinfo = "text",
        hovertext = ~paste0(ctry_display, "<br>", t("year", lang), ": ", Year, "<br>", t("rank", lang), ": ", Rank)
      )
  }

  p %>%
    layout(
      title = list(
        text = t("chart_trajectory_title", lang),
        font = list(size = 16, family = get_font(lang))
      ),
      xaxis = list(
        title = t("year", lang),
        tickvals = 2021:2025,
        titlefont = list(family = get_font(lang))
      ),
      yaxis = list(
        title = t("global_rank", lang),
        autorange = "reversed",
        range = c(45, 0),
        titlefont = list(family = get_font(lang))
      ),
      legend = list(
        orientation = "h",
        y = -0.2,
        font = list(family = get_font(lang))
      ),
      hovermode = "closest",
      font = list(family = get_font(lang))
    )
}

# ============================================================================
# 3. COMPARISON CHART (Simple vs GDP-Weighted)
# ============================================================================
create_comparison_chart <- function(data, lang = "en") {

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
                                                "Infrastructure")),
      Dimension_Display = translate_dimensions(Dimension, lang),
      Country_Display = translate_countries(Country, lang)
    )

  # Create named color vector with translated names
  color_map <- c()
  color_map[translate_country("GCC (Simple)", lang)] <- "#377eb8"
  color_map[translate_country("GCC (Weighted)", lang)] <- "#e41a1c"

  plot_ly(
    data = comparison_data,
    x = ~Dimension_Display,
    y = ~Score,
    color = ~Country_Display,
    colors = color_map,
    type = "bar",
    text = ~round(Score, 1),
    textposition = "outside",
    hoverinfo = "text",
    hovertext = ~paste0(Country_Display, "<br>", Dimension_Display, ": ", round(Score, 1))
  ) %>%
    layout(
      title = list(text = t("chart_simple_vs_gdp", lang), font = list(size = 14, family = get_font(lang))),
      xaxis = list(title = "", tickfont = list(family = get_font(lang))),
      yaxis = list(title = t("score", lang), range = c(0, 100), titlefont = list(family = get_font(lang))),
      barmode = "group",
      legend = list(orientation = "h", y = -0.15, font = list(family = get_font(lang))),
      font = list(family = get_font(lang))
    )
}

# ============================================================================
# 4. GDP PIE CHART
# ============================================================================
create_gdp_pie_chart <- function(data, lang = "en") {

  gdp_data <- data$gdp_weights %>%
    mutate(
      Color = country_colors[Country],
      Country_Display = translate_countries(Country, lang),
      Label = paste0(Country_Display, "\n$", round(GDP_2024, 0), "B")
    )

  plot_ly(
    data = gdp_data,
    labels = ~Country_Display,
    values = ~GDP_2024,
    type = "pie",
    textinfo = "label+percent",
    textposition = "inside",
    marker = list(colors = ~Color),
    hoverinfo = "text",
    hovertext = ~paste0(Country_Display, "<br>GDP: $", round(GDP_2024, 1), "B<br>", t("col_weight_pct", lang), ": ", round(Weight_Pct, 1), "%")
  ) %>%
    layout(
      title = list(text = t("chart_gdp_distribution", lang), font = list(size = 14, family = get_font(lang))),
      showlegend = FALSE,
      font = list(family = get_font(lang))
    )
}

# ============================================================================
# 5. DIMENSIONS CHART (Bar chart with scores and ranks)
# ============================================================================
create_dimensions_chart <- function(data, gcc_method = "GCC (Weighted)", lang = "en") {

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
    pivot_wider(names_from = Type, values_from = Value) %>%
    mutate(
      Dimension_Display = translate_dimensions(Dimension, lang),
      Color = case_when(
        Score >= 80 ~ "#27ae60",
        Score >= 70 ~ "#2ecc71",
        Score >= 60 ~ "#f39c12",
        TRUE ~ "#e74c3c"
      )
    )

  plot_ly(
    data = dim_data,
    x = ~Dimension_Display,
    y = ~Score,
    type = "bar",
    marker = list(color = ~Color),
    text = ~paste0(round(Score, 1), "\n(", t("rank", lang), ": ", round(Rank), ")"),
    textposition = "outside",
    hoverinfo = "text",
    hovertext = ~paste0(Dimension_Display, "<br>", t("score", lang), ": ", round(Score, 1), "<br>", t("rank", lang), ": ", round(Rank))
  ) %>%
    layout(
      title = list(text = t("chart_performance_by_dim", lang), font = list(size = 14, family = get_font(lang))),
      xaxis = list(title = "", tickfont = list(family = get_font(lang))),
      yaxis = list(title = t("score", lang), range = c(0, 100), titlefont = list(family = get_font(lang))),
      showlegend = FALSE,
      font = list(family = get_font(lang))
    )
}

# ============================================================================
# 6. COUNTRY RADAR CHART
# ============================================================================
create_country_radar <- function(data, country, lang = "en") {

  country_data <- data$factors_2025 %>%
    filter(Country == country) %>%
    select(EconPerf_Score, GovEff_Score, BusEff_Score, Infra_Score)

  # Prepare for radar
  values <- as.numeric(unlist(country_data[1, ]))
  categories <- c("Economic Performance", "Government Efficiency",
                  "Business Efficiency", "Infrastructure")
  categories_display <- translate_dimensions(categories, lang)

  # Create hovertext BEFORE closing the polygon
  hover_text <- paste0(categories_display, ": ", round(values, 1))

  # Close the polygon by repeating first value
  values <- c(values, values[1])
  categories_display <- c(categories_display, categories_display[1])
  hover_text <- c(hover_text, hover_text[1])

  # Get color
  color <- if (country %in% names(country_colors)) {
    as.character(country_colors[[country]])
  } else {
    "#1a5276"
  }

  country_display <- translate_country(country, lang)

  plot_ly(
    type = "scatterpolar",
    mode = "lines+markers",
    r = values,
    theta = categories_display,
    fill = "toself",
    fillcolor = paste0(color, "40"),
    line = list(color = color, width = 2),
    marker = list(color = color, size = 8),
    name = country_display,
    hoverinfo = "text",
    hovertext = hover_text
  ) %>%
    layout(
      polar = list(
        radialaxis = list(
          visible = TRUE,
          range = c(0, 100),
          tickvals = seq(0, 100, 25)
        ),
        angularaxis = list(
          tickfont = list(size = 11, family = get_font(lang))
        )
      ),
      showlegend = FALSE,
      title = list(
        text = paste(country_display, "-", t("chart_factor_profile", lang)),
        font = list(size = 14, family = get_font(lang))
      ),
      font = list(family = get_font(lang))
    )
}

# ============================================================================
# 7. COUNTRY TREND CHART (5-year by factor)
# ============================================================================
create_country_trend <- function(data, country, lang = "en") {

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

  country_display <- translate_country(country, lang)

  plot_ly(
    data = trend_data,
    x = ~Year,
    y = ~Rank,
    color = ~Factor,
    colors = factor_colors,
    type = "scatter",
    mode = "lines+markers",
    hoverinfo = "text",
    hovertext = ~paste0(Factor, "<br>", t("year", lang), ": ", Year, "<br>", t("rank", lang), ": ", Rank)
  ) %>%
    layout(
      title = list(
        text = paste(country_display, "-", t("chart_factor_rankings", lang)),
        font = list(size = 14, family = get_font(lang))
      ),
      xaxis = list(title = t("year", lang), tickvals = 2021:2025, titlefont = list(family = get_font(lang))),
      yaxis = list(title = t("chart_rank_lower_better", lang), autorange = "reversed", titlefont = list(family = get_font(lang))),
      legend = list(orientation = "h", y = -0.2, font = list(family = get_font(lang))),
      hovermode = "closest",
      font = list(family = get_font(lang))
    )
}

# ============================================================================
# 8. SUBFACTOR CHART
# ============================================================================
create_subfactor_chart <- function(data, country, factor_filter = "All", lang = "en") {

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

  country_display <- translate_country(country, lang)

  plot_ly(
    data = subfactor_data,
    x = ~reorder(Sub_Factor, Score_2025),
    y = ~Score_2025,
    type = "bar",
    marker = list(color = ~Color),
    text = ~round(Score_2025, 1),
    textposition = "outside",
    hoverinfo = "text",
    hovertext = ~paste0(Sub_Factor, "<br>", t("col_factor", lang), ": ", Factor, "<br>", t("score", lang), ": ", round(Score_2025, 1), "<br>", t("rank", lang), ": ", Rank_2025)
  ) %>%
    layout(
      title = list(
        text = paste(country_display, "-", t("chart_subfactor_scores", lang)),
        font = list(size = 14, family = get_font(lang))
      ),
      xaxis = list(title = "", tickangle = -45, tickfont = list(family = get_font(lang))),
      yaxis = list(title = t("score", lang), range = c(0, 100), titlefont = list(family = get_font(lang))),
      showlegend = FALSE,
      margin = list(b = 150),
      font = list(family = get_font(lang))
    ) %>%
    layout(xaxis = list(categoryorder = "total ascending"))
}

# ============================================================================
# 9. HEATMAP CHART
# ============================================================================
create_heatmap_chart <- function(data, lang = "en") {

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
      Country = factor(Country, levels = c("UAE", "Qatar", "Saudi Arabia", "Bahrain", "Oman", "Kuwait")),
      Country_Display = translate_countries(as.character(Country), lang),
      Dimension_Display = translate_dimensions(as.character(Dimension), lang)
    )

  plot_ly(
    data = heatmap_data,
    x = ~Dimension_Display,
    y = ~Country_Display,
    z = ~Score,
    type = "heatmap",
    colorscale = list(c(0, "#d73027"), c(0.5, "#fee08b"), c(1, "#1a9850")),
    zmin = 40,
    zmax = 100,
    text = ~round(Score, 1),
    texttemplate = "%{text}",
    hoverinfo = "text",
    hovertext = ~paste0(Country_Display, "<br>", Dimension_Display, ": ", round(Score, 1))
  ) %>%
    layout(
      title = list(text = t("chart_heatmap_title", lang), font = list(size = 14, family = get_font(lang))),
      xaxis = list(title = "", tickfont = list(family = get_font(lang))),
      yaxis = list(title = "", autorange = "reversed", tickfont = list(family = get_font(lang))),
      font = list(family = get_font(lang))
    )
}

# ============================================================================
# 10. GAP CHART
# ============================================================================
create_gap_chart <- function(data, gcc_method = "GCC (Weighted)", lang = "en") {

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
                                                "Government Efficiency", "Business Efficiency", "Overall")),
      Dimension_Display = translate_dimensions(as.character(Dimension), lang)
    )

  plot_ly(data = gap_data) %>%
    add_bars(
      y = ~Dimension_Display,
      x = ~Score,
      name = t("chart_achieved", lang),
      marker = list(color = "#1a5276"),
      orientation = "h",
      text = ~paste0(round(Score, 1), "%"),
      textposition = "inside",
      hoverinfo = "text",
      hovertext = ~paste0(Dimension_Display, "<br>", t("score", lang), ": ", round(Score, 1))
    ) %>%
    add_bars(
      y = ~Dimension_Display,
      x = ~Gap,
      name = t("chart_gap_to_100", lang),
      marker = list(color = "#d3d3d3"),
      orientation = "h",
      text = ~paste0(round(Gap, 1), "%"),
      textposition = "inside",
      hoverinfo = "text",
      hovertext = ~paste0(Dimension_Display, "<br>", t("gap_label", lang), ": ", round(Gap, 1))
    ) %>%
    layout(
      title = list(text = t("chart_gap_title", lang), font = list(size = 14, family = get_font(lang))),
      xaxis = list(title = t("percentage", lang), range = c(0, 100), titlefont = list(family = get_font(lang))),
      yaxis = list(title = "", tickfont = list(family = get_font(lang))),
      barmode = "stack",
      legend = list(orientation = "h", y = -0.15, font = list(family = get_font(lang))),
      font = list(family = get_font(lang))
    )
}

# ============================================================================
# 11. OVERLAY RADAR CHART (Country vs GCC)
# ============================================================================
create_overlay_radar_chart <- function(data, selected_country, gcc_method = "GCC (Weighted)", lang = "en") {

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
  categories_display <- translate_dimensions(categories, lang)

  country_values <- c(as.numeric(unlist(country_data[1, ])), as.numeric(unlist(country_data[1, 1])))
  gcc_values <- c(as.numeric(unlist(gcc_data[1, ])), as.numeric(unlist(gcc_data[1, 1])))

  country_color <- if (selected_country %in% names(country_colors)) {
    as.character(country_colors[[selected_country]])
  } else {
    "#1a5276"
  }

  country_display <- translate_country(selected_country, lang)
  gcc_display <- translate_country(gcc_method, lang)

  plot_ly(type = "scatterpolar") %>%
    add_trace(
      r = gcc_values,
      theta = categories_display,
      fill = "toself",
      fillcolor = "rgba(184, 163, 88, 0.2)",
      line = list(color = "#B8A358", width = 2, dash = "dash"),
      name = gcc_display
    ) %>%
    add_trace(
      r = country_values,
      theta = categories_display,
      fill = "toself",
      fillcolor = paste0(country_color, "40"),
      line = list(color = country_color, width = 2),
      name = country_display
    ) %>%
    layout(
      polar = list(
        radialaxis = list(visible = TRUE, range = c(0, 100)),
        angularaxis = list(tickfont = list(family = get_font(lang)))
      ),
      legend = list(orientation = "h", y = -0.1, font = list(family = get_font(lang))),
      title = list(
        text = paste(country_display, t("chart_vs", lang), gcc_display),
        font = list(size = 14, family = get_font(lang))
      ),
      font = list(family = get_font(lang))
    )
}
