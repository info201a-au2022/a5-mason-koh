# ui.R

#### Read in data ####
# co2_df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")
# write.csv(co2_df, file = "owid-co2-data.csv")
co2_df <- read.csv("owid-co2-data.csv")

#### introduction panel ####
introduction_panel <- tabPanel(
  "Introduction",
  titlePanel("Introduction"),
  imageOutput("image"),
  tags$figcaption("image via https://www.pngmart.com/image/tag/pollution"),
  h4("Background"),
  p("As the world grows and technology advances, the need for energy and power
    sources rise with it. For the last 100 years, we have relied on fossil fuels
    like oil and coal to power our world. However, burning these fuels emits 
    greenhouse gases, most notably Carbon Dioxide (co2), which are harmful to the
    atmosphere and cause global warming. In this project, we will analyze trends
    surrounding different statistics concerning co2 emissions, and come to a 
    conclusion on whether or not the world has a greenhouse gas problem, and
    if so, how bad it really it is."),
  h4("What are we measuring?"),
  p("In this analysis, we will be focusing on individual countriy statistics.
    The information we are referencing is via the 'Our World in Data' project, 
    which compiled and organized the data set that we are using in the viz.
    The variables we will be keeping track of are: total co2 emissions, measured
    in million tons; growth in co2 emissions from previous year, measured in 
    percentage; co2 emissions per person, measured in tons; share of global co2 
    emissions, measured in percentage. These four variables are tracked over 
    work together to paint most of the picture, and the data visualization 
    (on the next tab) plots these variables over the time range that they are 
    recorded for. "),
  h4("Points of Interest"),
  textOutput("points")
)

#### data viz panel ####
country_input <- selectInput(inputId = "country", 
                                label = "Choose a Country", 
                                choices = unique(co2_df$country))

stat_input <- selectInput(inputId = "stat",
                          label = "Choose a stat",
                          choices = list("Total co2 Emissions (million tons)" = "co2", 
                                         "Growth in co2 Emissions (percentage)" = "co2_growth_prct", 
                                         "co2 Emissions per person (tons)" = "co2_per_capita", 
                                         "Share of Global co2 Emissions (percentage)" = "share_global_co2"))

data_viz_panel <- tabPanel(
  "Data Visualization",
  titlePanel("Data Visualization"),
  
  sidebarLayout(  
    sidebarPanel( 
      country_input,
      stat_input,
      hr(),
      p("NOTE: The countries started tracking data in different years,
        and some countries don't even track the data categories in the
        visualization. As a result, most countries don't have complete
        data over the entire time range and some charts may be completely
        blank.",
        style = "font-family: 'times'; font-si16pt"
      )
    ),
    
    mainPanel(    
      plotlyOutput("line"),
      p("I included this chart because it clearly shows the trends in
         the most relevant CO2 emissions statistics. After looking through the
         different charts and stats displayed by the visualization, a trend
         emerges: CO2 emissions are consistently growing. For most of the 'Total
         co2 Emissions', 'Growth in co2 Emissions' and 'CO2 emissions per person'
         charts for countries, the general trend line is up and sloped positively
         since around 1950. This means that CO2 emissions have been increasing 
         over the data range. Additionally, for the 'Share of Global co2 Emissions'
         chart, it appears that countries with growing populations have generally
         increasing global shares, while countries with shrinking populations have
         decreasing globabl shares. This makes sense, as countries with rapidly
         increasing populations don't necessarily have the infrastructure to 
         handle providing clean energy to all these new people, so they just use
         the efficient, yet pollutant, CO2. In conclusion, CO2 emissions are 
         increasing at an alarming rate. Almost every country has continually been
         increasing CO2 emissions rates for the last half-century, and there are 
         no signs of slowing down. This is a very real and very urgent problem; 
         if the world as a whole does not start transitioning to clean fuels
         soon, CO2 emissions (and other greenhouse gases) will continue to
         pollute the atmosphere and accelerate global warming.")
    )
  )
)

#### ui ####

ui <- navbarPage(
  theme = shinytheme("sandstone"),
  "CO2 Emission Trends",
  introduction_panel,
  data_viz_panel
)