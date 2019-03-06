# title: a8 Shiny
# subtitle: "Midwest Dataset"
# author: "Bernabe Ibarra"
# date: 20190304

library(shiny)
library(ggplot2)
library(tools)
library(dplyr)

# `input` features: `x_var`, `y_var`, `color`, and `size`
server <- function(input, output) {
  output$scatter <- renderPlot({

    # Store the graph title in a variable
    title <- paste0(
      "Midwest Dataset: ", toTitleCase(input$x_var), " v.s.",
      toTitleCase(input$y_var)
    )

    # Create ggplot scatterplot
    p <- midwest %>%
      filter(state == input$state_in) %>%
      ggplot(aes_string(x = input$x_var, y = input$y_var)) +
      geom_point(size = input$size, color = input$color) +
      scale_x_log10() + scale_y_log10() +
      labs(
        x = toTitleCase(input$x_var), y = toTitleCase(input$y_var),
        title = title,
        caption = "Both axis are logrithmically scaled for better presentation"
      )
    return(p)
  })

  output$bargraph <- renderPlot({

    # Store the graph title in a variable
    title <- paste0(
      "Midwest Dataset: ", toTitleCase(input$x_var_2), " v.s.",
      toTitleCase(input$y_var_2)
    )

    # Create ggplot scatterplot
    p <- midwest %>%
      filter(category == input$cat_in) %>%
      ggplot(aes_string(x = input$x_var_2, y = input$y_var_2)) +
      geom_col(alpha = input$enter_alpha, fill = "red") +
      scale_x_log10() + scale_y_log10() +
      labs(
        x = toTitleCase(input$x_var_2), y = toTitleCase(input$y_var_2),
        title = title,
        caption = "Both axis are logrithmically scaled for better presentation"
      )
    return(p)
  })
}
