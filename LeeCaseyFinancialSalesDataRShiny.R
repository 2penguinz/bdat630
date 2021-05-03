library(shiny)
library(shinydashboard)
library(semantic.dashboard)
library(DT)
library(ggplot2)
library(scales)

salesdata <- read.csv("C:/Users/student/Desktop/projectdata.csv")


ui <- fluidPage(theme = "cyborg",
                dashboardHeader(title = "Sales Dashboard"),
                dashboardSidebar(
                  sidebarMenu(
                    menuItem(text = "Overview", tabName = "overviewdash"),
                    menuItem("Margin Correlation", tabName = "margincorrelation"),
                    menuItem("Table", tabName = "table"),
                    menuItem(text = "Help", href = "https://github.com/2penguinz"))),
                
                dashboardBody(
                  tabItems(
                    tabItem("Overview",
                            box(plotOutput("corre_plot2"), width = 8),
                            box(
                              selectInput("selection2", "Sell Margin Dollars:",
                                          c("ListPrice", "SellPrice")), width = 4),
                            ),
                            tabItem("margincorrelation",
                                    box(plotOutput("corre_plot"), width = 8),
                                    box(
                                      selectInput("selection", "Selection:",
                                                  c("ListPrice", "SellPrice")), width = 4
                                    )
                            ),
                            tabItem("table",
                                    fluidPage(
                                      h1("Table"),
                                      dataTableOutput("table")
                                    )
                            )
                    )
                  )
                )

server <- function(input, output){
  output$corre_plot2 <- renderPlot({
    plot(salesdata$QuantityPurchased, salesdata[[input$selection2]],
         xlab = "Qty Purchased", ylab = "Selection", col = "blue")
  })
  
  output$corre_plot <- renderPlot({
    plot(salesdata$SellMarginPercent, salesdata[[input$selection]],
         xlab = "Sell Margin %", ylab = "Selection", col = "orange")
  })
  
  output$table <- renderDataTable(salesdata)
}

shinyApp(ui, server)


