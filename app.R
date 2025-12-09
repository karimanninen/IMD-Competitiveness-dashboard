# ============================================================================
# GCC COMPETITIVENESS DASHBOARD - IMD World Competitiveness Ranking 2025
# Top Navigation: Home | Metadata | GCC Aggregate | Country Data | Analysis | Recommendations
# ============================================================================

library(shiny)
library(bslib)
library(plotly)
library(dplyr)
library(tidyr)
library(DT)
library(shinyWidgets)

# Load modules
source("R/data_loader.R")
source("R/charts.R")

# Logo URLs
#logo_white <- "https://gccstat.org/images/gccstat/logo/GCC-MAIN-01-WHITE.png"
#logo_black <- "https://gccstat.org/images/gccstat/logo/GCC-MAIN-01-BLACK.png"

logo_white <- "images/GCC-MAIN-01-WHITE.png"
logo_black <- "images/GCC-MAIN-01-BLACK.png"


# ============================================================================
# UI
# ============================================================================

ui <- page_navbar(
  title = tags$span(
    tags$img(src = logo_white, height = "35px", style = "margin-right: 10px;"),
    "GCC Competitiveness Dashboard"
  ),
  id = "main_nav",
  theme = bs_theme(
    version = 5,
    bootswatch = "flatly",
    primary = "#1a5276",
    secondary = "#B8A358",
    base_font = font_google("Inter"),
    heading_font = font_google("Playfair Display")
  ),
  bg = "#1a5276",
  
  # Custom CSS
  header = tags$head(
    tags$style(HTML("
      .navbar { padding: 0.5rem 1rem; }
      .navbar-brand { font-weight: 600; }
      .nav-link { font-weight: 500; }
      .card { margin-bottom: 1rem; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
      .card-header { background: linear-gradient(135deg, #1a5276 0%, #2980b9 100%); color: white; font-weight: 600; }
      .metric-box { background: #f8f9fa; border-radius: 8px; padding: 1.5rem; text-align: center; }
      .metric-value { font-size: 2.5rem; font-weight: 700; color: #1a5276; }
      .metric-label { font-size: 0.9rem; color: #666; text-transform: uppercase; letter-spacing: 1px; }
      .highlight-box { background: linear-gradient(135deg, #B8A358 0%, #d4c17a 100%); 
                       color: #1a1a1a; border-radius: 8px; padding: 1.5rem; }
      .country-badge { display: inline-block; padding: 0.25rem 0.75rem; border-radius: 20px; 
                       font-weight: 500; margin: 0.25rem; }
      .country-uae { background: #000000; color: white; }
      .country-qatar { background: #99154C; color: white; }
      .country-saudi { background: #008035; color: white; }
      .country-bahrain { background: #E20000; color: white; }
      .country-oman { background: #a3a3a3; color: white; }
      .country-kuwait { background: #00B1E6; color: white; }
      .recommendation-card { background: white; border-left: 4px solid #B8A358; padding: 1rem; 
                             margin-bottom: 1rem; border-radius: 0 8px 8px 0; }
      .recommendation-card h5 { color: #1a5276; margin-bottom: 0.5rem; }
      .recommendation-card p { margin: 0; color: #555; }
      .footer { background: #1a1a1a; color: rgba(255,255,255,0.7); padding: 1rem; 
                text-align: center; margin-top: 2rem; }
    "))
  ),
  
  # ========== TAB 1: HOME ==========
  nav_panel(
    title = "Home",
    icon = icon("home"),
    
    layout_columns(
      col_widths = c(12),
      
      # Hero Section
      card(
        class = "border-0",
        card_body(
          class = "text-center py-4",
          style = "background: linear-gradient(135deg, #1a5276 0%, #2980b9 100%); color: white; border-radius: 12px;",
          h1("Stronger Together", class = "display-4 fw-bold"),
          p(class = "lead", "How the GCC Became a Global Economic Force"),
          hr(style = "border-color: rgba(255,255,255,0.3); width: 100px; margin: 1.5rem auto;"),
          p("IMD World Competitiveness Ranking 2025")
        )
      )
    ),
    
    layout_columns(
      col_widths = c(3, 3, 3, 3),
      
      # Key Metrics
      div(class = "metric-box",
          div(class = "metric-value", "84.9"),
          div(class = "metric-label", "GCC Overall Score")
      ),
      div(class = "metric-box",
          div(class = "metric-value", "#12"),
          div(class = "metric-label", "Global Ranking")
      ),
      div(class = "metric-box",
          div(class = "metric-value", "$2.2T"),
          div(class = "metric-label", "Combined GDP")
      ),
      div(class = "metric-box",
          div(class = "metric-value", "3"),
          div(class = "metric-label", "Countries in Top 20")
      )
    ),
    
    layout_columns(
      col_widths = c(6, 6),
      
      card(
        card_header("GCC Member Countries"),
        card_body(
          div(
            span(class = "country-badge country-uae", "🇦🇪 UAE #5"),
            span(class = "country-badge country-qatar", "🇶🇦 Qatar #9"),
            span(class = "country-badge country-saudi", "🇸🇦 Saudi Arabia #17"),
            span(class = "country-badge country-bahrain", "🇧🇭 Bahrain #22"),
            span(class = "country-badge country-oman", "🇴🇲 Oman #28"),
            span(class = "country-badge country-kuwait", "🇰🇼 Kuwait #36")
          ),
          hr(),
          p("All six GCC countries are now ranked in the IMD World Competitiveness Index,
            demonstrating the region's growing economic influence and competitive strength.")
        )
      ),
      
      card(
        card_header("Key Highlights"),
        card_body(
          class = "highlight-box",
          tags$ul(style = "margin: 0; padding-left: 1.2rem;",
                  tags$li("UAE climbed to 5th place globally - the highest ever for a GCC country"),
                  tags$li("Saudi Arabia made the biggest leap: from 32nd (2021) to 17th (2025)"),
                  tags$li("Qatar maintains its position in the top 10"),
                  tags$li("Business Efficiency is the GCC's strongest dimension (Score: 82.6)")
          )
        )
      )
    ),
    
    layout_columns(
      col_widths = c(7, 5),
      
      card(
        card_header("GCC in Global Context"),
        card_body(
          plotlyOutput("home_world_ranking", height = "400px")
        )
      ),
      
      card(
        card_header("5-Year Trajectory"),
        card_body(
          plotlyOutput("home_trajectory", height = "400px")
        )
      )
    )
  ),
  
  # ========== TAB 2: METADATA ==========
  nav_panel(
    title = "Metadata",
    icon = icon("info-circle"),
    
    layout_columns(
      col_widths = c(6, 6),
      
      card(
        card_header("About the IMD World Competitiveness Ranking"),
        card_body(
          h5("Overview"),
          p("The IMD World Competitiveness Ranking measures how economies manage their 
            resources and competencies to increase their prosperity. Published annually 
            since 1989, it is one of the world's most respected competitiveness studies."),
          hr(),
          h5("Methodology"),
          p("The ranking is based on 256 criteria across four main factors, combining 
            hard data from international sources and survey responses from business executives."),
          tags$ul(
            tags$li("Two-thirds of criteria come from statistical data"),
            tags$li("One-third from executive opinion surveys"),
            tags$li("Each factor has equal weight (25%) in the overall score")
          )
        )
      ),
      
      card(
        card_header("The Four Competitiveness Factors"),
        card_body(
          div(style = "display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;",
              div(style = "background: #2980b9; color: white; padding: 1rem; border-radius: 8px;",
                  h6("📊 Economic Performance", style = "margin: 0;"),
                  p(style = "margin: 0.5rem 0 0; font-size: 0.85rem;", "Domestic economy, trade, investment, employment, prices")
              ),
              div(style = "background: #27ae60; color: white; padding: 1rem; border-radius: 8px;",
                  h6("🏛️ Government Efficiency", style = "margin: 0;"),
                  p(style = "margin: 0.5rem 0 0; font-size: 0.85rem;", "Public finance, tax policy, institutions, legislation, social frame")
              ),
              div(style = "background: #8e44ad; color: white; padding: 1rem; border-radius: 8px;",
                  h6("💼 Business Efficiency", style = "margin: 0;"),
                  p(style = "margin: 0.5rem 0 0; font-size: 0.85rem;", "Productivity, labor market, finance, management, attitudes")
              ),
              div(style = "background: #e67e22; color: white; padding: 1rem; border-radius: 8px;",
                  h6("🏗️ Infrastructure", style = "margin: 0;"),
                  p(style = "margin: 0.5rem 0 0; font-size: 0.85rem;", "Basic, technological, scientific, health, education")
              )
          )
        )
      )
    ),
    
    layout_columns(
      col_widths = c(6, 6),
      
      card(
        card_header("GCC Aggregation Methodology"),
        card_body(
          h5("Two Aggregation Approaches"),
          p("This dashboard calculates hypothetical GCC aggregate scores using two methods:"),
          
          div(style = "background: #f0f0f0; padding: 1rem; border-radius: 8px; margin-bottom: 1rem;",
              h6("Simple Average", style = "color: #377eb8;"),
              p(style = "margin: 0; font-size: 0.9rem;", 
                "Equal weight to all six countries. Best for comparing average performance.")
          ),
          
          div(style = "background: #f0f0f0; padding: 1rem; border-radius: 8px;",
              h6("GDP-Weighted Average", style = "color: #e41a1c;"),
              p(style = "margin: 0; font-size: 0.9rem;", 
                "Countries weighted by economic size. Better represents the 'unified entity' scenario.")
          ),
          
          hr(),
          h6("GDP Weights (2024)"),
          tableOutput("metadata_gdp_table")
        )
      ),
      
      card(
        card_header("Data Summary"),
        card_body(
          h5("Dataset Information"),
          tags$table(class = "table table-sm",
                     tags$tr(tags$td("Source:"), tags$td(tags$strong("IMD World Competitiveness Center"))),
                     tags$tr(tags$td("Year:"), tags$td(tags$strong("2025"))),
                     tags$tr(tags$td("Total Countries Ranked:"), tags$td(tags$strong("69"))),
                     tags$tr(tags$td("GCC Countries Included:"), tags$td(tags$strong("6 (all member states)"))),
                     tags$tr(tags$td("Main Factors:"), tags$td(tags$strong("4"))),
                     tags$tr(tags$td("Sub-Factors:"), tags$td(tags$strong("20"))),
                     tags$tr(tags$td("Total Criteria:"), tags$td(tags$strong("256")))
          ),
          hr(),
          h6("GCC Countries in the Ranking"),
          p("All six GCC member states are now included in the IMD ranking:"),
          tags$ul(
            tags$li("UAE, Qatar, Saudi Arabia: Since 2020 (or earlier)"),
            tags$li("Bahrain: Joined in 2022"),
            tags$li("Kuwait: Joined in 2023"),
            tags$li("Oman: Joined in 2025")
          )
        )
      )
    )
  ),
  
  # ========== TAB 3: GCC AGGREGATE ==========
  nav_panel(
    title = "GCC Aggregate",
    icon = icon("globe"),
    
    layout_columns(
      col_widths = c(12),
      
      card(
        card_body(
          class = "text-center py-3",
          style = "background: linear-gradient(135deg, #B8A358 0%, #d4c17a 100%); border-radius: 8px;",
          h3("If the GCC Were a Single Country...", class = "fw-bold mb-2", style = "color: #1a1a1a;"),
          p(class = "mb-0", style = "color: #333;", 
            "With a combined GDP of $2.2 trillion, the GCC would rank among the world's top 15 most competitive economies")
        )
      )
    ),
    
    layout_columns(
      col_widths = c(4, 8),
      
      card(
        card_header("Aggregation Settings"),
        card_body(
          radioButtons(
            "agg_method",
            "Select Aggregation Method:",
            choices = c("GDP-Weighted" = "GCC (Weighted)", "Simple Average" = "GCC (Simple)"),
            selected = "GCC (Weighted)"
          ),
          hr(),
          uiOutput("agg_method_description"),
          hr(),
          h6("GCC Aggregate Scores"),
          tableOutput("agg_scores_table")
        )
      ),
      
      card(
        card_header("GCC Position in World Rankings"),
        card_body(
          plotlyOutput("agg_world_chart", height = "400px")
        )
      )
    ),
    
    layout_columns(
      col_widths = c(6, 6),
      
      card(
        card_header("Simple vs GDP-Weighted Comparison"),
        card_body(
          plotlyOutput("agg_comparison_chart", height = "350px")
        )
      ),
      
      card(
        card_header("GDP Weight Distribution"),
        card_body(
          plotlyOutput("agg_gdp_pie", height = "350px")
        )
      )
    ),
    
    layout_columns(
      col_widths = c(12),
      
      card(
        card_header("Dimension-Level Performance"),
        card_body(
          plotlyOutput("agg_dimensions_chart", height = "350px")
        )
      )
    )
  ),
  
  # ========== TAB 4: COUNTRY DATA ==========
  nav_panel(
    title = "Country Data",
    icon = icon("flag"),
    
    layout_columns(
      col_widths = c(3, 9),
      
      card(
        card_header("Select Country"),
        card_body(
          selectInput(
            "selected_country",
            "Choose a GCC Country:",
            choices = c("UAE", "Qatar", "Saudi Arabia", "Bahrain", "Kuwait", "Oman"),
            selected = "UAE"
          ),
          hr(),
          uiOutput("country_summary_box")
        )
      ),
      
      card(
        card_header(textOutput("country_header")),
        card_body(
          plotlyOutput("country_radar", height = "400px")
        )
      )
    ),
    
    layout_columns(
      col_widths = c(6, 6),
      
      card(
        card_header("Dimension Scores & Rankings"),
        card_body(
          DTOutput("country_dimensions_table")
        )
      ),
      
      card(
        card_header("5-Year Factor Rankings"),
        card_body(
          plotlyOutput("country_trend", height = "350px")
        )
      )
    ),
    
    layout_columns(
      col_widths = c(12),
      
      card(
        card_header("Sub-Factor Performance"),
        card_body(
          selectInput(
            "subfactor_filter",
            "Filter by Factor:",
            choices = c("All", "Economic Performance", "Government Efficiency", 
                        "Business Efficiency", "Infrastructure"),
            selected = "All",
            width = "300px"
          ),
          plotlyOutput("country_subfactors", height = "500px")
        )
      )
    )
  ),
  
  # ========== TAB 5: ANALYSIS ==========
  nav_panel(
    title = "Analysis",
    icon = icon("chart-line"),
    
    navset_card_tab(
      title = "Comparative Analysis",
      
      # Sub-tab: 5-Year Trends
      nav_panel(
        title = "5-Year Trends",
        icon = icon("calendar"),
        
        layout_columns(
          col_widths = c(12),
          
          card(
            card_body(
              pickerInput(
                "trend_countries",
                "Select Countries to Compare:",
                choices = c("UAE", "Qatar", "Saudi Arabia", "Bahrain", "Kuwait", "Oman", "GCC Average"),
                selected = c("UAE", "Qatar", "Saudi Arabia", "GCC Average"),
                multiple = TRUE,
                options = list(`actions-box` = TRUE)
              ),
              plotlyOutput("analysis_trends", height = "450px")
            )
          )
        ),
        
        layout_columns(
          col_widths = c(6, 6),
          
          card(
            card_header("Country Performance Summary (2021-2025)"),
            card_body(
              DTOutput("analysis_performance_table")
            )
          ),
          
          card(
            card_header("Key Insights"),
            card_body(
              div(class = "recommendation-card",
                  h5("🏆 Biggest Improver"),
                  p("Saudi Arabia improved 15 positions (from #32 to #17)")
              ),
              div(class = "recommendation-card",
                  h5("📈 Highest Ranked"),
                  p("UAE reached #5 globally - the highest ever for a GCC country")
              ),
              div(class = "recommendation-card",
                  h5("🌍 Regional Average"),
                  p("GCC average improved from ~19.5 (2021) to ~16.2 (2025)")
              )
            )
          )
        )
      ),
      
      # Sub-tab: Heatmap
      nav_panel(
        title = "Country Comparison",
        icon = icon("th"),
        
        layout_columns(
          col_widths = c(12),
          
          card(
            card_header("GCC Countries Competitiveness Heatmap"),
            card_body(
              plotlyOutput("analysis_heatmap", height = "400px")
            )
          )
        ),
        
        layout_columns(
          col_widths = c(12),
          
          card(
            card_header("Full Comparison Table"),
            card_body(
              DTOutput("analysis_full_table")
            )
          )
        )
      ),
      
      # Sub-tab: Sub-factors
      nav_panel(
        title = "Sub-Factor Deep Dive",
        icon = icon("search"),
        
        layout_columns(
          col_widths = c(4, 8),
          
          card(
            card_body(
              selectInput(
                "analysis_factor",
                "Select Factor:",
                choices = c("Economic Performance", "Government Efficiency", 
                            "Business Efficiency", "Infrastructure"),
                selected = "Business Efficiency"
              ),
              hr(),
              h6("Sub-Factors in this Category:"),
              uiOutput("subfactor_list")
            )
          ),
          
          card(
            card_header("Sub-Factor Comparison Across Countries"),
            card_body(
              plotlyOutput("analysis_subfactor_compare", height = "450px")
            )
          )
        )
      )
    )
  ),
  
  # ========== TAB 6: RECOMMENDATIONS ==========
  nav_panel(
    title = "Recommendations",
    icon = icon("lightbulb"),
    
    layout_columns(
      col_widths = c(12),
      
      card(
        card_body(
          class = "text-center py-3",
          style = "background: linear-gradient(135deg, #1a5276 0%, #2980b9 100%); color: white; border-radius: 8px;",
          h3("The 2030 Horizon", class = "fw-bold mb-2"),
          p(class = "mb-0", "Can the GCC Break Into the Global Top 10?")
        )
      )
    ),
    
    layout_columns(
      col_widths = c(6, 6),
      
      card(
        card_header("Gap Analysis"),
        card_body(
          plotlyOutput("rec_gap_chart", height = "350px")
        )
      ),
      
      card(
        card_header("Strengths & Weaknesses"),
        card_body(
          h6("Top Strengths (Sub-Factors)"),
          DTOutput("rec_strengths_table"),
          hr(),
          h6("Areas for Improvement"),
          DTOutput("rec_weaknesses_table")
        )
      )
    ),
    
    layout_columns(
      col_widths = c(12),
      
      card(
        card_header("Strategic Recommendations for GCC Competitiveness"),
        card_body(
          layout_columns(
            col_widths = c(6, 6),
            
            div(
              div(class = "recommendation-card",
                  h5("🏗️ Infrastructure Investment"),
                  p("Close the 15-point gap by accelerating R&D spending, digital infrastructure, 
                    and green energy transitions. Infrastructure remains the GCC's biggest 
                    opportunity for improvement.")
              ),
              div(class = "recommendation-card",
                  h5("🌱 Sustainability Leadership"),
                  p("Transform environmental challenges into competitive advantages through 
                    aggressive renewable energy deployment. This aligns with Vision 2030 goals 
                    across the region.")
              )
            ),
            
            div(
              div(class = "recommendation-card",
                  h5("🎓 Human Capital Development"),
                  p("Strengthen higher education systems and STEM capabilities to reduce 
                    dependency on imported talent. Scientific infrastructure sub-factor 
                    shows significant room for growth.")
              ),
              div(class = "recommendation-card",
                  h5("🤝 Regional Integration"),
                  p("Deepen economic cooperation to create true economies of scale across 
                    the $2.2 trillion GCC market. Harmonized regulations could boost 
                    business efficiency further.")
              )
            )
          )
        )
      )
    ),
    
    layout_columns(
      col_widths = c(12),
      
      card(
        card_header("Path to Top 10"),
        card_body(
          p("Based on current trajectories and gap analysis, the GCC as a unified entity 
            could achieve the following improvements by 2030:"),
          
          tags$table(class = "table table-bordered",
                     tags$thead(class = "table-light",
                                tags$tr(
                                  tags$th("Dimension"),
                                  tags$th("Current Score"),
                                  tags$th("Target Score"),
                                  tags$th("Required Improvement"),
                                  tags$th("Key Actions")
                                )
                     ),
                     tags$tbody(
                       tags$tr(
                         tags$td("Infrastructure"),
                         tags$td("60.4"),
                         tags$td("75+"),
                         tags$td("+15 points"),
                         tags$td("R&D investment, digital transformation")
                       ),
                       tags$tr(
                         tags$td("Economic Performance"),
                         tags$td("65.8"),
                         tags$td("75+"),
                         tags$td("+10 points"),
                         tags$td("Economic diversification, trade expansion")
                       ),
                       tags$tr(
                         tags$td("Government Efficiency"),
                         tags$td("74.8"),
                         tags$td("80+"),
                         tags$td("+5 points"),
                         tags$td("Regulatory harmonization, digital government")
                       ),
                       tags$tr(
                         tags$td("Business Efficiency"),
                         tags$td("82.6"),
                         tags$td("85+"),
                         tags$td("+3 points"),
                         tags$td("Maintain leadership, enhance productivity")
                       )
                     )
          ),
          
          p(class = "text-muted mt-3", 
            "Note: These targets are illustrative and based on analysis of improvement trajectories 
            of top-performing countries in the IMD ranking.")
        )
      )
    )
  ),
  
  # Footer
  nav_spacer(),
  nav_item(
    tags$span(style = "color: rgba(255,255,255,0.7); font-size: 0.85rem;",
              "GCC-Stat | IMD World Competitiveness Ranking 2025")
  )
)

# ============================================================================
# SERVER
# ============================================================================

server <- function(input, output, session) {
  
  # Load data
  wcr_data <- reactive({ load_wcr_data() })
  
  # ========== HOME TAB ==========
  output$home_world_ranking <- renderPlotly({
    create_world_ranking_chart(wcr_data(), gcc_method = "GCC (Weighted)", n_countries = 25)
  })
  
  output$home_trajectory <- renderPlotly({
    create_trajectory_chart(wcr_data(), highlight = c("UAE", "Qatar", "Saudi Arabia", "GCC Average"))
  })
  
  # ========== METADATA TAB ==========
  output$metadata_gdp_table <- renderTable({
    wcr_data()$gdp_weights %>%
      select(Country, `GDP ($ Billion)` = GDP_2024, `Weight (%)` = Weight_Pct) %>%
      arrange(desc(`GDP ($ Billion)`))
  })
  
  # ========== GCC AGGREGATE TAB ==========
  output$agg_method_description <- renderUI({
    if (input$agg_method == "GCC (Weighted)") {
      div(
        p(class = "text-muted", style = "font-size: 0.9rem;",
          "GDP-weighted aggregation gives more influence to larger economies. 
          Saudi Arabia (50%) and UAE (25%) together represent 75% of the weight.")
      )
    } else {
      div(
        p(class = "text-muted", style = "font-size: 0.9rem;",
          "Simple average treats all six countries equally, regardless of economic size. 
          This highlights average regional performance.")
      )
    }
  })
  
  output$agg_scores_table <- renderTable({
    wcr_data()$factors_2025 %>%
      filter(Country == input$agg_method) %>%
      select(
        Overall = Overall_Score,
        `Econ Perf` = EconPerf_Score,
        `Gov Eff` = GovEff_Score,
        `Bus Eff` = BusEff_Score,
        Infra = Infra_Score
      ) %>%
      mutate(across(everything(), ~round(., 1)))
  })
  
  output$agg_world_chart <- renderPlotly({
    create_world_ranking_chart(wcr_data(), gcc_method = input$agg_method, n_countries = 30)
  })
  
  output$agg_comparison_chart <- renderPlotly({
    create_method_comparison_chart(wcr_data())
  })
  
  output$agg_gdp_pie <- renderPlotly({
    create_gdp_weights_chart(wcr_data())
  })
  
  output$agg_dimensions_chart <- renderPlotly({
    create_dimensions_chart(wcr_data(), gcc_method = input$agg_method)
  })
  
  # ========== COUNTRY DATA TAB ==========
  output$country_header <- renderText({
    paste0(input$selected_country, " - Competitiveness Profile 2025")
  })
  
  output$country_summary_box <- renderUI({
    country_data <- wcr_data()$factors_2025 %>%
      filter(Country == input$selected_country)
    
    color <- gcc_colors[input$selected_country]
    
    div(style = paste0("background: ", color, "; color: white; padding: 1rem; border-radius: 8px;"),
        h4(input$selected_country, style = "margin: 0 0 0.5rem;"),
        p(style = "margin: 0;", paste0("Overall Rank: #", country_data$Overall_Rank)),
        p(style = "margin: 0;", paste0("Overall Score: ", round(country_data$Overall_Score, 1))),
        p(style = "margin: 0;", paste0("GDP: $", round(country_data$GDP_2024, 1), "B"))
    )
  })
  
  output$country_radar <- renderPlotly({
    create_radar_chart(wcr_data(), selected_country = input$selected_country, gcc_method = "GCC (Weighted)")
  })
  
  output$country_dimensions_table <- renderDT({
    wcr_data()$factors_2025 %>%
      filter(Country == input$selected_country) %>%
      select(
        `Overall Score` = Overall_Score, `Overall Rank` = Overall_Rank,
        `Econ Perf Score` = EconPerf_Score, `Econ Perf Rank` = EconPerf_Rank,
        `Gov Eff Score` = GovEff_Score, `Gov Eff Rank` = GovEff_Rank,
        `Bus Eff Score` = BusEff_Score, `Bus Eff Rank` = BusEff_Rank,
        `Infra Score` = Infra_Score, `Infra Rank` = Infra_Rank
      ) %>%
      mutate(across(contains("Score"), ~round(., 1))) %>%
      pivot_longer(everything(), names_to = "Metric", values_to = "Value") %>%
      mutate(
        Dimension = gsub(" Score| Rank", "", Metric),
        Type = ifelse(grepl("Score", Metric), "Score", "Rank")
      ) %>%
      select(-Metric) %>%
      pivot_wider(names_from = Type, values_from = Value)
  }, options = list(dom = 't', pageLength = 5))
  
  output$country_trend <- renderPlotly({
    create_factor_trend_chart(wcr_data(), selected_country = input$selected_country)
  })
  
  output$country_subfactors <- renderPlotly({
    create_subfactor_chart(wcr_data(), 
                           selected_country = input$selected_country,
                           selected_factor = input$subfactor_filter)
  })
  
  # ========== ANALYSIS TAB ==========
  output$analysis_trends <- renderPlotly({
    selected <- input$trend_countries
    if (is.null(selected) || length(selected) == 0) {
      selected <- c("UAE", "GCC Average")
    }
    create_trajectory_chart(wcr_data(), highlight = selected)
  })
  
  output$analysis_performance_table <- renderDT({
    wcr_data()$overall_rankings %>%
      filter(Country != "GCC Average", Year %in% c(2021, 2025)) %>%
      select(Country, Year, Overall_Rank) %>%
      pivot_wider(names_from = Year, values_from = Overall_Rank, names_prefix = "Rank_") %>%
      mutate(
        Change = Rank_2021 - Rank_2025,
        Trend = case_when(
          is.na(Change) ~ "New Entry",
          Change > 5 ~ "Strong Improvement",
          Change > 0 ~ "Improving",
          Change == 0 ~ "Stable",
          TRUE ~ "Declining"
        )
      ) %>%
      rename(`2021` = Rank_2021, `2025` = Rank_2025)
  }, options = list(dom = 't', pageLength = 10))
  
  output$analysis_heatmap <- renderPlotly({
    create_heatmap_chart(wcr_data())
  })
  
  output$analysis_full_table <- renderDT({
    wcr_data()$factors_2025 %>%
      filter(!grepl("GCC", Country)) %>%
      select(Country, Overall_Rank, Overall_Score,
             EconPerf_Score, GovEff_Score, BusEff_Score, Infra_Score) %>%
      mutate(across(contains("Score"), ~round(., 1))) %>%
      arrange(Overall_Rank)
  }, options = list(dom = 'tip', pageLength = 6))
  
  output$subfactor_list <- renderUI({
    factor_data <- wcr_data()$subfactors_2025 %>%
      filter(Country == "UAE", Factor == input$analysis_factor) %>%
      pull(Sub_Factor) %>%
      unique()
    
    tags$ul(
      lapply(factor_data, function(sf) tags$li(sf, style = "font-size: 0.9rem;"))
    )
  })
  
  output$analysis_subfactor_compare <- renderPlotly({
    subfactor_data <- wcr_data()$subfactors_2025 %>%
      filter(Factor == input$analysis_factor, !grepl("GCC", Country)) %>%
      mutate(Country = factor(Country, levels = c("UAE", "Qatar", "Saudi Arabia", "Bahrain", "Kuwait", "Oman")))
    
    # Named color vector for proper mapping
    country_colors <- c(
      "UAE" = "#000000",
      "Qatar" = "#99154C", 
      "Saudi Arabia" = "#008035",
      "Bahrain" = "#E20000",
      "Kuwait" = "#00B1E6",
      "Oman" = "#a3a3a3"
    )
    
    plot_ly(
      data = subfactor_data,
      x = ~Sub_Factor,
      y = ~Score_2025,
      color = ~Country,
      colors = country_colors,
      type = "bar",
      text = ~round(Score_2025, 1),
      hoverinfo = "text+name"
    ) %>%
      layout(
        xaxis = list(title = "", tickangle = -45),
        yaxis = list(title = "Score", range = c(0, 100)),
        barmode = "group",
        legend = list(orientation = "h", y = -0.3)
      )
  })
  
  # ========== RECOMMENDATIONS TAB ==========
  output$rec_gap_chart <- renderPlotly({
    create_gap_chart(wcr_data(), gcc_method = "GCC (Weighted)")
  })
  
  output$rec_strengths_table <- renderDT({
    wcr_data()$subfactors_2025 %>%
      filter(Country == "GCC (Weighted)") %>%
      arrange(desc(Score_2025)) %>%
      head(5) %>%
      select(Factor, `Sub-Factor` = Sub_Factor, Score = Score_2025) %>%
      mutate(Score = round(Score, 1))
  }, options = list(dom = 't', pageLength = 5))
  
  output$rec_weaknesses_table <- renderDT({
    wcr_data()$subfactors_2025 %>%
      filter(Country == "GCC (Weighted)") %>%
      arrange(Score_2025) %>%
      head(5) %>%
      select(Factor, `Sub-Factor` = Sub_Factor, Score = Score_2025) %>%
      mutate(Score = round(Score, 1))
  }, options = list(dom = 't', pageLength = 5))
  
}

# ============================================================================
# RUN APP
# ============================================================================
shinyApp(ui = ui, server = server)
