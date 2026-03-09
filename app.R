# ============================================================================
# GCC COMPETITIVENESS DASHBOARD - IMD World Competitiveness Ranking 2025
# BILINGUAL VERSION (English / Arabic)
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
source("R/translations.R")

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

    # RTL stylesheet
    tags$link(rel = "stylesheet", href = "rtl.css"),

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

      /* RTL recommendation cards */
      body.rtl-mode .recommendation-card {
        border-left: none;
        border-right: 4px solid #B8A358;
        border-radius: 8px 0 0 8px;
      }

      /* ============================================================
         LANGUAGE TOGGLE STYLES
         ============================================================ */
      .lang-toggle-landing {
        position: fixed;
        top: 20px;
        right: 20px;
        z-index: 10000;
        background: rgba(255,255,255,0.15);
        border: 1px solid rgba(255,255,255,0.4);
        color: white;
        padding: 8px 18px;
        border-radius: 25px;
        font-size: 0.95rem;
        cursor: pointer;
        backdrop-filter: blur(5px);
        transition: all 0.3s ease;
      }
      .lang-toggle-landing:hover {
        background: rgba(255,255,255,0.3);
        color: white;
      }
      body.rtl-mode .lang-toggle-landing {
        right: auto;
        left: 20px;
      }
      .lang-toggle-dashboard {
        background: transparent;
        border: 1px solid rgba(255,255,255,0.5);
        color: white;
        padding: 4px 14px;
        border-radius: 15px;
        font-size: 0.85rem;
        cursor: pointer;
        margin-left: 10px;
      }
      .lang-toggle-dashboard:hover {
        background: rgba(255,255,255,0.2);
        color: white;
      }

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
        background: rgba(0,0,0,0.4);
        z-index: 1;
      }

      /* Hero background images */
      .hero-bg-1 { background-image: url('images/111.jpg'); }
      .hero-bg-2 { background-image: url('images/211.jpg'); }
      .hero-bg-3 { background-image: url('images/311.jpg'); }
      .hero-bg-4 { background-image: url('images/59.jpg'); }
      .hero-bg-5 { background-image: url('images/63.jpg'); }

      /* Content above overlay */
      .landing-logo,
      .landing-title,
      .landing-subtitle,
      .quote-carousel,
      .carousel-dots,
      .enter-btn {
        position: relative;
        z-index: 2;
      }

      /* Logo */
      .landing-logo {
        width: 180px;
        margin-bottom: 20px;
        filter: drop-shadow(0 2px 4px rgba(0,0,0,0.3));
      }

      /* Title */
      .landing-title {
        font-size: 3.5rem;
        font-weight: 700;
        letter-spacing: 4px;
        text-transform: uppercase;
        text-shadow: 2px 2px 8px rgba(0,0,0,0.5);
        margin: 0 0 10px 0;
      }

      /* Subtitle */
      .landing-subtitle {
        font-size: 1.4rem;
        font-weight: 300;
        opacity: 0.95;
        text-shadow: 1px 1px 4px rgba(0,0,0,0.3);
        margin: 0 0 30px 0;
      }

      /* Quote carousel */
      .quote-carousel {
        max-width: 800px;
        font-size: 1.15rem;
        line-height: 1.8;
        font-style: italic;
        opacity: 0.95;
        padding: 30px 40px;
        background: rgba(255,255,255,0.1);
        backdrop-filter: blur(10px);
        border-radius: 12px;
        border: 1px solid rgba(255,255,255,0.2);
        margin: 10px auto 20px auto;
        transition: opacity 0.3s ease;
      }

      /* Carousel dots */
      .carousel-dots {
        display: flex;
        gap: 10px;
        margin-bottom: 25px;
      }

      .carousel-dot {
        width: 12px;
        height: 12px;
        border-radius: 50%;
        background: rgba(255,255,255,0.4);
        border: 2px solid rgba(255,255,255,0.6);
        cursor: pointer;
        transition: all 0.3s ease;
        padding: 0;
      }

      .carousel-dot.active {
        background: white;
        border-color: white;
        transform: scale(1.2);
      }

      /* Enter button */
      .enter-btn {
        padding: 18px 50px;
        font-size: 1.15rem;
        font-weight: 600;
        background: linear-gradient(135deg, #B8A358 0%, #d4c17a 100%);
        color: #1a1a1a;
        border: none;
        border-radius: 30px;
        cursor: pointer;
        transition: all 0.3s ease;
        text-transform: uppercase;
        letter-spacing: 2px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.2);
      }

      .enter-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(0,0,0,0.3);
      }

      /* About Section */
      .landing-about {
        max-width: 900px;
        margin: 0 auto;
        padding: 60px 30px;
        text-align: center;
      }

      .landing-about h2 {
        color: #1a5276;
        font-size: 1.8rem;
        font-weight: 600;
        margin-bottom: 25px;
      }

      .landing-about-text {
        color: #555;
        font-size: 1.05rem;
        line-height: 1.8;
        margin-bottom: 15px;
      }

      /* Stats Row */
      .stats-row {
        display: flex;
        justify-content: center;
        gap: 30px;
        flex-wrap: wrap;
        margin-top: 30px;
      }

      .stat-box {
        background: white;
        border-radius: 12px;
        padding: 25px 40px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        text-align: center;
        min-width: 120px;
      }

      .stat-box .number {
        font-size: 2.5rem;
        font-weight: 700;
        color: #1a5276;
      }

      .stat-box .label {
        font-size: 0.9rem;
        color: #777;
        text-transform: uppercase;
        letter-spacing: 1px;
        margin-top: 5px;
      }

      /* Dimensions Section */
      .dimensions-section {
        background: white;
        padding: 50px 30px;
      }

      .dimensions-section h3 {
        text-align: center;
        color: #1a5276;
        font-weight: 600;
        margin-bottom: 30px;
      }

      .dimension-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        max-width: 1100px;
        margin: 0 auto;
      }

      .dimension-card {
        display: flex;
        align-items: flex-start;
        gap: 15px;
        padding: 20px;
        border-radius: 12px;
        background: #f8f9fa;
        transition: transform 0.3s ease;
      }

      .dimension-card:hover {
        transform: translateY(-3px);
      }

      .dimension-card .fa {
        font-size: 2rem;
        color: #B8A358;
        margin-top: 5px;
      }

      .dimension-card .dim-title {
        font-weight: 600;
        color: #1a5276;
        font-size: 1.05rem;
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

      body.rtl-mode .back-to-welcome {
        right: auto;
        left: 20px;
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

    # ----- JavaScript for Carousel + Language Toggle -----
    tags$script(HTML("
      // ===== Language toggle handler =====
      Shiny.addCustomMessageHandler('setLang', function(lang) {
        if (lang === 'ar') {
          $('body').addClass('rtl-mode').attr('dir', 'rtl');
        } else {
          $('body').removeClass('rtl-mode').attr('dir', 'ltr');
        }
      });

      // ===== Carousel =====
      var quotes = [];
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
        if (carouselInterval) {
          clearInterval(carouselInterval);
        }
        carouselInterval = setInterval(nextQuote, 7000);
      }

      // Handler for setting carousel quotes from server
      Shiny.addCustomMessageHandler('setQuotes', function(data) {
        quotes = data;
        var quoteDisplay = document.getElementById('quote-display');
        if (quoteDisplay && quotes.length > 0) {
          quoteDisplay.textContent = quotes[0];
          quoteDisplay.style.transition = 'opacity 0.3s ease';
          currentQuote = 0;
          startCarousel();
        }
      });

      // Re-initialize when Shiny reconnects (for when user returns to landing page)
      $(document).on('shiny:value', function(event) {
        if (event.name === 'main_ui') {
          setTimeout(function() {
            var quoteDisplay = document.getElementById('quote-display');
            if (quoteDisplay && quotes.length > 0) {
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

  # ===== LANGUAGE STATE =====
  current_lang <- reactiveVal("en")

  observeEvent(input$lang_toggle, {
    new_lang <- if (current_lang() == "en") "ar" else "en"
    current_lang(new_lang)
  })

  # Send language change to JavaScript
  observe({
    session$sendCustomMessage("setLang", current_lang())
  })

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

    lang <- current_lang()
    dir <- get_direction(lang)
    font <- get_font(lang)
    lang_btn_label <- if (lang == "ar") "English" else "\u0639\u0631\u0628\u064A"

    if (!entered_dashboard()) {

      # Send carousel quotes for current language
      session$sendCustomMessage("setQuotes", list(
        t("quote_1", lang),
        t("quote_2", lang),
        t("quote_3", lang),
        t("quote_4", lang),
        t("quote_5", lang)
      ))

      # ===== LANDING PAGE =====
      div(class = "landing-container",

          # Language toggle (fixed position)
          actionButton("lang_toggle", lang_btn_label, class = "lang-toggle-landing"),

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
              h1(class = "landing-title", t("hero_title", lang)),

              # Subtitle
              p(class = "landing-subtitle", t("hero_subtitle", lang)),

              # Rotating Quote Carousel
              div(class = "quote-carousel", id = "quote-display",
                  t("quote_1", lang)
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
              actionButton("enter_dashboard", t("explore_dashboard", lang),
                           class = "enter-btn",
                           icon = icon("arrow-right"))
          ),

          # About Section
          div(class = "landing-about",
              h2(t("landing_about_title", lang)),
              p(class = "landing-about-text", t("landing_about_p1", lang)),
              p(class = "landing-about-text", t("landing_about_p2", lang)),

              # Key statistics
              div(class = "stats-row",
                  div(class = "stat-box",
                      div(class = "number", "6"),
                      div(class = "label", t("gcc_countries_label", lang))
                  ),
                  div(class = "stat-box",
                      div(class = "number", "#12"),
                      div(class = "label", t("global_ranking_label", lang))
                  ),
                  div(class = "stat-box",
                      div(class = "number", "84.9"),
                      div(class = "label", t("gcc_score_label", lang))
                  ),
                  div(class = "stat-box",
                      div(class = "number", "$2.2T"),
                      div(class = "label", t("combined_gdp_label", lang))
                  )
              )
          ),

          # Dimensions Preview Section
          div(class = "dimensions-section",
              h3(t("four_factors_title", lang)),
              div(class = "dimension-grid",
                  div(class = "dimension-card",
                      icon("chart-line"),
                      div(class = "dim-text",
                          div(class = "dim-title", t("economic_performance", lang)),
                          div(class = "dim-desc", t("econ_perf_desc", lang))
                      )
                  ),
                  div(class = "dimension-card",
                      icon("landmark"),
                      div(class = "dim-text",
                          div(class = "dim-title", t("government_efficiency", lang)),
                          div(class = "dim-desc", t("gov_eff_desc", lang))
                      )
                  ),
                  div(class = "dimension-card",
                      icon("briefcase"),
                      div(class = "dim-text",
                          div(class = "dim-title", t("business_efficiency", lang)),
                          div(class = "dim-desc", t("bus_eff_desc", lang))
                      )
                  ),
                  div(class = "dimension-card",
                      icon("building"),
                      div(class = "dim-text",
                          div(class = "dim-title", t("infrastructure", lang)),
                          div(class = "dim-desc", t("infra_desc", lang))
                      )
                  )
              )
          ),

          # Footer
          div(class = "landing-footer",
              p(t("landing_copyright", lang)),
              p(t("landing_datasource", lang))
          )
      )

    } else {

      # ===== DASHBOARD =====
      tagList(
        # Language toggle + Back to Welcome
        actionButton("lang_toggle", lang_btn_label, class = "lang-toggle-landing"),
        actionButton("back_to_welcome", HTML(
          if (lang == "ar") paste0(t("back_to_welcome", lang), " &rarr;")
          else paste0("&larr; ", t("back_to_welcome", lang))
        ), class = "back-to-welcome"),

        # Main Dashboard
        page_navbar(
          title = tags$span(
            tags$img(src = logo_white, height = "35px", style = "margin-right: 10px;"),
            t("app_title", lang)
          ),
          id = "main_nav",
          bg = "#1a5276",

          # ========== TAB 1: HOME ==========
          nav_panel(
            title = t("tab_home", lang),
            icon = icon("home"),

            layout_columns(
              col_widths = c(12),
              card(
                class = "border-0",
                card_body(
                  class = "text-center py-4",
                  style = "background: linear-gradient(135deg, #1a5276 0%, #2980b9 100%); color: white; border-radius: 12px;",
                  h1(t("hero_title", lang), class = "display-4 fw-bold"),
                  p(class = "lead", t("hero_subtitle", lang)),
                  hr(style = "border-color: rgba(255,255,255,0.3); width: 100px; margin: 1.5rem auto;"),
                  p(t("hero_source", lang))
                )
              )
            ),

            layout_columns(
              col_widths = c(3, 3, 3, 3),
              div(class = "metric-box",
                  div(class = "metric-value", "84.9"),
                  div(class = "metric-label", t("gcc_overall_score", lang))
              ),
              div(class = "metric-box",
                  div(class = "metric-value", "#12"),
                  div(class = "metric-label", t("global_ranking_label", lang))
              ),
              div(class = "metric-box",
                  div(class = "metric-value", "$2.2T"),
                  div(class = "metric-label", t("combined_gdp_label", lang))
              ),
              div(class = "metric-box",
                  div(class = "metric-value", "3"),
                  div(class = "metric-label", t("countries_in_top20", lang))
              )
            ),

            layout_columns(
              col_widths = c(6, 6),
              card(
                card_header(t("gcc_member_countries", lang)),
                card_body(
                  div(
                    span(class = "country-badge country-uae", paste(t("uae", lang), "#5")),
                    span(class = "country-badge country-qatar", paste(t("qatar", lang), "#9")),
                    span(class = "country-badge country-saudi", paste(t("saudi_arabia", lang), "#17")),
                    span(class = "country-badge country-bahrain", paste(t("bahrain", lang), "#22")),
                    span(class = "country-badge country-oman", paste(t("oman", lang), "#28")),
                    span(class = "country-badge country-kuwait", paste(t("kuwait", lang), "#36"))
                  ),
                  hr(),
                  p(t("all_six_ranked", lang))
                )
              ),
              card(
                card_header(t("key_highlights", lang)),
                card_body(
                  class = "highlight-box",
                  tags$ul(style = "margin: 0; padding-left: 1.2rem;",
                          tags$li(t("highlight_uae", lang)),
                          tags$li(t("highlight_saudi", lang)),
                          tags$li(t("highlight_qatar", lang)),
                          tags$li(t("highlight_buseff", lang))
                  )
                )
              )
            ),

            layout_columns(
              col_widths = c(7, 5),
              card(
                card_header(t("gcc_global_context", lang)),
                card_body(plotlyOutput("home_world_ranking", height = "400px"))
              ),
              card(
                card_header(t("five_year_trajectory", lang)),
                card_body(plotlyOutput("home_trajectory", height = "400px"))
              )
            )
          ),

          # ========== TAB 2: METADATA ==========
          nav_panel(
            title = t("tab_metadata", lang),
            icon = icon("info-circle"),

            layout_columns(
              col_widths = c(6, 6),
              card(
                card_header(t("about_imd_title", lang)),
                card_body(
                  h5(t("overview", lang)),
                  p(t("about_imd_overview", lang)),
                  hr(),
                  h5(t("methodology", lang)),
                  p(t("methodology_desc", lang)),
                  tags$ul(
                    tags$li(t("method_stat_data", lang)),
                    tags$li(t("method_survey", lang)),
                    tags$li(t("method_equal_weight", lang))
                  )
                )
              ),
              card(
                card_header(t("four_factors", lang)),
                card_body(
                  div(style = "display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;",
                      div(style = "background: #2980b9; color: white; padding: 1rem; border-radius: 8px;",
                          h6(t("economic_performance", lang), style = "margin: 0;"),
                          p(style = "margin: 0.5rem 0 0; font-size: 0.85rem;", t("factor_trade", lang))
                      ),
                      div(style = "background: #27ae60; color: white; padding: 1rem; border-radius: 8px;",
                          h6(t("government_efficiency", lang), style = "margin: 0;"),
                          p(style = "margin: 0.5rem 0 0; font-size: 0.85rem;", t("factor_policy", lang))
                      ),
                      div(style = "background: #8e44ad; color: white; padding: 1rem; border-radius: 8px;",
                          h6(t("business_efficiency", lang), style = "margin: 0;"),
                          p(style = "margin: 0.5rem 0 0; font-size: 0.85rem;", t("factor_productivity", lang))
                      ),
                      div(style = "background: #e67e22; color: white; padding: 1rem; border-radius: 8px;",
                          h6(t("infrastructure", lang), style = "margin: 0;"),
                          p(style = "margin: 0.5rem 0 0; font-size: 0.85rem;", t("factor_tech", lang))
                      )
                  )
                )
              )
            ),

            layout_columns(
              col_widths = c(6, 6),
              card(
                card_header(t("agg_methodology_title", lang)),
                card_body(
                  h5(t("two_approaches", lang)),
                  div(style = "background: #f0f0f0; padding: 1rem; border-radius: 8px; margin-bottom: 1rem;",
                      h6(t("simple_average", lang), style = "color: #377eb8;"),
                      p(style = "margin: 0; font-size: 0.9rem;", t("simple_avg_desc", lang))
                  ),
                  div(style = "background: #f0f0f0; padding: 1rem; border-radius: 8px;",
                      h6(t("gdp_weighted_avg", lang), style = "color: #e41a1c;"),
                      p(style = "margin: 0; font-size: 0.9rem;", t("gdp_weighted_avg_desc", lang))
                  ),
                  hr(),
                  h6(t("gdp_weights_label", lang)),
                  tableOutput("metadata_gdp_table")
                )
              ),
              card(
                card_header(t("data_summary", lang)),
                card_body(
                  h5(t("dataset_info", lang)),
                  tags$table(class = "table table-sm",
                             tags$tr(tags$td(t("source_label", lang)), tags$td(tags$strong("IMD"))),
                             tags$tr(tags$td(t("year_label", lang)), tags$td(tags$strong("2025"))),
                             tags$tr(tags$td(t("countries_ranked_label", lang)), tags$td(tags$strong("69"))),
                             tags$tr(tags$td(t("gcc_countries_count", lang)), tags$td(tags$strong("6"))),
                             tags$tr(tags$td(t("main_factors_label", lang)), tags$td(tags$strong("4"))),
                             tags$tr(tags$td(t("sub_factors_label", lang)), tags$td(tags$strong("20")))
                  )
                )
              )
            )
          ),

          # ========== TAB 3: GCC AGGREGATE ==========
          nav_panel(
            title = t("tab_gcc_aggregate", lang),
            icon = icon("globe"),

            layout_columns(
              col_widths = c(12),
              card(
                card_body(
                  class = "text-center py-3",
                  style = "background: linear-gradient(135deg, #B8A358 0%, #d4c17a 100%); border-radius: 8px;",
                  h3(t("sec2_title", lang), class = "fw-bold mb-2", style = "color: #1a1a1a;"),
                  p(class = "mb-0", style = "color: #333;", t("gcc_single_country_desc", lang))
                )
              )
            ),

            layout_columns(
              col_widths = c(4, 8),
              card(
                card_header(t("aggregation_settings", lang)),
                card_body(
                  radioButtons("agg_method", t("select_method", lang),
                               choices = setNames(
                                 c("GCC (Weighted)", "GCC (Simple)"),
                                 c(t("gdp_weighted", lang), t("simple_average", lang))
                               ),
                               selected = "GCC (Weighted)"),
                  hr(),
                  uiOutput("agg_method_description"),
                  hr(),
                  h6(t("gcc_aggregate_scores", lang)),
                  tableOutput("agg_scores_table")
                )
              ),
              card(
                card_header(t("gcc_world_position", lang)),
                card_body(plotlyOutput("agg_world_chart", height = "400px"))
              )
            ),

            layout_columns(
              col_widths = c(6, 6),
              card(
                card_header(t("simple_vs_gdp", lang)),
                card_body(plotlyOutput("agg_comparison_chart", height = "350px"))
              ),
              card(
                card_header(t("gdp_distribution", lang)),
                card_body(plotlyOutput("agg_gdp_pie", height = "350px"))
              )
            ),

            layout_columns(
              col_widths = c(12),
              card(
                card_header(t("dimension_performance", lang)),
                card_body(plotlyOutput("agg_dimensions_chart", height = "350px"))
              )
            )
          ),

          # ========== TAB 4: COUNTRY DATA ==========
          nav_panel(
            title = t("tab_country_data", lang),
            icon = icon("flag"),

            layout_columns(
              col_widths = c(3, 9),
              card(
                card_header(t("select_country_header", lang)),
                card_body(
                  selectInput("selected_country", t("choose_gcc_country", lang),
                              choices = get_country_choices(lang),
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
                card_header(t("dimension_scores_rankings", lang)),
                card_body(DTOutput("country_dimensions_table"))
              ),
              card(
                card_header(t("five_year_factor", lang)),
                card_body(plotlyOutput("country_trend", height = "350px"))
              )
            ),

            layout_columns(
              col_widths = c(12),
              card(
                card_header(t("subfactor_performance", lang)),
                card_body(
                  selectInput("subfactor_filter", t("filter_by_factor", lang),
                              choices = setNames(
                                c("All", "Economic Performance", "Government Efficiency",
                                  "Business Efficiency", "Infrastructure"),
                                c(t("all_label", lang), t("economic_performance", lang), t("government_efficiency", lang),
                                  t("business_efficiency", lang), t("infrastructure", lang))
                              ),
                              selected = "All", width = "300px"),
                  plotlyOutput("country_subfactors", height = "500px")
                )
              )
            )
          ),

          # ========== TAB 5: ANALYSIS ==========
          nav_panel(
            title = t("tab_analysis", lang),
            icon = icon("chart-line"),

            navset_card_tab(
              title = t("comparative_analysis", lang),

              nav_panel(
                title = t("five_year_trends", lang),
                icon = icon("calendar"),
                layout_columns(
                  col_widths = c(12),
                  card(
                    card_body(
                      pickerInput("trend_countries", t("select_countries_label", lang),
                                  choices = get_country_choices(lang),
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
                    card_header(t("performance_summary", lang)),
                    card_body(DTOutput("analysis_performance_table"))
                  ),
                  card(
                    card_header(t("key_insights", lang)),
                    card_body(
                      div(class = "recommendation-card",
                          h5(t("biggest_improver", lang)),
                          p(t("biggest_improver_desc", lang))
                      ),
                      div(class = "recommendation-card",
                          h5(t("highest_ranked", lang)),
                          p(t("highest_ranked_desc", lang))
                      )
                    )
                  )
                )
              ),

              nav_panel(
                title = t("country_comparison", lang),
                icon = icon("th"),
                layout_columns(
                  col_widths = c(12),
                  card(
                    card_header(t("gcc_heatmap", lang)),
                    card_body(plotlyOutput("analysis_heatmap", height = "400px"))
                  )
                ),
                layout_columns(
                  col_widths = c(12),
                  card(
                    card_header(t("full_comparison_table", lang)),
                    card_body(DTOutput("analysis_full_table"))
                  )
                )
              ),

              nav_panel(
                title = t("subfactor_deep_dive", lang),
                icon = icon("search"),
                layout_columns(
                  col_widths = c(4, 8),
                  card(
                    card_body(
                      selectInput("analysis_factor", t("select_factor", lang),
                                  choices = setNames(
                                    c("Economic Performance", "Government Efficiency",
                                      "Business Efficiency", "Infrastructure"),
                                    c(t("economic_performance", lang), t("government_efficiency", lang),
                                      t("business_efficiency", lang), t("infrastructure", lang))
                                  ),
                                  selected = "Business Efficiency"),
                      hr(),
                      h6(t("subfactors_label", lang)),
                      uiOutput("subfactor_list")
                    )
                  ),
                  card(
                    card_header(t("subfactor_comparison", lang)),
                    card_body(plotlyOutput("analysis_subfactor_compare", height = "450px"))
                  )
                )
              )
            )
          ),

          # ========== TAB 6: RECOMMENDATIONS ==========
          nav_panel(
            title = t("tab_recommendations", lang),
            icon = icon("lightbulb"),

            layout_columns(
              col_widths = c(12),
              card(
                card_body(
                  class = "text-center py-3",
                  style = "background: linear-gradient(135deg, #1a5276 0%, #2980b9 100%); color: white; border-radius: 8px;",
                  h3(t("sec8_title", lang), class = "fw-bold mb-2"),
                  p(class = "mb-0", t("can_gcc_top10", lang))
                )
              )
            ),

            layout_columns(
              col_widths = c(6, 6),
              card(
                card_header(t("gap_analysis", lang)),
                card_body(plotlyOutput("rec_gap_chart", height = "350px"))
              ),
              card(
                card_header(t("strengths_weaknesses", lang)),
                card_body(
                  h6(t("top_strengths", lang)),
                  DTOutput("rec_strengths_table"),
                  hr(),
                  h6(t("areas_improvement", lang)),
                  DTOutput("rec_weaknesses_table")
                )
              )
            ),

            layout_columns(
              col_widths = c(12),
              card(
                card_header(t("strategic_recommendations", lang)),
                card_body(
                  layout_columns(
                    col_widths = c(6, 6),
                    div(
                      div(class = "recommendation-card",
                          h5(t("rec_infrastructure", lang)),
                          p(t("rec_infra_short", lang))
                      ),
                      div(class = "recommendation-card",
                          h5(t("rec_sustainability", lang)),
                          p(t("rec_sustain_short", lang))
                      )
                    ),
                    div(
                      div(class = "recommendation-card",
                          h5(t("rec_human_capital", lang)),
                          p(t("rec_human_short", lang))
                      ),
                      div(class = "recommendation-card",
                          h5(t("rec_integration", lang)),
                          p(t("rec_integration_short", lang))
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
                      t("nav_footer", lang))
          )

        ) # End page_navbar
      ) # End tagList

    } # End else (dashboard)

  }) # End renderUI

  # ===== LOAD DATA =====
  wcr_data <- reactive({ load_wcr_data() })

  # ========== HOME TAB OUTPUTS ==========
  output$home_world_ranking <- renderPlotly({
    create_world_ranking_chart(wcr_data(), gcc_method = "GCC (Weighted)", n_countries = 25, lang = current_lang())
  })

  output$home_trajectory <- renderPlotly({
    create_trajectory_chart(wcr_data(), highlight = c("UAE", "Qatar", "Saudi Arabia", "GCC Average"), lang = current_lang())
  })

  # ========== METADATA TAB OUTPUTS ==========
  output$metadata_gdp_table <- renderTable({
    lang <- current_lang()
    df <- wcr_data()$gdp_weights %>%
      select(Country, GDP_2024, Weight_Pct) %>%
      arrange(desc(GDP_2024))
    df$Country <- translate_countries(df$Country, lang)
    names(df) <- c(t("country", lang), t("col_gdp_billion", lang), t("col_weight_pct", lang))
    df
  })

  # ========== GCC AGGREGATE TAB OUTPUTS ==========
  output$agg_method_description <- renderUI({
    lang <- current_lang()
    if (input$agg_method == "GCC (Weighted)") {
      div(p(class = "text-muted", style = "font-size: 0.9rem;", t("gdp_weighted_method_desc", lang)))
    } else {
      div(p(class = "text-muted", style = "font-size: 0.9rem;", t("simple_method_desc", lang)))
    }
  })

  output$agg_scores_table <- renderTable({
    lang <- current_lang()
    df <- wcr_data()$factors_2025 %>%
      filter(Country == input$agg_method) %>%
      select(Overall_Score, EconPerf_Score, GovEff_Score, BusEff_Score, Infra_Score) %>%
      mutate(across(everything(), ~round(., 1)))
    names(df) <- c(t("col_overall", lang), t("col_econ_perf", lang), t("col_gov_eff", lang),
                   t("col_bus_eff", lang), t("col_infra", lang))
    df
  })

  output$agg_world_chart <- renderPlotly({
    create_world_ranking_chart(wcr_data(), gcc_method = input$agg_method, n_countries = 30, lang = current_lang())
  })

  output$agg_comparison_chart <- renderPlotly({
    create_comparison_chart(wcr_data(), lang = current_lang())
  })

  output$agg_gdp_pie <- renderPlotly({
    create_gdp_pie_chart(wcr_data(), lang = current_lang())
  })

  output$agg_dimensions_chart <- renderPlotly({
    create_dimensions_chart(wcr_data(), gcc_method = input$agg_method, lang = current_lang())
  })

  # ========== COUNTRY DATA TAB OUTPUTS ==========
  output$country_header <- renderText({
    lang <- current_lang()
    paste(translate_country(input$selected_country, lang), "-", t("competitiveness_profile", lang))
  })

  output$country_summary_box <- renderUI({
    lang <- current_lang()
    data <- wcr_data()$factors_2025 %>% filter(Country == input$selected_country)
    div(style = "background: #f8f9fa; padding: 1rem; border-radius: 8px;",
        h5(paste(t("rank_label", lang), data$Overall_Rank), style = "color: #1a5276; margin: 0;"),
        p(paste(t("score_label", lang), round(data$Overall_Score, 1)), style = "margin: 0.5rem 0 0;")
    )
  })

  output$country_radar <- renderPlotly({
    create_country_radar(wcr_data(), input$selected_country, lang = current_lang())
  })

  output$country_dimensions_table <- renderDT({
    lang <- current_lang()
    df <- wcr_data()$factors_2025 %>%
      filter(Country == input$selected_country) %>%
      select(EconPerf_Score, EconPerf_Rank, GovEff_Score, GovEff_Rank,
             BusEff_Score, BusEff_Rank, Infra_Score, Infra_Rank) %>%
      mutate(across(contains("Score"), ~round(., 1)))
    names(df) <- c(t("col_econ_perf_score", lang), t("col_econ_perf_rank", lang),
                   t("col_gov_eff_score", lang), t("col_gov_eff_rank", lang),
                   t("col_bus_eff_score", lang), t("col_bus_eff_rank", lang),
                   t("col_infra_score", lang), t("col_infra_rank", lang))
    df
  }, options = list(dom = 't', scrollX = TRUE), rownames = FALSE)

  output$country_trend <- renderPlotly({
    create_country_trend(wcr_data(), input$selected_country, lang = current_lang())
  })

  output$country_subfactors <- renderPlotly({
    create_subfactor_chart(wcr_data(), input$selected_country, input$subfactor_filter, lang = current_lang())
  })

  # ========== ANALYSIS TAB OUTPUTS ==========
  output$analysis_trends <- renderPlotly({
    selected <- input$trend_countries
    if (is.null(selected) || length(selected) == 0) {
      selected <- c("UAE", "GCC Average")
    }
    create_trajectory_chart(wcr_data(), highlight = selected, lang = current_lang())
  })

  output$analysis_performance_table <- renderDT({
    lang <- current_lang()
    df <- wcr_data()$rankings_5yr %>%
      filter(Factor == "Overall", !grepl("GCC", Country)) %>%
      select(Country, Y2021, Y2022, Y2023, Y2024, Y2025) %>%
      mutate(Change = Y2021 - Y2025)
    df$Country <- translate_countries(df$Country, lang)
    names(df) <- c(t("country", lang), "2021", "2022", "2023", "2024", "2025", t("col_change", lang))
    df
  }, options = list(dom = 't', pageLength = 6))

  output$analysis_heatmap <- renderPlotly({
    create_heatmap_chart(wcr_data(), lang = current_lang())
  })

  output$analysis_full_table <- renderDT({
    lang <- current_lang()
    df <- wcr_data()$factors_2025 %>%
      filter(!grepl("GCC", Country)) %>%
      select(Country, Overall_Rank, Overall_Score, EconPerf_Score, GovEff_Score, BusEff_Score, Infra_Score) %>%
      mutate(across(contains("Score"), ~round(., 1))) %>%
      arrange(Overall_Rank)
    df$Country <- translate_countries(df$Country, lang)
    names(df) <- c(t("country", lang), t("col_overall_rank", lang), t("col_overall_score", lang),
                   t("col_econ_perf", lang), t("col_gov_eff", lang), t("col_bus_eff", lang), t("col_infra", lang))
    df
  }, options = list(dom = 'tp', pageLength = 6))

  output$subfactor_list <- renderUI({
    subfactors <- wcr_data()$subfactors_2025 %>%
      filter(Factor == input$analysis_factor) %>%
      distinct(Sub_Factor) %>%
      pull(Sub_Factor)
    tags$ul(lapply(subfactors, tags$li))
  })

  output$analysis_subfactor_compare <- renderPlotly({
    lang <- current_lang()
    subfactor_data <- wcr_data()$subfactors_2025 %>%
      filter(Factor == input$analysis_factor, !grepl("GCC", Country))

    # Translate country names for display
    subfactor_data$Country <- translate_countries(subfactor_data$Country, lang)

    country_colors_local <- c()
    country_colors_local[translate_country("UAE", lang)] <- "#000000"
    country_colors_local[translate_country("Qatar", lang)] <- "#99154C"
    country_colors_local[translate_country("Saudi Arabia", lang)] <- "#008035"
    country_colors_local[translate_country("Bahrain", lang)] <- "#E20000"
    country_colors_local[translate_country("Kuwait", lang)] <- "#00B1E6"
    country_colors_local[translate_country("Oman", lang)] <- "#a3a3a3"

    plot_ly(data = subfactor_data, x = ~Sub_Factor, y = ~Score_2025, color = ~Country,
            colors = country_colors_local, type = "bar", text = ~round(Score_2025, 1)) %>%
      layout(xaxis = list(title = "", tickangle = -45),
             yaxis = list(title = t("score", lang), range = c(0, 100)),
             barmode = "group", legend = list(orientation = "h", y = -0.3),
             font = list(family = get_font(lang)))
  })

  # ========== RECOMMENDATIONS TAB OUTPUTS ==========
  output$rec_gap_chart <- renderPlotly({
    create_gap_chart(wcr_data(), gcc_method = "GCC (Weighted)", lang = current_lang())
  })

  output$rec_strengths_table <- renderDT({
    lang <- current_lang()
    df <- wcr_data()$subfactors_2025 %>%
      filter(Country == "GCC (Weighted)") %>%
      arrange(desc(Score_2025)) %>%
      head(5) %>%
      select(Factor, Sub_Factor, Score_2025) %>%
      mutate(Score_2025 = round(Score_2025, 1))
    names(df) <- c(t("col_factor", lang), t("col_subfactor", lang), t("score", lang))
    df
  }, options = list(dom = 't', pageLength = 5))

  output$rec_weaknesses_table <- renderDT({
    lang <- current_lang()
    df <- wcr_data()$subfactors_2025 %>%
      filter(Country == "GCC (Weighted)") %>%
      arrange(Score_2025) %>%
      head(5) %>%
      select(Factor, Sub_Factor, Score_2025) %>%
      mutate(Score_2025 = round(Score_2025, 1))
    names(df) <- c(t("col_factor", lang), t("col_subfactor", lang), t("score", lang))
    df
  }, options = list(dom = 't', pageLength = 5))

}

# ============================================================================
# RUN APP
# ============================================================================
shinyApp(ui = ui, server = server)
