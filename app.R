# ============================================================================
# GCC COMPETITIVENESS DASHBOARD - IMD World Competitiveness Ranking 2025
# CORRECTED VERSION with Landing Page Carousel
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

# Logo paths
logo_white <- "images/GCC-MAIN-01-WHITE.png"
logo_black <- "images/GCC-MAIN-01-BLACK.png"

# ============================================================================
# UI - SIMPLIFIED STRUCTURE
# ============================================================================

ui <- fluidPage(
  
  # Theme
  theme = bs_theme(
    version = 5,
    bootswatch = "flatly",
    primary = "#1a5276",
    secondary = "#B8A358",
    base_font = font_google("Inter"),
    heading_font = font_google("Playfair Display")
  ),
  
  # ===== HEAD: CSS + JavaScript =====
  tags$head(
    
    # ----- CSS -----
    tags$style(HTML("
      /* ============================================================
         EXISTING DASHBOARD STYLES
         ============================================================ */
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

      /* ============================================================
         LANDING PAGE STYLES
         ============================================================ */
      
      body {
        margin: 0;
        padding: 0;
      }
      
      .landing-container {
        min-height: 100vh;
        background: #f8f9fa;
      }
      
      /* Hero Section with rotating backgrounds */
      .landing-hero {
        height: 75vh;
        min-height: 500px;
        position: relative;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        color: white;
        text-align: center;
        padding: 40px 20px;
        overflow: hidden;
        background: linear-gradient(135deg, #1a5276 0%, #2980b9 50%, #1a5276 100%);
      }

      /* Background image layers */
      .hero-bg {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-size: cover;
        background-position: center;
        transition: opacity 1.5s ease-in-out;
        opacity: 0;
        z-index: 0;
      }

      .hero-bg.active {
        opacity: 1;
      }

      /* Dark overlay for text readability */
      .hero-overlay {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(135deg, rgba(26,82,118,0.85) 0%, rgba(41,128,185,0.80) 50%, rgba(26,82,118,0.85) 100%);
        z-index: 1;
      }

      /* Content sits above background */
      .landing-hero > *:not(.hero-bg):not(.hero-overlay) {
        position: relative;
        z-index: 2;
      }

      /* Background images - using local files from www/images/ folder */
      .hero-bg-1 { background-image: url('images/59.jpg'); }
      .hero-bg-2 { background-image: url('images/63.jpg'); }
      .hero-bg-3 { background-image: url('images/111.jpg'); }
      .hero-bg-4 { background-image: url('images/211.jpg'); }
      .hero-bg-5 { background-image: url('images/311.jpg'); }

      .landing-logo {
        height: 90px;
        margin-bottom: 25px;
      }

      .landing-title {
        font-size: 3rem;
        font-weight: 700;
        margin-bottom: 10px;
        text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        letter-spacing: 1px;
      }

      .landing-subtitle {
        font-size: 1.3rem;
        font-weight: 300;
        margin-bottom: 30px;
        opacity: 0.9;
      }

      /* Quote Carousel */
      .quote-carousel {
        max-width: 900px;
        padding: 35px 50px;
        font-size: 1.35rem;
        font-style: italic;
        line-height: 1.7;
        min-height: 120px;
        background: rgba(255,255,255,0.08);
        border-radius: 15px;
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255,255,255,0.1);
        margin: 20px 0;
      }

      .carousel-dots {
        display: flex;
        gap: 12px;
        margin-top: 25px;
        justify-content: center;
      }

      .carousel-dot {
        width: 12px;
        height: 12px;
        border-radius: 50%;
        background: rgba(255,255,255,0.4);
        cursor: pointer;
        transition: all 0.3s ease;
        border: none;
        padding: 0;
      }

      .carousel-dot:hover {
        background: rgba(255,255,255,0.7);
        transform: scale(1.2);
      }

      .carousel-dot.active {
        background: white;
        transform: scale(1.2);
      }

      /* Enter Button */
      .enter-btn {
        margin-top: 35px;
        padding: 18px 60px;
        font-size: 1.2rem;
        font-weight: 600;
        background: linear-gradient(135deg, #B8A358 0%, #9a8a4a 100%);
        border: none;
        color: white;
        border-radius: 50px;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(184,163,88,0.4);
        text-transform: uppercase;
        letter-spacing: 2px;
      }

      .enter-btn:hover {
        background: linear-gradient(135deg, #c9b569 0%, #B8A358 100%);
        transform: translateY(-3px);
        box-shadow: 0 6px 25px rgba(184,163,88,0.5);
      }

      .enter-btn:active {
        transform: translateY(-1px);
      }

      /* About Section */
      .landing-about {
        padding: 70px 10%;
        background: white;
        text-align: center;
      }

      .landing-about h2 {
        color: #1a5276;
        font-size: 2.2rem;
        margin-bottom: 25px;
        font-weight: 600;
      }

      .landing-about-text {
        max-width: 950px;
        margin: 0 auto 20px;
        font-size: 1.15rem;
        line-height: 1.9;
        color: #444;
      }

      /* Stats Row */
      .stats-row {
        display: flex;
        justify-content: center;
        gap: 35px;
        margin-top: 50px;
        flex-wrap: wrap;
        padding: 0 20px;
      }

      .stat-box {
        background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
        padding: 30px 45px;
        border-radius: 15px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        transition: all 0.3s ease;
        border: 1px solid #e9ecef;
        min-width: 140px;
      }

      .stat-box:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 30px rgba(0,0,0,0.12);
      }

      .stat-box .number {
        font-size: 2.8rem;
        font-weight: 700;
        color: #1a5276;
        line-height: 1;
        margin-bottom: 8px;
      }

      .stat-box .label {
        color: #666;
        font-size: 0.95rem;
        font-weight: 500;
        text-transform: uppercase;
        letter-spacing: 1px;
      }

      /* Dimensions Preview Section */
      .dimensions-section {
        padding: 60px 10%;
        background: #f8f9fa;
      }

      .dimensions-section h3 {
        text-align: center;
        color: #1a5276;
        font-size: 1.8rem;
        margin-bottom: 40px;
        font-weight: 600;
      }

      .dimension-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 25px;
        max-width: 1200px;
        margin: 0 auto;
      }

      .dimension-card {
        background: white;
        padding: 25px;
        border-radius: 12px;
        box-shadow: 0 2px 15px rgba(0,0,0,0.06);
        display: flex;
        align-items: center;
        gap: 18px;
        transition: all 0.3s ease;
        border-left: 4px solid #1a5276;
      }

      .dimension-card:hover {
        transform: translateX(5px);
        box-shadow: 0 4px 20px rgba(0,0,0,0.1);
      }

      .dimension-card i {
        font-size: 2rem;
        color: #1a5276;
        width: 50px;
        text-align: center;
      }

      .dimension-card .dim-text {
        flex: 1;
      }

      .dimension-card .dim-title {
        font-weight: 600;
        color: #1a5276;
        font-size: 1.1rem;
        margin-bottom: 5px;
      }

      .dimension-card .dim-desc {
        font-size: 0.9rem;
        color: #666;
        line-height: 1.5;
      }

      /* Landing Footer */
      .landing-footer {
        padding: 30px;
        background: #1a5276;
        color: rgba(255,255,255,0.8);
        text-align: center;
        font-size: 0.95rem;
      }

      .landing-footer a {
        color: white;
        text-decoration: none;
      }

      /* Back to Welcome button */
      .back-to-welcome {
        position: fixed;
        bottom: 20px;
        right: 20px;
        background: #1a5276;
        color: white;
        padding: 10px 20px;
        border-radius: 25px;
        font-size: 0.9rem;
        cursor: pointer;
        z-index: 9999;
        box-shadow: 0 2px 10px rgba(0,0,0,0.2);
        transition: all 0.3s ease;
        border: none;
      }

      .back-to-welcome:hover {
        background: #2980b9;
        transform: translateY(-2px);
      }

      /* Responsive adjustments */
      @media (max-width: 768px) {
        .landing-title { font-size: 2rem; }
        .landing-subtitle { font-size: 1.1rem; }
        .quote-carousel { 
          font-size: 1.1rem; 
          padding: 25px 30px;
          margin: 15px;
        }
        .stats-row { gap: 20px; }
        .stat-box { padding: 20px 30px; }
        .stat-box .number { font-size: 2.2rem; }
        .enter-btn { padding: 15px 40px; }
      }
    ")),
    
    # ----- JavaScript for Carousel -----
    tags$script(HTML("
      // Quotes array
      var quotes = [
        'The GCC has emerged as a global economic powerhouse—with a combined GDP of $2.2 trillion, the region now competes with established economies worldwide.',
        'Three GCC nations rank in the global top 20—UAE at #5, Qatar at #9, and Saudi Arabia at #17—a remarkable concentration of competitiveness.',
        'Business efficiency is the GCC\\'s strongest dimension, scoring 82.6 and ranking 11th globally, reflecting decades of regulatory reforms.',
        'Saudi Arabia achieved the region\\'s most dramatic transformation—leaping 15 positions from 32nd to 17th between 2021 and 2025.',
        'Together, the six GCC nations create a complementary ecosystem where investors find exactly the competitive advantages they need.'
      ];
      
      var currentQuote = 0;
      var carouselInterval;
      
      // Function to show a specific quote
      function showQuote(index) {
        currentQuote = index;
        
        // Update quote text with fade effect
        var quoteDisplay = document.getElementById('quote-display');
        if (quoteDisplay) {
          quoteDisplay.style.opacity = '0';
          setTimeout(function() {
            quoteDisplay.textContent = quotes[index];
            quoteDisplay.style.opacity = '1';
          }, 300);
        }
        
        // Update background images
        var backgrounds = document.querySelectorAll('.hero-bg');
        backgrounds.forEach(function(bg, i) {
          bg.classList.remove('active');
          if (i === index) {
            bg.classList.add('active');
          }
        });
        
        // Update dots
        var dots = document.querySelectorAll('.carousel-dot');
        dots.forEach(function(dot, i) {
          dot.classList.remove('active');
          if (i === index) {
            dot.classList.add('active');
          }
        });
      }
      
      // Function to go to next quote
      function nextQuote() {
        var next = (currentQuote + 1) % quotes.length;
        showQuote(next);
      }
      
      // Start auto-rotation
      function startCarousel() {
        // Clear any existing interval
        if (carouselInterval) {
          clearInterval(carouselInterval);
        }
        // Start new interval (7 seconds)
        carouselInterval = setInterval(nextQuote, 7000);
      }
      
      // Initialize carousel when document is ready
      $(document).ready(function() {
        // Small delay to ensure elements are rendered
        setTimeout(function() {
          var quoteDisplay = document.getElementById('quote-display');
          if (quoteDisplay) {
            quoteDisplay.style.transition = 'opacity 0.3s ease';
            startCarousel();
          }
        }, 500);
      });
      
      // Re-initialize when Shiny reconnects (for when user returns to landing page)
      $(document).on('shiny:value', function(event) {
        if (event.name === 'main_ui') {
          setTimeout(function() {
            var quoteDisplay = document.getElementById('quote-display');
            if (quoteDisplay) {
              quoteDisplay.style.transition = 'opacity 0.3s ease';
              showQuote(0);
              startCarousel();
            }
          }, 500);
        }
      });
    "))
    
  ), # End tags$head
  
  # ===== MAIN CONTENT - Rendered dynamically =====
  uiOutput("main_ui")
  
) # End fluidPage


# ============================================================================
# SERVER
# ============================================================================

server <- function(input, output, session) {
  
  # Reactive value to track if user has entered the dashboard
  entered_dashboard <- reactiveVal(FALSE)
  
  # Observer for Enter Dashboard button
  observeEvent(input$enter_dashboard, {
    entered_dashboard(TRUE)
  })
  
  # Observer for Back to Welcome button
  observeEvent(input$back_to_welcome, {
    entered_dashboard(FALSE)
  })
  
  # ===== MAIN UI RENDERER =====
  output$main_ui <- renderUI({
    
    if (!entered_dashboard()) {
      
      # ===== LANDING PAGE =====
      div(class = "landing-container",
          
          # Hero Section
          div(class = "landing-hero",
              
              # Background images (MUST BE FIRST)
              div(class = "hero-bg hero-bg-1 active"),
              div(class = "hero-bg hero-bg-2"),
              div(class = "hero-bg hero-bg-3"),
              div(class = "hero-bg hero-bg-4"),
              div(class = "hero-bg hero-bg-5"),
              
              # Dark overlay
              div(class = "hero-overlay"),
              
              # GCC-Stat Logo
              img(src = logo_white, class = "landing-logo"),
              
              # Title
              h1(class = "landing-title", "Stronger Together"),
              
              # Subtitle
              p(class = "landing-subtitle", "How the GCC Became a Global Economic Force"),
              
              # Rotating Quote Carousel
              div(class = "quote-carousel", id = "quote-display",
                  "The GCC has emerged as a global economic powerhouse—with a combined GDP of $2.2 trillion, the region now competes with established economies worldwide."
              ),
              
              # Carousel navigation dots
              div(class = "carousel-dots",
                  tags$button(class = "carousel-dot active", onclick = "showQuote(0)"),
                  tags$button(class = "carousel-dot", onclick = "showQuote(1)"),
                  tags$button(class = "carousel-dot", onclick = "showQuote(2)"),
                  tags$button(class = "carousel-dot", onclick = "showQuote(3)"),
                  tags$button(class = "carousel-dot", onclick = "showQuote(4)")
              ),
              
              # Enter Dashboard button
              actionButton("enter_dashboard", "Explore the Dashboard", 
                           class = "enter-btn",
                           icon = icon("arrow-right"))
          ),
          
          # About Section
          div(class = "landing-about",
              h2("IMD World Competitiveness Ranking 2025"),
              p(class = "landing-about-text",
                "The IMD World Competitiveness Ranking measures how 69 economies manage their
                resources and competencies to increase prosperity. This dashboard analyzes GCC
                performance as both individual nations and as a unified economic bloc, revealing
                how regional cooperation enhances global competitiveness."
              ),
              p(class = "landing-about-text",
                "Using GDP-weighted aggregation, we demonstrate that if the GCC were a single
                country, it would rank 12th globally with a score of 84.9—ahead of the United
                States, Finland, and Iceland."
              ),
              
              # Key statistics
              div(class = "stats-row",
                  div(class = "stat-box",
                      div(class = "number", "6"),
                      div(class = "label", "GCC Countries")
                  ),
                  div(class = "stat-box",
                      div(class = "number", "#12"),
                      div(class = "label", "Global Ranking")
                  ),
                  div(class = "stat-box",
                      div(class = "number", "84.9"),
                      div(class = "label", "GCC Score")
                  ),
                  div(class = "stat-box",
                      div(class = "number", "$2.2T"),
                      div(class = "label", "Combined GDP")
                  )
              )
          ),
          
          # Dimensions Preview Section
          div(class = "dimensions-section",
              h3("Four Competitiveness Factors"),
              div(class = "dimension-grid",
                  div(class = "dimension-card",
                      icon("chart-line"),
                      div(class = "dim-text",
                          div(class = "dim-title", "Economic Performance"),
                          div(class = "dim-desc", "Domestic economy, international trade, investment, employment, and prices")
                      )
                  ),
                  div(class = "dimension-card",
                      icon("landmark"),
                      div(class = "dim-text",
                          div(class = "dim-title", "Government Efficiency"),
                          div(class = "dim-desc", "Public finance, tax policy, institutional framework, and legislation")
                      )
                  ),
                  div(class = "dimension-card",
                      icon("briefcase"),
                      div(class = "dim-text",
                          div(class = "dim-title", "Business Efficiency"),
                          div(class = "dim-desc", "Productivity, labor market, finance, and management practices")
                      )
                  ),
                  div(class = "dimension-card",
                      icon("building"),
                      div(class = "dim-text",
                          div(class = "dim-title", "Infrastructure"),
                          div(class = "dim-desc", "Basic, technological, scientific infrastructure, health, and education")
                      )
                  )
              )
          ),
          
          # Footer
          div(class = "landing-footer",
              p("© 2025 GCC Statistical Center (GCC-Stat)"),
              p("Data Source: IMD World Competitiveness Center")
          )
      )
      
    } else {
      
      # ===== DASHBOARD =====
      tagList(
        # Back to Welcome button
        actionButton("back_to_welcome", HTML("&larr; Back to Welcome"), class = "back-to-welcome"),
        
        # Main Dashboard
        page_navbar(
          title = tags$span(
            tags$img(src = logo_white, height = "35px", style = "margin-right: 10px;"),
            "GCC Competitiveness Dashboard"
          ),
          id = "main_nav",
          bg = "#1a5276",
          
          # ========== TAB 1: HOME ==========
          nav_panel(
            title = "Home",
            icon = icon("home"),
            
            layout_columns(
              col_widths = c(12),
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
                    span(class = "country-badge country-uae", "UAE #5"),
                    span(class = "country-badge country-qatar", "Qatar #9"),
                    span(class = "country-badge country-saudi", "Saudi Arabia #17"),
                    span(class = "country-badge country-bahrain", "Bahrain #22"),
                    span(class = "country-badge country-oman", "Oman #28"),
                    span(class = "country-badge country-kuwait", "Kuwait #36")
                  ),
                  hr(),
                  p("All six GCC countries are now ranked in the IMD World Competitiveness Index.")
                )
              ),
              card(
                card_header("Key Highlights"),
                card_body(
                  class = "highlight-box",
                  tags$ul(style = "margin: 0; padding-left: 1.2rem;",
                          tags$li("UAE climbed to 5th place globally"),
                          tags$li("Saudi Arabia: from 32nd (2021) to 17th (2025)"),
                          tags$li("Qatar maintains top 10 position"),
                          tags$li("Business Efficiency is strongest (Score: 82.6)")
                  )
                )
              )
            ),
            
            layout_columns(
              col_widths = c(7, 5),
              card(
                card_header("GCC in Global Context"),
                card_body(plotlyOutput("home_world_ranking", height = "400px"))
              ),
              card(
                card_header("5-Year Trajectory"),
                card_body(plotlyOutput("home_trajectory", height = "400px"))
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
                    resources and competencies to increase their prosperity."),
                  hr(),
                  h5("Methodology"),
                  p("The ranking is based on 256 criteria across four main factors."),
                  tags$ul(
                    tags$li("Two-thirds from statistical data"),
                    tags$li("One-third from executive surveys"),
                    tags$li("Each factor has 25% weight")
                  )
                )
              ),
              card(
                card_header("The Four Competitiveness Factors"),
                card_body(
                  div(style = "display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;",
                      div(style = "background: #2980b9; color: white; padding: 1rem; border-radius: 8px;",
                          h6("Economic Performance", style = "margin: 0;"),
                          p(style = "margin: 0.5rem 0 0; font-size: 0.85rem;", "Trade, investment, employment")
                      ),
                      div(style = "background: #27ae60; color: white; padding: 1rem; border-radius: 8px;",
                          h6("Government Efficiency", style = "margin: 0;"),
                          p(style = "margin: 0.5rem 0 0; font-size: 0.85rem;", "Finance, policy, institutions")
                      ),
                      div(style = "background: #8e44ad; color: white; padding: 1rem; border-radius: 8px;",
                          h6("Business Efficiency", style = "margin: 0;"),
                          p(style = "margin: 0.5rem 0 0; font-size: 0.85rem;", "Productivity, labor, finance")
                      ),
                      div(style = "background: #e67e22; color: white; padding: 1rem; border-radius: 8px;",
                          h6("Infrastructure", style = "margin: 0;"),
                          p(style = "margin: 0.5rem 0 0; font-size: 0.85rem;", "Tech, science, education")
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
                  div(style = "background: #f0f0f0; padding: 1rem; border-radius: 8px; margin-bottom: 1rem;",
                      h6("Simple Average", style = "color: #377eb8;"),
                      p(style = "margin: 0; font-size: 0.9rem;", "Equal weight to all six countries.")
                  ),
                  div(style = "background: #f0f0f0; padding: 1rem; border-radius: 8px;",
                      h6("GDP-Weighted Average", style = "color: #e41a1c;"),
                      p(style = "margin: 0; font-size: 0.9rem;", "Countries weighted by economic size.")
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
                             tags$tr(tags$td("Source:"), tags$td(tags$strong("IMD"))),
                             tags$tr(tags$td("Year:"), tags$td(tags$strong("2025"))),
                             tags$tr(tags$td("Countries Ranked:"), tags$td(tags$strong("69"))),
                             tags$tr(tags$td("GCC Countries:"), tags$td(tags$strong("6"))),
                             tags$tr(tags$td("Main Factors:"), tags$td(tags$strong("4"))),
                             tags$tr(tags$td("Sub-Factors:"), tags$td(tags$strong("20")))
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
                  p(class = "mb-0", style = "color: #333;", "The GCC would rank among the world's top 15 most competitive economies")
                )
              )
            ),
            
            layout_columns(
              col_widths = c(4, 8),
              card(
                card_header("Aggregation Settings"),
                card_body(
                  radioButtons("agg_method", "Select Method:",
                               choices = c("GDP-Weighted" = "GCC (Weighted)", "Simple Average" = "GCC (Simple)"),
                               selected = "GCC (Weighted)"),
                  hr(),
                  uiOutput("agg_method_description"),
                  hr(),
                  h6("GCC Aggregate Scores"),
                  tableOutput("agg_scores_table")
                )
              ),
              card(
                card_header("GCC Position in World Rankings"),
                card_body(plotlyOutput("agg_world_chart", height = "400px"))
              )
            ),
            
            layout_columns(
              col_widths = c(6, 6),
              card(
                card_header("Simple vs GDP-Weighted Comparison"),
                card_body(plotlyOutput("agg_comparison_chart", height = "350px"))
              ),
              card(
                card_header("GDP Weight Distribution"),
                card_body(plotlyOutput("agg_gdp_pie", height = "350px"))
              )
            ),
            
            layout_columns(
              col_widths = c(12),
              card(
                card_header("Dimension-Level Performance"),
                card_body(plotlyOutput("agg_dimensions_chart", height = "350px"))
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
                  selectInput("selected_country", "Choose a GCC Country:",
                              choices = c("UAE", "Qatar", "Saudi Arabia", "Bahrain", "Kuwait", "Oman"),
                              selected = "UAE"),
                  hr(),
                  uiOutput("country_summary_box")
                )
              ),
              card(
                card_header(textOutput("country_header")),
                card_body(plotlyOutput("country_radar", height = "400px"))
              )
            ),
            
            layout_columns(
              col_widths = c(6, 6),
              card(
                card_header("Dimension Scores & Rankings"),
                card_body(DTOutput("country_dimensions_table"))
              ),
              card(
                card_header("5-Year Factor Rankings"),
                card_body(plotlyOutput("country_trend", height = "350px"))
              )
            ),
            
            layout_columns(
              col_widths = c(12),
              card(
                card_header("Sub-Factor Performance"),
                card_body(
                  selectInput("subfactor_filter", "Filter by Factor:",
                              choices = c("All", "Economic Performance", "Government Efficiency", 
                                          "Business Efficiency", "Infrastructure"),
                              selected = "All", width = "300px"),
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
              
              nav_panel(
                title = "5-Year Trends",
                icon = icon("calendar"),
                layout_columns(
                  col_widths = c(12),
                  card(
                    card_body(
                      pickerInput("trend_countries", "Select Countries:",
                                  choices = c("UAE", "Qatar", "Saudi Arabia", "Bahrain", "Kuwait", "Oman", "GCC Average"),
                                  selected = c("UAE", "Qatar", "Saudi Arabia", "GCC Average"),
                                  multiple = TRUE,
                                  options = list(`actions-box` = TRUE)),
                      plotlyOutput("analysis_trends", height = "450px")
                    )
                  )
                ),
                layout_columns(
                  col_widths = c(6, 6),
                  card(
                    card_header("Performance Summary (2021-2025)"),
                    card_body(DTOutput("analysis_performance_table"))
                  ),
                  card(
                    card_header("Key Insights"),
                    card_body(
                      div(class = "recommendation-card",
                          h5("Biggest Improver"),
                          p("Saudi Arabia improved 15 positions")
                      ),
                      div(class = "recommendation-card",
                          h5("Highest Ranked"),
                          p("UAE reached #5 globally")
                      )
                    )
                  )
                )
              ),
              
              nav_panel(
                title = "Country Comparison",
                icon = icon("th"),
                layout_columns(
                  col_widths = c(12),
                  card(
                    card_header("GCC Countries Competitiveness Heatmap"),
                    card_body(plotlyOutput("analysis_heatmap", height = "400px"))
                  )
                ),
                layout_columns(
                  col_widths = c(12),
                  card(
                    card_header("Full Comparison Table"),
                    card_body(DTOutput("analysis_full_table"))
                  )
                )
              ),
              
              nav_panel(
                title = "Sub-Factor Deep Dive",
                icon = icon("search"),
                layout_columns(
                  col_widths = c(4, 8),
                  card(
                    card_body(
                      selectInput("analysis_factor", "Select Factor:",
                                  choices = c("Economic Performance", "Government Efficiency", 
                                              "Business Efficiency", "Infrastructure"),
                                  selected = "Business Efficiency"),
                      hr(),
                      h6("Sub-Factors:"),
                      uiOutput("subfactor_list")
                    )
                  ),
                  card(
                    card_header("Sub-Factor Comparison"),
                    card_body(plotlyOutput("analysis_subfactor_compare", height = "450px"))
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
                card_body(plotlyOutput("rec_gap_chart", height = "350px"))
              ),
              card(
                card_header("Strengths & Weaknesses"),
                card_body(
                  h6("Top Strengths"),
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
                card_header("Strategic Recommendations"),
                card_body(
                  layout_columns(
                    col_widths = c(6, 6),
                    div(
                      div(class = "recommendation-card",
                          h5("Infrastructure Investment"),
                          p("Close the 15-point gap by accelerating R&D spending and digital infrastructure.")
                      ),
                      div(class = "recommendation-card",
                          h5("Sustainability Leadership"),
                          p("Transform environmental challenges into competitive advantages.")
                      )
                    ),
                    div(
                      div(class = "recommendation-card",
                          h5("Human Capital Development"),
                          p("Strengthen higher education and STEM capabilities.")
                      ),
                      div(class = "recommendation-card",
                          h5("Regional Integration"),
                          p("Deepen economic cooperation across the $2.2 trillion GCC market.")
                      )
                    )
                  )
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
          
        ) # End page_navbar
      ) # End tagList
      
    } # End else (dashboard)
    
  }) # End renderUI
  
  # ===== LOAD DATA =====
  wcr_data <- reactive({ load_wcr_data() })
  
  # ========== HOME TAB OUTPUTS ==========
  output$home_world_ranking <- renderPlotly({
    create_world_ranking_chart(wcr_data(), gcc_method = "GCC (Weighted)", n_countries = 25)
  })
  
  output$home_trajectory <- renderPlotly({
    create_trajectory_chart(wcr_data(), highlight = c("UAE", "Qatar", "Saudi Arabia", "GCC Average"))
  })
  
  # ========== METADATA TAB OUTPUTS ==========
  output$metadata_gdp_table <- renderTable({
    wcr_data()$gdp_weights %>%
      select(Country, `GDP ($ Billion)` = GDP_2024, `Weight (%)` = Weight_Pct) %>%
      arrange(desc(`GDP ($ Billion)`))
  })
  
  # ========== GCC AGGREGATE TAB OUTPUTS ==========
  output$agg_method_description <- renderUI({
    if (input$agg_method == "GCC (Weighted)") {
      div(p(class = "text-muted", style = "font-size: 0.9rem;",
            "GDP-weighted: SAU 50%, UAE 25%, others share remaining 25%."))
    } else {
      div(p(class = "text-muted", style = "font-size: 0.9rem;",
            "Simple average: All six countries weighted equally."))
    }
  })
  
  output$agg_scores_table <- renderTable({
    wcr_data()$factors_2025 %>%
      filter(Country == input$agg_method) %>%
      select(Overall = Overall_Score, `Econ Perf` = EconPerf_Score,
             `Gov Eff` = GovEff_Score, `Bus Eff` = BusEff_Score, Infra = Infra_Score) %>%
      mutate(across(everything(), ~round(., 1)))
  })
  
  output$agg_world_chart <- renderPlotly({
    create_world_ranking_chart(wcr_data(), gcc_method = input$agg_method, n_countries = 30)
  })
  
  output$agg_comparison_chart <- renderPlotly({
    create_comparison_chart(wcr_data())
  })
  
  output$agg_gdp_pie <- renderPlotly({
    create_gdp_pie_chart(wcr_data())
  })
  
  output$agg_dimensions_chart <- renderPlotly({
    create_dimensions_chart(wcr_data(), gcc_method = input$agg_method)
  })
  
  # ========== COUNTRY DATA TAB OUTPUTS ==========
  output$country_header <- renderText({
    paste(input$selected_country, "- Competitiveness Profile")
  })
  
  output$country_summary_box <- renderUI({
    data <- wcr_data()$factors_2025 %>% filter(Country == input$selected_country)
    div(style = "background: #f8f9fa; padding: 1rem; border-radius: 8px;",
        h5(paste("Rank #", data$Overall_Rank), style = "color: #1a5276; margin: 0;"),
        p(paste("Score:", round(data$Overall_Score, 1)), style = "margin: 0.5rem 0 0;")
    )
  })
  
  output$country_radar <- renderPlotly({
    create_country_radar(wcr_data(), input$selected_country)
  })
  
  output$country_dimensions_table <- renderDT({
    wcr_data()$factors_2025 %>%
      filter(Country == input$selected_country) %>%
      select(`Econ Perf Score` = EconPerf_Score, `Econ Perf Rank` = EconPerf_Rank,
             `Gov Eff Score` = GovEff_Score, `Gov Eff Rank` = GovEff_Rank,
             `Bus Eff Score` = BusEff_Score, `Bus Eff Rank` = BusEff_Rank,
             `Infra Score` = Infra_Score, `Infra Rank` = Infra_Rank) %>%
      mutate(across(contains("Score"), ~round(., 1)))
  }, options = list(dom = 't', scrollX = TRUE))
  
  output$country_trend <- renderPlotly({
    create_country_trend(wcr_data(), input$selected_country)
  })
  
  output$country_subfactors <- renderPlotly({
    create_subfactor_chart(wcr_data(), input$selected_country, input$subfactor_filter)
  })
  
  # ========== ANALYSIS TAB OUTPUTS ==========
  output$analysis_trends <- renderPlotly({
    selected <- input$trend_countries
    if (is.null(selected) || length(selected) == 0) {
      selected <- c("UAE", "GCC Average")
    }
    create_trajectory_chart(wcr_data(), highlight = selected)
  })
  
  output$analysis_performance_table <- renderDT({
    wcr_data()$rankings_5yr %>%
      filter(Factor == "Overall", !grepl("GCC", Country)) %>%
      select(Country, `2021` = Y2021, `2022` = Y2022, `2023` = Y2023, `2024` = Y2024, `2025` = Y2025) %>%
      mutate(Change = `2021` - `2025`)
  }, options = list(dom = 't', pageLength = 6))
  
  output$analysis_heatmap <- renderPlotly({
    create_heatmap_chart(wcr_data())
  })
  
  output$analysis_full_table <- renderDT({
    wcr_data()$factors_2025 %>%
      filter(!grepl("GCC", Country)) %>%
      select(Country, Overall_Rank, Overall_Score, EconPerf_Score, GovEff_Score, BusEff_Score, Infra_Score) %>%
      mutate(across(contains("Score"), ~round(., 1))) %>%
      arrange(Overall_Rank)
  }, options = list(dom = 'tp', pageLength = 6))
  
  output$subfactor_list <- renderUI({
    subfactors <- wcr_data()$subfactors_2025 %>%
      filter(Factor == input$analysis_factor) %>%
      distinct(Sub_Factor) %>%
      pull(Sub_Factor)
    tags$ul(lapply(subfactors, tags$li))
  })
  
  output$analysis_subfactor_compare <- renderPlotly({
    subfactor_data <- wcr_data()$subfactors_2025 %>%
      filter(Factor == input$analysis_factor, !grepl("GCC", Country))
    
    country_colors <- c("UAE" = "#000000", "Qatar" = "#99154C", "Saudi Arabia" = "#008035",
                        "Bahrain" = "#E20000", "Kuwait" = "#00B1E6", "Oman" = "#a3a3a3")
    
    plot_ly(data = subfactor_data, x = ~Sub_Factor, y = ~Score_2025, color = ~Country,
            colors = country_colors, type = "bar", text = ~round(Score_2025, 1)) %>%
      layout(xaxis = list(title = "", tickangle = -45),
             yaxis = list(title = "Score", range = c(0, 100)),
             barmode = "group", legend = list(orientation = "h", y = -0.3))
  })
  
  # ========== RECOMMENDATIONS TAB OUTPUTS ==========
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
