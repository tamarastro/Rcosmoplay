
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Cosmology Playground"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      p("What happens when you vary the cosmological parameters?"),
      sliderInput("om",
                  "Matter density (Omega_M):",
                  min = 0.0,
                  max = 2.0,
                  step = 0.01,
                  value = 0.3),
      sliderInput("oll",
                  "Cosmological constant (Omega_Lambda):",
                  min = 0.0,
                  max = 1.5,
                  value = 0.7),
      sliderInput("H0",
                  "Hubble's Constant (H_0):",
                  min = 40.0,
                  max = 100.0,
                  value = 70.0),
      sliderInput("zrange", 
                  label = "Redshift Range", 
                  min = 0.0, 
                  max = 5.0,
                  step = 0.01,
                  value = c(0.0, 2.0)),
      
      actionButton("optimal", label = "Optimise")
        
    ),
  
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("dmPlot"),
      #plotOutput("distPlot"),
      textOutput("chitext"),
      textOutput("optimparm"),
      plotOutput("dmPlotnorm")
      #textOutput("printoptim")
    )
)
))
