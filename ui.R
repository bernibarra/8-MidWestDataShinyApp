# title: a8 Shiny
# subtitle: "Midwest Dataset"
# author: "Bernabe Ibarra"
# date: 20190304

library(shiny)
library(ggplot2)
library(dplyr)

# Get midwest column names vector from `midwest` for input select
select_values <- colnames(select_if(midwest, is.numeric))

# Create main layout
uw <- navbarPage(
  "a8 Shiny: Midwest Data",

  tabPanel(
    "Scatterplot",
    titlePanel("State-Specific Scatterplot Comparison"),

    sidebarLayout(
      sidebarPanel(

        # selector for `x` variable
        selectInput(
          "x_var",
          label = "X Variable",
          choices = select_values,
          selected = "poptotal"
        ),

        # selector for `y` variable
        selectInput(
          "y_var",
          label = "Y Variable",
          choices = select_values,
          selected = "popblack"
        ),
        # Narrow state specific data
        selectInput(
          "state_in",
          label = "Select State",
          choices = midwest$state,
          selected = c(1)
        ),

        radioButtons(
          "color",
          label = "Color",
          choices = list("Red" = "red", "Blue" = "blue", "Green" = "green"),
          selected = c("red")
        ),

        # Set the `size` of each point
        numericInput(
          inputId = "size",
          label = "Enter size from 1 to 5",
          min = 1,
          max = 5,
          value = 2
        )
      ),

      # Outputs
      mainPanel(
        plotOutput("scatter")
      )
    )
  ),

  tabPanel(
    "Bar Graph",
    titlePanel("State-Specific Bargraph Comparison"),

    sidebarLayout(
      sidebarPanel(

        # selector for `x` variable
        selectInput(
          inputId = "x_var_2",
          label = "X Variable",
          choices = select_values,
          selected = "area"
        ),

        # selector for `y` variable
        selectInput(
          inputId = "y_var_2",
          label = "Y Variable",
          choices = select_values,
          selected = "popdensity"
        ),

        # category selection
        selectInput(
          "cat_in",
          label = "Select category",
          choices = midwest$category,
          selected = c(1)
        ),

        # enter size
        sliderInput(
          inputId = "enter_alpha",
          label = "slide alpha interval",
          min = 0.0,
          max = 1.0,
          value = .5
        )
      ),
      
      # Outputs
      mainPanel(
        plotOutput("bargraph")
      )
    )
  )
)