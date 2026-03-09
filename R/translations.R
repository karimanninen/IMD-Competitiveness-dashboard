# ============================================================================
# TRANSLATION SYSTEM FOR BILINGUAL GCC COMPETITIVENESS DASHBOARD
# English - Arabic
# ============================================================================

# ============================================================================
# TRANSLATION DICTIONARY
# ============================================================================

translations <- list(
  
  # === GENERAL / NAVIGATION ===
  app_title = list(
    en = "GCC Competitiveness Dashboard",
    ar = "لوحة تنافسية دول مجلس التعاون"
  ),
  language_label = list(
    en = "Language",
    ar = "اللغة"
  ),
  scroll_to_explore = list(
    en = "Scroll to explore the data story",
    ar = "مرر لأسفل لاستكشاف قصة البيانات"
  ),
  
  # === HERO SECTION ===
  hero_title = list(
    en = "STRONGER TOGETHER",
    ar = "معاً أقوى"
  ),
  hero_subtitle = list(
    en = "How the GCC Became a Global Economic Force",
    ar = "كيف أصبح مجلس التعاون الخليجي قوة اقتصادية عالمية"
  ),
  hero_source = list(
    en = "IMD World Competitiveness Ranking 2025",
    ar = "تصنيف التنافسية العالمية IMD 2025"
  ),
  
  # === SECTION 2: GLOBAL RANKING ===
  sec2_title = list(
    en = "If the GCC Were a Single Country...",
    ar = "لو كان مجلس التعاون دولة واحدة..."
  ),
  sec2_narrative = list(
    en = "With a combined GDP of $2.2 trillion, the six Gulf Cooperation Council nations have achieved what few regional blocs can claim: competitiveness that rivals established economic powerhouses.",
    ar = "بناتج محلي إجمالي يبلغ 2.2 تريليون دولار، حققت دول مجلس التعاون الخليجي الست ما لم تستطع سوى تكتلات إقليمية قليلة تحقيقه: تنافسية تضاهي القوى الاقتصادية الراسخة."
  ),
  sec2_callout = list(
    en = "Our analysis reveals that when treated as a unified entity, the GCC scores 84.9 out of 100—placing it ahead of the United States, Finland, and Iceland.",
    ar = "يكشف تحليلنا أنه عند التعامل مع المجلس ككيان موحد، يحقق مجلس التعاون 84.9 من 100 نقطة—متقدماً على الولايات المتحدة وفنلندا وآيسلندا."
  ),
  aggregation_method = list(
    en = "Aggregation Method:",
    ar = "طريقة التجميع:"
  ),
  simple_average = list(
    en = "Simple Average",
    ar = "المتوسط البسيط"
  ),
  gdp_weighted = list(
    en = "GDP-Weighted",
    ar = "الموزون بالناتج المحلي"
  ),
  method_gdp_weights = list(
    en = "GDP weights: SAU 50% | UAE 25% | QAT 10% | KWT 7% | OMN 5% | BHR 2%",
    ar = "أوزان الناتج المحلي: السعودية 50% | الإمارات 25% | قطر 10% | الكويت 7% | عُمان 5% | البحرين 2%"
  ),
  method_gdp_explanation = list(
    en = "Saudi Arabia's $1.1 trillion economy significantly influences the regional aggregate.",
    ar = "يؤثر اقتصاد السعودية البالغ 1.1 تريليون دولار بشكل كبير على المؤشر الإقليمي."
  ),
  method_simple_weights = list(
    en = "Simple average: All 6 countries weighted equally",
    ar = "المتوسط البسيط: جميع الدول الست بأوزان متساوية"
  ),
  method_simple_explanation = list(
    en = "Smaller high-performers (UAE, Qatar) have equal influence to larger economies.",
    ar = "الدول الأصغر ذات الأداء العالي (الإمارات، قطر) لها تأثير مساوٍ للاقتصادات الأكبر."
  ),
  slider_note = list(
    en = "Use the slider below the chart to explore all 69 countries",
    ar = "استخدم شريط التمرير أسفل الرسم البياني لاستكشاف جميع الدول الـ69"
  ),
  
  # === SECTION 3: TRAJECTORY ===
  sec3_title = list(
    en = "Remarkable Trajectories",
    ar = "مسارات استثنائية"
  ),
  sec3_narrative = list(
    en = "Between 2021 and 2025, the GCC demonstrated unprecedented upward momentum.",
    ar = "بين عامي 2021 و2025، أظهر مجلس التعاون زخماً تصاعدياً غير مسبوق."
  ),
  sec3_uae = list(
    en = "UAE climbed from 9th to 5th place",
    ar = "صعدت الإمارات من المركز التاسع إلى الخامس"
  ),
  sec3_qatar = list(
    en = "Qatar surged eight positions to reach 9th globally",
    ar = "قفزت قطر ثمانية مراكز لتصل إلى المركز التاسع عالمياً"
  ),
  sec3_saudi = list(
    en = "Saudi Arabia achieved the region's most dramatic transformation—leaping 15 positions from 32nd to 17th",
    ar = "حققت السعودية أكثر تحولات المنطقة دراماتيكية—قفزة 15 مركزاً من 32 إلى 17"
  ),
  sec3_newcomers = list(
    en = "Even relative newcomers to the survey like Bahrain, Kuwait, and Oman have quickly established themselves in the global top 40.",
    ar = "حتى الوافدون الجدد نسبياً مثل البحرين والكويت وعُمان رسّخوا أنفسهم بسرعة ضمن الأربعين الأوائل عالمياً."
  ),
  highlight_countries = list(
    en = "Highlight Countries:",
    ar = "إبراز الدول:"
  ),
  all_countries = list(
    en = "All",
    ar = "الكل"
  ),
  countries_selected = list(
    en = "countries selected",
    ar = "دول مختارة"
  ),
  
  # === SECTION 4: KEY FACT ===
  sec4_label = list(
    en = "Did You Know?",
    ar = "هل تعلم؟"
  ),
  sec4_number_label = list(
    en = "GCC Countries in the Global Top 20",
    ar = "دول خليجية في العشرين الأوائل عالمياً"
  ),
  sec4_description = list(
    en = "UAE, Qatar, and Saudi Arabia now rank in the global top 20—a remarkable concentration of competitiveness in a region of just 60 million people.",
    ar = "تحتل الإمارات وقطر والسعودية مراتب ضمن العشرين الأوائل عالمياً—تركيز استثنائي للتنافسية في منطقة لا يتجاوز عدد سكانها 60 مليون نسمة."
  ),
  
  # === SECTION 5: STRENGTHS ===
  sec5_title = list(
    en = "Business Efficiency & Government Effectiveness",
    ar = "كفاءة الأعمال وفعالية الحكومة"
  ),
  sec5_subtitle = list(
    en = "The GCC's Secret Weapons",
    ar = "الأسلحة السرية لمجلس التعاون"
  ),
  sec5_narrative = list(
    en = "The GCC's success isn't uniform—it's strategic. The region scores highest in Business Efficiency (82.6, ranking 11th globally) and Government Efficiency (74.9, ranking 13th).",
    ar = "نجاح مجلس التعاون ليس موحداً—بل استراتيجي. تحقق المنطقة أعلى الدرجات في كفاءة الأعمال (82.6، المرتبة 11 عالمياً) وكفاءة الحكومة (74.9، المرتبة 13)."
  ),
  sec5_narrative2 = list(
    en = "This reflects decades of investment in streamlined regulations, low corporate taxation, and adaptive governance. These are the foundations that have attracted trillion-dollar foreign investment and positioned the GCC as a global business hub.",
    ar = "يعكس هذا عقوداً من الاستثمار في تبسيط الأنظمة، وخفض الضرائب على الشركات، والحوكمة المرنة. هذه الأسس جذبت استثمارات أجنبية بتريليونات الدولارات ووضعت مجلس التعاون كمركز أعمال عالمي."
  ),
  
  # === SECTION 5B: RADAR COMPARISON ===
  sec5b_title = list(
    en = "Dimension Deep Dive",
    ar = "التعمق في الأبعاد"
  ),
  sec5b_subtitle = list(
    en = "Compare GCC with Individual Countries",
    ar = "مقارنة مجلس التعاون مع الدول الفردية"
  ),
  sec5b_narrative = list(
    en = "Explore how individual GCC countries perform across the four competitiveness dimensions compared to the regional aggregate.",
    ar = "استكشف أداء كل دولة خليجية عبر أبعاد التنافسية الأربعة مقارنة بالمجموع الإقليمي."
  ),
  sec5b_instruction = list(
    en = "Select a country to see its strengths and areas for improvement relative to the GDP-weighted GCC benchmark.",
    ar = "اختر دولة لمعرفة نقاط قوتها ومجالات التحسين مقارنة بمعيار مجلس التعاون الموزون."
  ),
  select_country = list(
    en = "Select Country to Compare:",
    ar = "اختر الدولة للمقارنة:"
  ),
  comparison_vs = list(
    en = "vs",
    ar = "مقابل"
  ),
  overall_label = list(
    en = "Overall:",
    ar = "الإجمالي:"
  ),
  strongest_label = list(
    en = "Strongest:",
    ar = "الأقوى:"
  ),
  gap_label = list(
    en = "Gap:",
    ar = "الفجوة:"
  ),
  points = list(
    en = "points",
    ar = "نقطة"
  ),
  
  # === SECTION 6: COUNTRY PROFILES ===
  sec6_title = list(
    en = "Six Nations, Complementary Strengths",
    ar = "ست دول، نقاط قوة متكاملة"
  ),
  sec6_narrative = list(
    en = "While united in upward trajectory, each GCC country brings unique strengths to the regional competitiveness profile.",
    ar = "بينما تتحد في المسار التصاعدي، تضيف كل دولة خليجية نقاط قوة فريدة للملف التنافسي الإقليمي."
  ),
  sec6_uae = list(
    en = "UAE leads in overall performance and economic dynamism",
    ar = "الإمارات تتصدر في الأداء العام والديناميكية الاقتصادية"
  ),
  sec6_qatar = list(
    en = "Qatar excels in business efficiency and government effectiveness",
    ar = "قطر تتفوق في كفاءة الأعمال وفعالية الحكومة"
  ),
  sec6_saudi = list(
    en = "Saudi Arabia's massive economy provides scale and diversification",
    ar = "اقتصاد السعودية الضخم يوفر الحجم والتنويع"
  ),
  sec6_conclusion = list(
    en = "Together, they create a complementary ecosystem where investors can find exactly the competitive advantages they need.",
    ar = "معاً، يشكّلون منظومة متكاملة يجد فيها المستثمرون المزايا التنافسية التي يحتاجونها."
  ),
  
  # === SECTION 7: GAP ANALYSIS ===
  sec7_title = list(
    en = "GCC Scores by Dimension",
    ar = "درجات مجلس التعاون حسب البُعد"
  ),
  sec7_narrative = list(
    en = "When we weight countries by their economic size, Saudi Arabia's massive $1.1 trillion economy significantly influences the regional picture.",
    ar = "عندما نُرجّح الدول بحسب حجمها الاقتصادي، يؤثر اقتصاد السعودية الضخم البالغ 1.1 تريليون دولار بشكل كبير على الصورة الإقليمية."
  ),
  sec7_narrative2 = list(
    en = "This GDP-weighted analysis shows that while smaller nations like UAE and Qatar punch above their weight in rankings, Saudi Arabia's scale and improving performance define the region's aggregate competitiveness.",
    ar = "يُظهر هذا التحليل الموزون أنه بينما تتفوق دول أصغر كالإمارات وقطر على حجمها في الترتيب، فإن حجم السعودية وأداءها المتحسن يحددان التنافسية الإقليمية المجمعة."
  ),
  sec7_callout = list(
    en = "The gap analysis reveals clear opportunities: infrastructure development and continued economic diversification could push the unified GCC score above 90.",
    ar = "يكشف تحليل الفجوات عن فرص واضحة: يمكن لتطوير البنية التحتية ومواصلة التنويع الاقتصادي رفع درجة مجلس التعاون الموحد فوق 90."
  ),
  
  # === SECTION 8: 2030 HORIZON ===
  sec8_title = list(
    en = "The 2030 Horizon",
    ar = "أفق 2030"
  ),
  sec8_subtitle = list(
    en = "Can the GCC Break Into the Global Top 10?",
    ar = "هل يستطيع مجلس التعاون الدخول إلى العشرة الأوائل عالمياً؟"
  ),
  sec8_narrative = list(
    en = "Current trajectories suggest the GCC isn't finished climbing. With strategic focus on three areas—infrastructure modernization, R&D investment, and sustainable development—the region could achieve a unified score above 90 by 2030.",
    ar = "تشير المسارات الحالية إلى أن مجلس التعاون لم ينتهِ من الصعود بعد. بالتركيز الاستراتيجي على ثلاثة مجالات—تحديث البنية التحتية، والاستثمار في البحث والتطوير، والتنمية المستدامة—يمكن للمنطقة تحقيق درجة موحدة تتجاوز 90 بحلول 2030."
  ),
  sec8_foundation = list(
    en = "The foundation is solid: world-class business environments, efficient governments, and the financial resources to invest in future competitiveness.",
    ar = "الأساس متين: بيئات أعمال عالمية المستوى، وحكومات كفؤة، وموارد مالية للاستثمار في التنافسية المستقبلية."
  ),
  
  # === RECOMMENDATIONS ===
  rec_title = list(
    en = "Strategic Recommendations",
    ar = "التوصيات الاستراتيجية"
  ),
  rec_infrastructure = list(
    en = "Infrastructure Investment",
    ar = "الاستثمار في البنية التحتية"
  ),
  rec_infrastructure_desc = list(
    en = "Close the 15-point gap by accelerating R&D spending, digital infrastructure, and green energy transitions",
    ar = "سد فجوة الـ15 نقطة من خلال تسريع الإنفاق على البحث والتطوير والبنية التحتية الرقمية والتحول نحو الطاقة النظيفة"
  ),
  rec_sustainability = list(
    en = "Sustainability Leadership",
    ar = "الريادة في الاستدامة"
  ),
  rec_sustainability_desc = list(
    en = "Transform environmental challenges into competitive advantages through aggressive renewable energy deployment",
    ar = "تحويل التحديات البيئية إلى مزايا تنافسية من خلال النشر المكثف للطاقة المتجددة"
  ),
  rec_human_capital = list(
    en = "Human Capital Development",
    ar = "تنمية رأس المال البشري"
  ),
  rec_human_capital_desc = list(
    en = "Strengthen higher education systems and STEM capabilities to reduce dependency on imported talent",
    ar = "تعزيز منظومات التعليم العالي وقدرات العلوم والتقنية والهندسة والرياضيات لتقليل الاعتماد على الكفاءات المستوردة"
  ),
  rec_integration = list(
    en = "Regional Integration",
    ar = "التكامل الإقليمي"
  ),
  rec_integration_desc = list(
    en = "Deepen economic cooperation to create true economies of scale across the $2.2 trillion GCC market",
    ar = "تعميق التعاون الاقتصادي لخلق اقتصاديات حجم حقيقية عبر سوق مجلس التعاون البالغ 2.2 تريليون دولار"
  ),
  
  # === FOOTER ===
  footer_source = list(
    en = "GCC Statistical Center | IMD World Competitiveness Ranking 2025",
    ar = "المركز الإحصائي لدول مجلس التعاون | تصنيف التنافسية العالمية IMD 2025"
  ),
  footer_prepared = list(
    en = "Data story prepared by the Economic Statistics Department",
    ar = "قصة البيانات من إعداد إدارة الإحصاءات الاقتصادية"
  ),
  
  # === COUNTRY NAMES ===
  uae = list(en = "UAE", ar = "الإمارات"),
  qatar = list(en = "Qatar", ar = "قطر"),
  saudi_arabia = list(en = "Saudi Arabia", ar = "السعودية"),
  bahrain = list(en = "Bahrain", ar = "البحرين"),
  kuwait = list(en = "Kuwait", ar = "الكويت"),
  oman = list(en = "Oman", ar = "عُمان"),
  gcc = list(en = "GCC", ar = "مجلس التعاون"),
  gcc_average = list(en = "GCC Average", ar = "متوسط مجلس التعاون"),
  gcc_simple = list(en = "GCC (Simple)", ar = "مجلس التعاون (بسيط)"),
  gcc_weighted = list(en = "GCC (Weighted)", ar = "مجلس التعاون (موزون)"),
  
  # === OTHER COUNTRY NAMES (for world rankings chart) ===
  switzerland = list(en = "Switzerland", ar = "سويسرا"),
  singapore = list(en = "Singapore", ar = "سنغافورة"),
  hong_kong = list(en = "Hong Kong SAR", ar = "هونغ كونغ"),
  denmark = list(en = "Denmark", ar = "الدنمارك"),
  taiwan = list(en = "Taiwan (Chinese Taipei)", ar = "تايوان"),
  ireland = list(en = "Ireland", ar = "أيرلندا"),
  sweden = list(en = "Sweden", ar = "السويد"),
  netherlands = list(en = "Netherlands", ar = "هولندا"),
  canada = list(en = "Canada", ar = "كندا"),
  norway = list(en = "Norway", ar = "النرويج"),
  usa = list(en = "USA", ar = "الولايات المتحدة"),
  finland = list(en = "Finland", ar = "فنلندا"),
  iceland = list(en = "Iceland", ar = "آيسلندا"),
  china = list(en = "China", ar = "الصين"),
  australia = list(en = "Australia", ar = "أستراليا"),
  germany = list(en = "Germany", ar = "ألمانيا"),
  luxembourg = list(en = "Luxembourg", ar = "لوكسمبورغ"),
  lithuania = list(en = "Lithuania", ar = "ليتوانيا"),
  malaysia = list(en = "Malaysia", ar = "ماليزيا"),
  belgium = list(en = "Belgium", ar = "بلجيكا"),
  czech_republic = list(en = "Czech Republic", ar = "التشيك"),
  austria = list(en = "Austria", ar = "النمسا"),
  korea = list(en = "Korea Rep.", ar = "كوريا الجنوبية"),
  united_kingdom = list(en = "United Kingdom", ar = "المملكة المتحدة"),
  thailand = list(en = "Thailand", ar = "تايلاند"),
  new_zealand = list(en = "New Zealand", ar = "نيوزيلندا"),
  france = list(en = "France", ar = "فرنسا"),
  estonia = list(en = "Estonia", ar = "إستونيا"),
  kazakhstan = list(en = "Kazakhstan", ar = "كازاخستان"),
  japan = list(en = "Japan", ar = "اليابان"),
  portugal = list(en = "Portugal", ar = "البرتغال"),
  latvia = list(en = "Latvia", ar = "لاتفيا"),
  spain = list(en = "Spain", ar = "إسبانيا"),
  indonesia = list(en = "Indonesia", ar = "إندونيسيا"),
  india = list(en = "India", ar = "الهند"),
  
  # === DIMENSION NAMES ===
  overall = list(en = "Overall", ar = "الإجمالي"),
  economic_performance = list(en = "Economic Performance", ar = "الأداء الاقتصادي"),
  economic_performance_br = list(en = "Economic\nPerformance", ar = "الأداء\nالاقتصادي"),
  government_efficiency = list(en = "Government Efficiency", ar = "كفاءة الحكومة"),
  government_efficiency_br = list(en = "Government\nEfficiency", ar = "كفاءة\nالحكومة"),
  business_efficiency = list(en = "Business Efficiency", ar = "كفاءة الأعمال"),
  business_efficiency_br = list(en = "Business\nEfficiency", ar = "كفاءة\nالأعمال"),
  infrastructure = list(en = "Infrastructure", ar = "البنية التحتية"),
  
  # === CHART LABELS ===
  score = list(en = "Score", ar = "الدرجة"),
  rank = list(en = "Rank", ar = "المرتبة"),
  year = list(en = "Year", ar = "السنة"),
  country = list(en = "Country", ar = "الدولة"),
  dimension = list(en = "Dimension", ar = "البُعد"),
  percentage = list(en = "Percentage", ar = "النسبة المئوية"),
  achieved = list(en = "Achieved", ar = "المحقق"),
  gap_to_100 = list(en = "Gap to 100", ar = "الفجوة إلى 100"),
  competitiveness_score = list(en = "Competitiveness Score", ar = "درجة التنافسية"),
  global_rank = list(en = "Global Rank (Lower is Better)", ar = "المرتبة العالمية (الأقل أفضل)"),
  average_rank = list(en = "Average Rank (lower is better)", ar = "متوسط المرتبة (الأقل أفضل)"),
  
  # === CHART TITLES ===
  chart_world_title = list(
    en = "GCC as a Unified Entity: World Ranking Position",
    ar = "مجلس التعاون ككيان موحد: موقعه في التصنيف العالمي"
  ),
  chart_world_subtitle = list(
    en = "If GCC were a single country, where would it rank globally?",
    ar = "لو كان مجلس التعاون دولة واحدة، ما مرتبته عالمياً؟"
  ),
  chart_trajectory_title = list(
    en = "GCC Competitiveness Journey: From 2021 to 2025",
    ar = "مسيرة تنافسية مجلس التعاون: من 2021 إلى 2025"
  ),
  chart_trajectory_subtitle = list(
    en = "Tracking each country's ranking trajectory in the global arena",
    ar = "تتبع مسار ترتيب كل دولة في الساحة العالمية"
  ),
  chart_dimensions_title = list(
    en = "GCC GDP-Weighted Competitiveness Performance",
    ar = "أداء تنافسية مجلس التعاون الموزون بالناتج المحلي"
  ),
  chart_dimensions_subtitle = list(
    en = "Scores and Average Rankings across Five Dimensions (69 countries ranked)",
    ar = "الدرجات ومتوسط الترتيب عبر خمسة أبعاد (69 دولة مصنفة)"
  ),
  chart_heatmap_title = list(
    en = "GCC Countries: Competitiveness Heatmap",
    ar = "دول مجلس التعاون: خريطة حرارية للتنافسية"
  ),
  chart_heatmap_subtitle = list(
    en = "Color intensity shows relative performance",
    ar = "كثافة اللون تعكس الأداء النسبي"
  ),
  chart_gap_title = list(
    en = "GCC Performance Gap Analysis",
    ar = "تحليل فجوة أداء مجلس التعاون"
  ),
  chart_gap_subtitle = list(
    en = "Achieved scores vs. potential improvement to perfect score (100)",
    ar = "الدرجات المحققة مقابل إمكانية التحسن إلى الدرجة الكاملة (100)"
  ),
  chart_radar_title = list(
    en = "Dimension Comparison",
    ar = "مقارنة الأبعاد"
  ),
  
  # === LEGEND LABELS ===
  region = list(en = "Region", ar = "المنطقة"),
  gcc_aggregate = list(en = "GCC Aggregate", ar = "مجمل مجلس التعاون"),
  gcc_member = list(en = "GCC Member", ar = "دولة عضو"),
  other = list(en = "Other", ar = "أخرى"),
  performance_level = list(en = "Performance Level", ar = "مستوى الأداء"),
  strong = list(en = "Strong", ar = "قوي"),
  good = list(en = "Good", ar = "جيد"),
  moderate = list(en = "Moderate", ar = "متوسط"),
  
  # === TIMELINE ANNOTATIONS ===
  timeline_2021 = list(
    en = "2021: UAE and Qatar establish top-20 presence",
    ar = "2021: الإمارات وقطر ترسخان وجودهما في العشرين الأوائل"
  ),
  timeline_2022 = list(
    en = "2022: Bahrain joins; Saudi momentum begins",
    ar = "2022: انضمام البحرين؛ بداية زخم السعودية"
  ),
  timeline_2023 = list(
    en = "2023: Kuwait enters; all six countries ranked by 2025",
    ar = "2023: دخول الكويت؛ جميع الدول الست مصنفة بحلول 2025"
  ),
  timeline_2024 = list(
    en = "2024: Consolidation year—all countries hold or improve",
    ar = "2024: عام التثبيت—جميع الدول تحافظ أو تتحسن"
  ),
  timeline_2025 = list(
    en = "2025: Regional breakthrough—three countries in top 20",
    ar = "2025: اختراق إقليمي—ثلاث دول في العشرين الأوائل"
  ),
  
  # === ANNOTATIONS ===
  uae_top5 = list(
    en = "UAE in Top 5!",
    ar = "الإمارات في الخمسة الأوائل!"
  ),
  saudi_improvement = list(
    en = "Saudi From 32 → 17",
    ar = "السعودية من 32 ← 17"
  ),
  strong_foundation = list(
    en = "Strong foundation",
    ar = "أساس قوي"
  ),
  opportunity_40pts = list(
    en = "40-point opportunity",
    ar = "فرصة 40 نقطة"
  ),

  # === LANDING PAGE ADDITIONAL ===
  gcc_countries_label = list(en = "GCC Countries", ar = "دول مجلس التعاون"),
  global_ranking_label = list(en = "Global Ranking", ar = "التصنيف العالمي"),
  gcc_score_label = list(en = "GCC Score", ar = "درجة مجلس التعاون"),
  combined_gdp_label = list(en = "Combined GDP", ar = "الناتج المحلي المجمع"),
  four_factors_title = list(en = "Four Competitiveness Factors", ar = "عوامل التنافسية الأربعة"),
  econ_perf_desc = list(
    en = "Domestic economy, international trade, investment, employment, and prices",
    ar = "الاقتصاد المحلي والتجارة الدولية والاستثمار والتوظيف والأسعار"
  ),
  gov_eff_desc = list(
    en = "Public finance, tax policy, institutional framework, and legislation",
    ar = "المالية العامة والسياسة الضريبية والإطار المؤسسي والتشريعات"
  ),
  bus_eff_desc = list(
    en = "Productivity, labor market, finance, and management practices",
    ar = "الإنتاجية وسوق العمل والتمويل وممارسات الإدارة"
  ),
  infra_desc = list(
    en = "Basic, technological, scientific infrastructure, health, and education",
    ar = "البنية التحتية الأساسية والتقنية والعلمية والصحة والتعليم"
  ),
  landing_about_title = list(
    en = "IMD World Competitiveness Ranking 2025",
    ar = "تصنيف التنافسية العالمية IMD 2025"
  ),
  landing_about_p1 = list(
    en = "The IMD World Competitiveness Ranking measures how 69 economies manage their resources and competencies to increase prosperity. This dashboard analyzes GCC performance as both individual nations and as a unified economic bloc, revealing how regional cooperation enhances global competitiveness.",
    ar = "يقيس تصنيف التنافسية العالمية IMD كيفية إدارة 69 اقتصاداً لمواردها وكفاءاتها لزيادة الازدهار. تحلل هذه اللوحة أداء دول مجلس التعاون كدول فردية وككتلة اقتصادية موحدة، مما يكشف كيف يعزز التعاون الإقليمي التنافسية العالمية."
  ),
  landing_about_p2 = list(
    en = "Using GDP-weighted aggregation, we demonstrate that if the GCC were a single country, it would rank 12th globally with a score of 84.9—ahead of the United States, Finland, and Iceland.",
    ar = "باستخدام التجميع الموزون بالناتج المحلي، نوضح أنه لو كان مجلس التعاون دولة واحدة، لاحتل المرتبة 12 عالمياً بدرجة 84.9—متقدماً على الولايات المتحدة وفنلندا وآيسلندا."
  ),
  landing_copyright = list(
    en = "© 2025 GCC Statistical Center (GCC-Stat)",
    ar = "© 2025 المركز الإحصائي لدول مجلس التعاون (GCC-Stat)"
  ),
  landing_datasource = list(
    en = "Data Source: IMD World Competitiveness Center",
    ar = "مصدر البيانات: مركز التنافسية العالمية IMD"
  ),
  explore_dashboard = list(
    en = "Explore the Dashboard",
    ar = "استكشف اللوحة"
  ),

  # === DASHBOARD NAV & TABS ===
  tab_home = list(en = "Home", ar = "الرئيسية"),
  tab_metadata = list(en = "Metadata", ar = "البيانات الوصفية"),
  tab_gcc_aggregate = list(en = "GCC Aggregate", ar = "مجمل مجلس التعاون"),
  tab_country_data = list(en = "Country Data", ar = "بيانات الدول"),
  tab_analysis = list(en = "Analysis", ar = "التحليل"),
  tab_recommendations = list(en = "Recommendations", ar = "التوصيات"),
  back_to_welcome = list(en = "Back to Welcome", ar = "العودة للرئيسية"),

  # === HOME TAB ===
  gcc_overall_score = list(en = "GCC Overall Score", ar = "الدرجة الإجمالية لمجلس التعاون"),
  countries_in_top20 = list(en = "Countries in Top 20", ar = "دول في العشرين الأوائل"),
  gcc_member_countries = list(en = "GCC Member Countries", ar = "دول مجلس التعاون الأعضاء"),
  all_six_ranked = list(
    en = "All six GCC countries are now ranked in the IMD World Competitiveness Index.",
    ar = "جميع دول مجلس التعاون الست مصنفة الآن في مؤشر التنافسية العالمية IMD."
  ),
  key_highlights = list(en = "Key Highlights", ar = "أبرز النقاط"),
  highlight_uae = list(en = "UAE climbed to 5th place globally", ar = "الإمارات صعدت إلى المركز الخامس عالمياً"),
  highlight_saudi = list(en = "Saudi Arabia: from 32nd (2021) to 17th (2025)", ar = "السعودية: من المرتبة 32 (2021) إلى 17 (2025)"),
  highlight_qatar = list(en = "Qatar maintains top 10 position", ar = "قطر تحافظ على مركزها ضمن العشرة الأوائل"),
  highlight_buseff = list(en = "Business Efficiency is strongest (Score: 82.6)", ar = "كفاءة الأعمال هي الأقوى (الدرجة: 82.6)"),
  gcc_global_context = list(en = "GCC in Global Context", ar = "مجلس التعاون في السياق العالمي"),
  five_year_trajectory = list(en = "5-Year Trajectory", ar = "المسار على مدى 5 سنوات"),

  # === METADATA TAB ===
  about_imd_title = list(en = "About the IMD World Competitiveness Ranking", ar = "حول تصنيف التنافسية العالمية IMD"),
  overview = list(en = "Overview", ar = "نظرة عامة"),
  about_imd_overview = list(
    en = "The IMD World Competitiveness Ranking measures how economies manage their resources and competencies to increase their prosperity.",
    ar = "يقيس تصنيف التنافسية العالمية IMD كيفية إدارة الاقتصادات لمواردها وكفاءاتها لزيادة ازدهارها."
  ),
  methodology = list(en = "Methodology", ar = "المنهجية"),
  methodology_desc = list(
    en = "The ranking is based on 256 criteria across four main factors.",
    ar = "يعتمد التصنيف على 256 معياراً عبر أربعة عوامل رئيسية."
  ),
  method_stat_data = list(en = "Two-thirds from statistical data", ar = "الثلثان من البيانات الإحصائية"),
  method_survey = list(en = "One-third from executive surveys", ar = "الثلث من استطلاعات المديرين التنفيذيين"),
  method_equal_weight = list(en = "Each factor has 25% weight", ar = "لكل عامل وزن 25%"),
  four_factors = list(en = "The Four Competitiveness Factors", ar = "عوامل التنافسية الأربعة"),
  factor_trade = list(en = "Trade, investment, employment", ar = "التجارة والاستثمار والتوظيف"),
  factor_policy = list(en = "Finance, policy, institutions", ar = "المالية والسياسات والمؤسسات"),
  factor_productivity = list(en = "Productivity, labor, finance", ar = "الإنتاجية والعمالة والتمويل"),
  factor_tech = list(en = "Tech, science, education", ar = "التقنية والعلوم والتعليم"),
  agg_methodology_title = list(en = "GCC Aggregation Methodology", ar = "منهجية تجميع مجلس التعاون"),
  two_approaches = list(en = "Two Aggregation Approaches", ar = "نهجان للتجميع"),
  simple_avg_desc = list(en = "Equal weight to all six countries.", ar = "وزن متساوٍ لجميع الدول الست."),
  gdp_weighted_avg = list(en = "GDP-Weighted Average", ar = "المتوسط الموزون بالناتج المحلي"),
  gdp_weighted_avg_desc = list(en = "Countries weighted by economic size.", ar = "الدول مرجحة بحسب الحجم الاقتصادي."),
  gdp_weights_label = list(en = "GDP Weights (2024)", ar = "أوزان الناتج المحلي (2024)"),
  data_summary = list(en = "Data Summary", ar = "ملخص البيانات"),
  dataset_info = list(en = "Dataset Information", ar = "معلومات مجموعة البيانات"),
  source_label = list(en = "Source:", ar = "المصدر:"),
  year_label = list(en = "Year:", ar = "السنة:"),
  countries_ranked_label = list(en = "Countries Ranked:", ar = "الدول المصنفة:"),
  gcc_countries_count = list(en = "GCC Countries:", ar = "دول مجلس التعاون:"),
  main_factors_label = list(en = "Main Factors:", ar = "العوامل الرئيسية:"),
  sub_factors_label = list(en = "Sub-Factors:", ar = "العوامل الفرعية:"),

  # === GCC AGGREGATE TAB ===
  gcc_single_country_desc = list(
    en = "The GCC would rank among the world's top 15 most competitive economies",
    ar = "سيحتل مجلس التعاون مرتبة بين أكثر 15 اقتصاداً تنافسية في العالم"
  ),
  aggregation_settings = list(en = "Aggregation Settings", ar = "إعدادات التجميع"),
  select_method = list(en = "Select Method:", ar = "اختر الطريقة:"),
  gcc_aggregate_scores = list(en = "GCC Aggregate Scores", ar = "درجات مجلس التعاون المجمعة"),
  gcc_world_position = list(en = "GCC Position in World Rankings", ar = "موقع مجلس التعاون في التصنيف العالمي"),
  simple_vs_gdp = list(en = "Simple vs GDP-Weighted Comparison", ar = "مقارنة المتوسط البسيط مع الموزون"),
  gdp_distribution = list(en = "GDP Weight Distribution", ar = "توزيع أوزان الناتج المحلي"),
  dimension_performance = list(en = "Dimension-Level Performance", ar = "الأداء على مستوى الأبعاد"),
  gdp_weighted_method_desc = list(
    en = "GDP-weighted: SAU 50%, UAE 25%, others share remaining 25%.",
    ar = "الموزون بالناتج المحلي: السعودية 50%، الإمارات 25%، الباقي يتشاركون 25%."
  ),
  simple_method_desc = list(
    en = "Simple average: All six countries weighted equally.",
    ar = "المتوسط البسيط: جميع الدول الست بأوزان متساوية."
  ),

  # === COUNTRY DATA TAB ===
  select_country_header = list(en = "Select Country", ar = "اختر الدولة"),
  choose_gcc_country = list(en = "Choose a GCC Country:", ar = "اختر دولة خليجية:"),
  competitiveness_profile = list(en = "Competitiveness Profile", ar = "ملف التنافسية"),
  rank_label = list(en = "Rank #", ar = "المرتبة #"),
  score_label = list(en = "Score:", ar = "الدرجة:"),
  dimension_scores_rankings = list(en = "Dimension Scores & Rankings", ar = "درجات وتصنيفات الأبعاد"),
  five_year_factor = list(en = "5-Year Factor Rankings", ar = "تصنيفات العوامل على 5 سنوات"),
  subfactor_performance = list(en = "Sub-Factor Performance", ar = "أداء العوامل الفرعية"),
  filter_by_factor = list(en = "Filter by Factor:", ar = "تصفية بحسب العامل:"),
  all_label = list(en = "All", ar = "الكل"),

  # === ANALYSIS TAB ===
  comparative_analysis = list(en = "Comparative Analysis", ar = "التحليل المقارن"),
  five_year_trends = list(en = "5-Year Trends", ar = "اتجاهات 5 سنوات"),
  country_comparison = list(en = "Country Comparison", ar = "مقارنة الدول"),
  subfactor_deep_dive = list(en = "Sub-Factor Deep Dive", ar = "التعمق في العوامل الفرعية"),
  select_countries_label = list(en = "Select Countries:", ar = "اختر الدول:"),
  performance_summary = list(en = "Performance Summary (2021-2025)", ar = "ملخص الأداء (2021-2025)"),
  key_insights = list(en = "Key Insights", ar = "رؤى رئيسية"),
  biggest_improver = list(en = "Biggest Improver", ar = "الأكثر تحسناً"),
  biggest_improver_desc = list(en = "Saudi Arabia improved 15 positions", ar = "السعودية تحسنت 15 مركزاً"),
  highest_ranked = list(en = "Highest Ranked", ar = "الأعلى تصنيفاً"),
  highest_ranked_desc = list(en = "UAE reached #5 globally", ar = "الإمارات وصلت للمرتبة الخامسة عالمياً"),
  gcc_heatmap = list(en = "GCC Countries Competitiveness Heatmap", ar = "خريطة حرارية لتنافسية دول مجلس التعاون"),
  full_comparison_table = list(en = "Full Comparison Table", ar = "جدول المقارنة الكامل"),
  select_factor = list(en = "Select Factor:", ar = "اختر العامل:"),
  subfactors_label = list(en = "Sub-Factors:", ar = "العوامل الفرعية:"),
  subfactor_comparison = list(en = "Sub-Factor Comparison", ar = "مقارنة العوامل الفرعية"),

  # === RECOMMENDATIONS TAB ===
  can_gcc_top10 = list(
    en = "Can the GCC Break Into the Global Top 10?",
    ar = "هل يستطيع مجلس التعاون الدخول إلى العشرة الأوائل عالمياً؟"
  ),
  gap_analysis = list(en = "Gap Analysis", ar = "تحليل الفجوات"),
  strengths_weaknesses = list(en = "Strengths & Weaknesses", ar = "نقاط القوة والضعف"),
  top_strengths = list(en = "Top Strengths", ar = "أبرز نقاط القوة"),
  areas_improvement = list(en = "Areas for Improvement", ar = "مجالات التحسين"),
  strategic_recommendations = list(en = "Strategic Recommendations", ar = "التوصيات الاستراتيجية"),
  rec_infra_short = list(
    en = "Close the 15-point gap by accelerating R&D spending and digital infrastructure.",
    ar = "سد فجوة الـ15 نقطة من خلال تسريع الإنفاق على البحث والتطوير والبنية التحتية الرقمية."
  ),
  rec_sustain_short = list(
    en = "Transform environmental challenges into competitive advantages.",
    ar = "تحويل التحديات البيئية إلى مزايا تنافسية."
  ),
  rec_human_short = list(
    en = "Strengthen higher education and STEM capabilities.",
    ar = "تعزيز التعليم العالي وقدرات العلوم والتقنية والهندسة والرياضيات."
  ),
  rec_integration_short = list(
    en = "Deepen economic cooperation across the $2.2 trillion GCC market.",
    ar = "تعميق التعاون الاقتصادي عبر سوق مجلس التعاون البالغ 2.2 تريليون دولار."
  ),

  # === CAROUSEL QUOTES ===
  quote_1 = list(
    en = "The GCC has emerged as a global economic powerhouse—with a combined GDP of $2.2 trillion, the region now competes with established economies worldwide.",
    ar = "برز مجلس التعاون الخليجي كقوة اقتصادية عالمية—بناتج محلي إجمالي يبلغ 2.2 تريليون دولار، تنافس المنطقة الآن الاقتصادات الراسخة حول العالم."
  ),
  quote_2 = list(
    en = "Three GCC nations rank in the global top 20—UAE at #5, Qatar at #9, and Saudi Arabia at #17—a remarkable concentration of competitiveness.",
    ar = "ثلاث دول خليجية تحتل مراتب ضمن العشرين الأوائل عالمياً—الإمارات في المركز الخامس وقطر في التاسع والسعودية في السابع عشر—تركيز استثنائي للتنافسية."
  ),
  quote_3 = list(
    en = "Business efficiency is the GCC's strongest dimension, scoring 82.6 and ranking 11th globally, reflecting decades of regulatory reforms.",
    ar = "كفاءة الأعمال هي أقوى أبعاد مجلس التعاون، بدرجة 82.6 والمرتبة 11 عالمياً، مما يعكس عقوداً من الإصلاحات التنظيمية."
  ),
  quote_4 = list(
    en = "Saudi Arabia achieved the region's most dramatic transformation—leaping 15 positions from 32nd to 17th between 2021 and 2025.",
    ar = "حققت السعودية أكثر تحولات المنطقة دراماتيكية—قفزة 15 مركزاً من 32 إلى 17 بين عامي 2021 و2025."
  ),
  quote_5 = list(
    en = "Together, the six GCC nations create a complementary ecosystem where investors find exactly the competitive advantages they need.",
    ar = "معاً، تشكّل دول مجلس التعاون الست منظومة متكاملة يجد فيها المستثمرون المزايا التنافسية التي يحتاجونها."
  ),

  # === TABLE COLUMN HEADERS ===
  col_gdp_billion = list(en = "GDP ($ Billion)", ar = "الناتج المحلي (مليار $)"),
  col_weight_pct = list(en = "Weight (%)", ar = "الوزن (%)"),
  col_econ_perf_score = list(en = "Econ Perf Score", ar = "درجة الأداء الاقتصادي"),
  col_econ_perf_rank = list(en = "Econ Perf Rank", ar = "مرتبة الأداء الاقتصادي"),
  col_gov_eff_score = list(en = "Gov Eff Score", ar = "درجة كفاءة الحكومة"),
  col_gov_eff_rank = list(en = "Gov Eff Rank", ar = "مرتبة كفاءة الحكومة"),
  col_bus_eff_score = list(en = "Bus Eff Score", ar = "درجة كفاءة الأعمال"),
  col_bus_eff_rank = list(en = "Bus Eff Rank", ar = "مرتبة كفاءة الأعمال"),
  col_infra_score = list(en = "Infra Score", ar = "درجة البنية التحتية"),
  col_infra_rank = list(en = "Infra Rank", ar = "مرتبة البنية التحتية"),
  col_overall = list(en = "Overall", ar = "الإجمالي"),
  col_econ_perf = list(en = "Econ Perf", ar = "الأداء الاقتصادي"),
  col_gov_eff = list(en = "Gov Eff", ar = "كفاءة الحكومة"),
  col_bus_eff = list(en = "Bus Eff", ar = "كفاءة الأعمال"),
  col_infra = list(en = "Infra", ar = "البنية التحتية"),
  col_factor = list(en = "Factor", ar = "العامل"),
  col_subfactor = list(en = "Sub-Factor", ar = "العامل الفرعي"),
  col_change = list(en = "Change", ar = "التغيير"),
  col_overall_rank = list(en = "Overall Rank", ar = "المرتبة الإجمالية"),
  col_overall_score = list(en = "Overall Score", ar = "الدرجة الإجمالية"),

  # === CHART LABELS FOR CHARTS.R ===
  chart_simple_vs_gdp = list(en = "Simple Average vs GDP-Weighted", ar = "المتوسط البسيط مقابل الموزون بالناتج المحلي"),
  chart_gdp_distribution = list(en = "GDP Distribution (2024)", ar = "توزيع الناتج المحلي (2024)"),
  chart_performance_by_dim = list(en = "GCC Performance by Dimension", ar = "أداء مجلس التعاون حسب البُعد"),
  chart_factor_profile = list(en = "Factor Profile", ar = "ملف العوامل"),
  chart_factor_rankings = list(en = "Factor Rankings Over Time", ar = "تصنيفات العوامل عبر الزمن"),
  chart_subfactor_scores = list(en = "Sub-Factor Scores", ar = "درجات العوامل الفرعية"),
  chart_rank_lower_better = list(en = "Rank (lower is better)", ar = "المرتبة (الأقل أفضل)"),
  chart_vs = list(en = "vs", ar = "مقابل"),
  chart_achieved = list(en = "Achieved", ar = "المحقق"),
  chart_gap_to_100 = list(en = "Gap to 100", ar = "الفجوة إلى 100"),

  # === FOOTER NAV ===
  nav_footer = list(
    en = "GCC-Stat | IMD World Competitiveness Ranking 2025",
    ar = "GCC-Stat | تصنيف التنافسية العالمية IMD 2025"
  )
)


# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

#' Get translated text by key
#' @param key The translation key (character)
#' @param lang Language code: "en" or "ar"
#' @return Translated string
t <- function(key, lang = "en") {
  if (key %in% names(translations)) {
    result <- translations[[key]][[lang]]
    if (!is.null(result)) {
      return(result)
    }
  }
  # Return key in brackets if translation not found (helps debugging)
  return(paste0("[", key, "]"))
}


#' Country name translation lookup table
country_translations <- list(
  "UAE" = list(en = "UAE", ar = "الإمارات"),
  "Qatar" = list(en = "Qatar", ar = "قطر"),
  "Saudi Arabia" = list(en = "Saudi Arabia", ar = "السعودية"),
  "Bahrain" = list(en = "Bahrain", ar = "البحرين"),
  "Kuwait" = list(en = "Kuwait", ar = "الكويت"),
  "Oman" = list(en = "Oman", ar = "عُمان"),
  "GCC" = list(en = "GCC", ar = "مجلس التعاون"),
  "GCC Average" = list(en = "GCC Average", ar = "متوسط مجلس التعاون"),
  "GCC (Simple)" = list(en = "GCC (Simple)", ar = "مجلس التعاون (بسيط)"),
  "GCC (Weighted)" = list(en = "GCC (Weighted)", ar = "مجلس التعاون (موزون)"),
  "Switzerland" = list(en = "Switzerland", ar = "سويسرا"),
  "Singapore" = list(en = "Singapore", ar = "سنغافورة"),
  "Hong Kong SAR" = list(en = "Hong Kong SAR", ar = "هونغ كونغ"),
  "Denmark" = list(en = "Denmark", ar = "الدنمارك"),
  "Taiwan (Chinese Taipei)" = list(en = "Taiwan (Chinese Taipei)", ar = "تايوان"),
  "Ireland" = list(en = "Ireland", ar = "أيرلندا"),
  "Sweden" = list(en = "Sweden", ar = "السويد"),
  "Netherlands" = list(en = "Netherlands", ar = "هولندا"),
  "Canada" = list(en = "Canada", ar = "كندا"),
  "Norway" = list(en = "Norway", ar = "النرويج"),
  "USA" = list(en = "USA", ar = "الولايات المتحدة"),
  "Finland" = list(en = "Finland", ar = "فنلندا"),
  "Iceland" = list(en = "Iceland", ar = "آيسلندا"),
  "China" = list(en = "China", ar = "الصين"),
  "Australia" = list(en = "Australia", ar = "أستراليا"),
  "Germany" = list(en = "Germany", ar = "ألمانيا"),
  "Luxembourg" = list(en = "Luxembourg", ar = "لوكسمبورغ"),
  "Lithuania" = list(en = "Lithuania", ar = "ليتوانيا"),
  "Malaysia" = list(en = "Malaysia", ar = "ماليزيا"),
  "Belgium" = list(en = "Belgium", ar = "بلجيكا"),
  "Czech Republic" = list(en = "Czech Republic", ar = "التشيك"),
  "Austria" = list(en = "Austria", ar = "النمسا"),
  "Korea Rep." = list(en = "Korea Rep.", ar = "كوريا الجنوبية"),
  "United Kingdom" = list(en = "United Kingdom", ar = "المملكة المتحدة"),
  "Thailand" = list(en = "Thailand", ar = "تايلاند"),
  "New Zealand" = list(en = "New Zealand", ar = "نيوزيلندا"),
  "France" = list(en = "France", ar = "فرنسا"),
  "Estonia" = list(en = "Estonia", ar = "إستونيا"),
  "Kazakhstan" = list(en = "Kazakhstan", ar = "كازاخستان"),
  "Japan" = list(en = "Japan", ar = "اليابان"),
  "Portugal" = list(en = "Portugal", ar = "البرتغال"),
  "Latvia" = list(en = "Latvia", ar = "لاتفيا"),
  "Spain" = list(en = "Spain", ar = "إسبانيا"),
  "Indonesia" = list(en = "Indonesia", ar = "إندونيسيا"),
  "India" = list(en = "India", ar = "الهند")
)


#' Translate country name
#' @param country_en English country name
#' @param lang Target language ("en" or "ar")
#' @return Translated country name
translate_country <- function(country_en, lang = "en") {
  if (lang == "en") return(country_en)
  
  if (country_en %in% names(country_translations)) {
    return(country_translations[[country_en]][[lang]])
  }
  return(country_en)  # Return original if no translation found
}


#' Vectorized country translation
#' @param countries Vector of English country names
#' @param lang Target language
#' @return Vector of translated country names
translate_countries <- function(countries, lang = "en") {
  sapply(countries, translate_country, lang = lang, USE.NAMES = FALSE)
}


#' Dimension name translation lookup table
dimension_translations <- list(
  "Overall" = list(en = "Overall", ar = "الإجمالي"),
  "Economic Performance" = list(en = "Economic Performance", ar = "الأداء الاقتصادي"),
  "Economic\nPerformance" = list(en = "Economic\nPerformance", ar = "الأداء\nالاقتصادي"),
  "EconPerf" = list(en = "Economic Performance", ar = "الأداء الاقتصادي"),
  "Government Efficiency" = list(en = "Government Efficiency", ar = "كفاءة الحكومة"),
  "Government\nEfficiency" = list(en = "Government\nEfficiency", ar = "كفاءة\nالحكومة"),
  "GovEff" = list(en = "Government Efficiency", ar = "كفاءة الحكومة"),
  "Business Efficiency" = list(en = "Business Efficiency", ar = "كفاءة الأعمال"),
  "Business\nEfficiency" = list(en = "Business\nEfficiency", ar = "كفاءة\nالأعمال"),
  "BusEff" = list(en = "Business Efficiency", ar = "كفاءة الأعمال"),
  "Infrastructure" = list(en = "Infrastructure", ar = "البنية التحتية"),
  "Infra" = list(en = "Infrastructure", ar = "البنية التحتية")
)


#' Translate dimension name
#' @param dim_en English dimension name
#' @param lang Target language
#' @return Translated dimension name
translate_dimension <- function(dim_en, lang = "en") {
  if (lang == "en") return(dim_en)
  
  if (dim_en %in% names(dimension_translations)) {
    return(dimension_translations[[dim_en]][[lang]])
  }
  return(dim_en)
}


#' Vectorized dimension translation
#' @param dimensions Vector of English dimension names
#' @param lang Target language
#' @return Vector of translated dimension names
translate_dimensions <- function(dimensions, lang = "en") {
  sapply(dimensions, translate_dimension, lang = lang, USE.NAMES = FALSE)
}


#' Get text direction for language
#' @param lang Language code
#' @return "rtl" or "ltr"
get_direction <- function(lang) {
  if (lang == "ar") return("rtl")
  return("ltr")
}


#' Get font family for language
#' @param lang Language code
#' @return Font family string for CSS/Plotly
get_font <- function(lang) {
  if (lang == "ar") {
    return("Noto Sans Arabic, Cairo, Tajawal, sans-serif")
  }
  return("Inter, sans-serif")
}


#' Get Plotly layout options for language
#' @param lang Language code
#' @return List of layout parameters
get_plotly_layout <- function(lang) {
  list(
    font = list(family = get_font(lang)),
    title = list(font = list(family = get_font(lang))),
    xaxis = list(tickfont = list(family = get_font(lang))),
    yaxis = list(tickfont = list(family = get_font(lang)))
  )
}


#' Get country list for picker input
#' @param lang Language code
#' @return Named vector for selectInput/pickerInput
get_country_choices <- function(lang = "en") {
  countries <- c("UAE", "Qatar", "Saudi Arabia", "Bahrain", "Kuwait", "Oman", "GCC Average")
  
  if (lang == "ar") {
    labels <- translate_countries(countries, "ar")
    names(countries) <- labels
  }
  
  return(countries)
}
