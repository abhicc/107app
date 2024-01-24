ui <- fluidPage(
  # Application title
  titlePanel("Histograms and Boxplots"),
  # Sidebar with a numeric input for month
  sidebarLayout(
    sidebarPanel(
      numericInput(inputId = "mean_value",
                   label = "Input a mean value",
                   min = -10,
                   max = 10,
                   value = 0,
                   step = 1),
      
      numericInput(inputId = "sd_value",
                   label = "Input a standard deviation",
                   min = 1,
                   max = 100,
                   value = 1, 
                   step = 1)
    ),
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

server <- function(input, output) {
  output$distPlot <- renderPlot({
    
    val <- rnorm(1000, mean = input$mean_value, sd = input$sd_value)
    val_transform <- log10(val)
    df <- data.frame(val_transform)
    
    ggplot(data = df) +
      geom_histogram(mapping = aes(x = val_transform), color = "black", fill = "lightgreen") +
      labs(x = "Value", y = "Frequency")
  })
}
# Run the application
shinyApp(ui = ui, server = server)
