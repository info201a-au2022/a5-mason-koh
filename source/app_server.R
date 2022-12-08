# server.R

#### Read in data ####
# co2_df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")
# write.csv(co2_df, file = "owid-co2-data.csv")
co2_df <- read.csv("owid-co2-data.csv")

#### server ####
server <- function(input, output) {
  
  p <- reactive({
    plot_data <- co2_df %>% 
      filter(country %in% input$country)

    ggplot(plot_data, mapping = aes(x = year, y = plot_data[,input$stat])) +
    geom_line() +
    theme_minimal() +
    labs(x = "Year", y = input$stat, 
         title = paste0(input$country, "'s ", input$stat, " Over the Years"))
  })
  
  output$line <- renderPlotly({
    p()
  })
  
  output$image <- renderImage({
    filename <- normalizePath(file.path("co2_emissions_pic.png"))
    list(src = filename)
  })
  
  co2_df_v2 <- co2_df %>% 
    filter(country == "World", na.rm = TRUE) %>% 
    filter(year >= 1900, na.rm = TRUE) %>% 
    summarize(year, population, co2, co2_growth_prct, co2_per_capita)
  
  co2_1900 <- co2_df_v2 %>% 
    filter(year == min(year), na.rm = TRUE) %>% 
    pull(co2)
  
  co2_2021 <- co2_df_v2 %>% 
    filter(year == max(year), na.rm = TRUE) %>% 
    pull(co2)
    
  co2_times_bigger <- co2_2021 / co2_1900
    
  population_1900 <- co2_df_v2 %>% 
    filter(year == min(year), na.rm = TRUE) %>% 
    pull(population)
  
  population_2021 <- co2_df_v2 %>% 
    filter(year == max(year), na.rm = TRUE) %>% 
    pull(population)
    
  population_times_bigger <- population_2021 / population_1900
  
  per_capita_1900 <- co2_df_v2 %>% 
    filter(year == min(year), na.rm = TRUE) %>%
    pull(co2_per_capita)
  
  per_capita_2021 <- co2_df_v2 %>% 
    filter(year == max(year), na.rm = TRUE) %>%
    pull(co2_per_capita)
  
  per_capita_times_bigger <- per_capita_2021 / per_capita_1900
  
  output$points <- renderText ({
    text <- paste("To get the best idea of the overall CO2 emissions trends, we 
                  analyzed the comprehensive world statistics from the data set. 
                  The following are some of the most notable values that we derived.
                  We chose to use 1900 as the earliest year because that was 
                  roughly around the time that the Industrial Revolution started 
                  around the world, which is when burning fossil fuels started to
                  become the main way of producing energy. First, we found that 
                  total CO2 emissions in 2021 were", co2_times_bigger, "times 
                  bigger than in 1900. This is notably relevant considering  
                  that the total population now is only" , 
                  population_times_bigger, "times bigger since 1900. 
                  Interestingly enough, the CO2 emissions per capita is only", 
                  per_capita_times_bigger, "times bigger than it was in 1900. 
                  The fact that total CO2 emissions today are almost 20 times
                  more than that of 1900 is astounding, considering that the 121
                  years that have passed are a relatively short time period 
                  for humanity (and an even shorter time period for the Earth).
                  This figure is even more impressive when compared to the fact 
                  that the population is just under 5 times bigger than it was
                  120 years ago, and people are only emitting less than 4 times 
                  the CO2 than they were. This all is a testament to the reliance
                  and overusage that our society has had on fossil fuels, as it
                  shows in the waste that we create. Considering that the 
                  emissions are terrible for the atmosphere, it is definitely time
                  to consider our fossil fuel usage as a worldwide problem.")
    text
  })
}
