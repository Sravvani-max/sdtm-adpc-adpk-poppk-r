library(shiny)
library(tidyverse)
library(DT)

adsl <- read_csv("../data/adam/adsl.csv")
adpc <- read_csv("../data/adam/adpc.csv")
adpk <- read_csv("../data/adam/adpk.csv")
nonmem <- read_csv("../data/adam/nonmem_pk.csv")

ui <- fluidPage(
  titlePanel("Clinical PK Data Review App"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "dataset",
        "Select Dataset",
        choices = c("ADSL", "ADPC", "ADPK", "NONMEM")
      )
    ),
    
    mainPanel(
      h4("Dataset Preview"),
      DTOutput("table")
    )
  )
)

server <- function(input, output, session) {
  
  selected_data <- reactive({
    switch(
      input$dataset,
      "ADSL" = adsl,
      "ADPC" = adpc,
      "ADPK" = adpk,
      "NONMEM" = nonmem
    )
  })
  
  output$table <- renderDT({
    datatable(
      selected_data(),
      options = list(pageLength = 10, scrollX = TRUE)
    )
  })
}

shinyApp(ui, server)