#System Viewer - Hourly Journey Estimations 

#########################################################################################################################################################
library(shiny)
library(ggplot2)
library(plotly)
library(reshape2)
library(MASS)
library(ggthemes)
library(shinydashboard)

#########################################################################################################################################################

AvSixMonHourlyJourneyCount <- read.csv("AvSixMonHourlyJourneyCount_TZ.csv")
Names <- unique(AvSixMonHourlyJourneyCount$city)

#########################################################################################################################################################

ui <- fluidPage(titlePanel(title = "Bike Sharing System Daily Travel Patterns"),
                sidebarPanel(selectInput(inputId ="City", "Select BSS:", choices = Names, selected = "London", multiple = F)),
                mainPanel(fluidRow(plotOutput("Weekday")), br(), br(),br(), br(),br(), br(),br(), br(),br(), br(),br(), br(),br(), br(),br(), br(),br(), br(),
                          fluidRow(plotOutput("Weekend"))))

server <- function(input, output){
  output$Weekday <- renderPlot({
    ggplot(data = subset(AvSixMonHourlyJourneyCount, city == input$City & Weekday == 1), aes(x = thehour, y = Journeys)) + 
      geom_line() + 
      scale_x_continuous(breaks = c(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23)) +
      labs(x = "Hour of the Day", y = "No. of Journeys", title = "Weekday")}, height = 700, width = 1200)
    
  output$Weekend <- renderPlot({
    ggplot(data = subset(AvSixMonHourlyJourneyCount, city == input$City & Weekday == 0), aes(x = thehour, y = Journeys)) + 
      geom_line() + 
      scale_x_continuous(breaks = c(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23)) +
      labs(x = "Hour of the Day", y = "No. of Journeys", title = "Weekend")}, height = 700, width = 1200)
  
}




shinyApp(ui, server)

