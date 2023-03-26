# loading necessary packages
library(ggplot2)
library(ggthemes)
library(shiny)
library(dplyr)

# loading mtcars dataset
data(mtcars)

# defining UI
ui <- fluidPage(
  titlePanel("Exploratory Data Analysis of mtcars"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "x_var",
                  label = "Select variable for x-axis",
                  choices = colnames(mtcars),
                  selected = "mpg"),
      selectInput(inputId = "y_var",
                  label = "Select variable for y-axis",
                  choices = colnames(mtcars),
                  selected = "disp"),
      selectInput(inputId = "color_var",
                  label = "Select variable for color",
                  choices = colnames(mtcars),
                  selected = "cyl"),
      selectInput(inputId = "size_var",
                  label = "Select variable for size",
                  choices = colnames(mtcars),
                  selected = "wt")
    ),
    mainPanel(
      plotOutput(outputId = "scatterplot"),
      plotOutput(outputId = "histogram")
    )
  )
)

# defining server
server <- function(input, output) {
  
  # creating scatterplot
  output$scatterplot <- renderPlot({
    ggplot(data = mtcars, aes(x = get(input$x_var), y = get(input$y_var))) +
      geom_point(aes(color = factor(get(input$color_var)), size = get(input$size_var))) +
      labs(title = paste('                ',input$x_var, "vs.", input$y_var), x = input$x_var, y = input$y_var, color=input$color_var,size=input$size_var) +
      theme_minimal() +
      theme(legend.position = "bottom")
  })
  

}

# running the app
shinyApp(ui = ui, server = server)


