#ui.R

shinyUI(fluidPage(
  
  #Includes
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "css/bootstrap.cosmo.min.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "css/custom.css"),
    tags$script(src = "js/script.js")
  ),
  
  # Title
  title="ea35",
  
  headerPanel("Analysis of Temperature outliers from 1964-2013"),
  
  hr(),
  
  #######################################Introduction##################################
  
  fluidRow(
    
    column(12,
           h2("Introduction",style="color:#000026;font-weight:bold",class="text-center"),
           p("This analysis report aims to describe and study the areas in the United States with the maximum increase in the percentage of anomalies "),
           p("(strong hot, hot, strong cold and cold). ")
    )
    
  ),
  hr(),
  
  ########################################Approach######################################
  
  fluidRow(
    
    column(12,
           h2("Approach",style="color:#000026;font-weight:bold",class="text-center"),
           p("To understand the process followed while developing this report, let us first focus on one station, say S1 and one anomaly, say A1."),
           br(),
           tags$ol(
             tags$li("All anomalies observed in year 1964 by the station S1 are filtered from the dataset."),
             tags$li("The percentage occurrence of the anomaly A1 is calculated."),
             tags$li("Similarly, the process is repeated for rest of the years (1965:2013), that is, the percentage occurrence of anomaly A1 is observed for all the years. Years for which no data was available were ignored."),
             tags$li("After noting down the percentages of A1 for all the years, these were plotted against their respected year."),
             tags$li("A linear regression line was plotted in the graph, and its slope was calculated as an indicator of the change in the percentage occurrence of the anomaly A1 over the years (1964:2013)."),
             tags$li("The value of the slope was noted down."),
             tags$li("Steps (1-6) are repeated for all the stations in the dataset and a corresponding slope value for the Anomaly A1 was noted down."),
             tags$li("The stations were then sorted on the basis of the calculated slope values."),
             tags$li("These stations were then divided in the following categories: Top 5% , 5-10%, 10-25%, 25-50% and rest (incl. stations for which no increment was observed).")
           ),
           br(),
           p("The above listed steps were repeated for all the Anomalies (Strong Hot, Hot, Strong Cold and Cold) and their respective graphs were plotted to indicate the changes.")
    )
    
  ),
  
  hr(),
  
  ########################################Maps#########################################
  
  fluidRow(
    h2("Maps",style="color:#000026;font-weight:bold",class="text-center"),
    navlistPanel(
      tabPanel("Strong Hot",leafletOutput("map2")), 
      tabPanel("Hot",leafletOutput("map1")),
      tabPanel("Strong Cold",leafletOutput("map4")),
      tabPanel("Cold",leafletOutput("map3"))
    )
  ),
  
  hr(),
  
  ########################################Footer######################################
  
  fluidRow(
    
    column(12,
      h3("Created for participation in IIITD-ESYA DATA HACKATHON"),
      tags$a(href="https://github.com/ameenkhan07","Ameen M. Khan",style="font-colour:red"),
      tags$a(href="https://github.com/beingcooper","Sachin Sharma")
    )
    
  ),
  
  hr()
  
))