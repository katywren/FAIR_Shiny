#### EU Recommendations Shiny Dashboard

rm(list=ls())


#####

library(tidyverse)
library("DT")
library(readxl)
library(shiny)



##############################






ui = navbarPage("FAIR EU Recommendations App",
                tabPanel("About",
                         mainPanel(h2("Stakeholder App"),
                                   br(),
                                   p("In 2018, the EU produced the document ",
                                     a("Turning FAIR into Reality.",
                                       href = "https://ec.europa.eu/info/sites/info/files/turning_fair_into_reality_0.pdf"),
                                    "Part report, part action plan, this document included a list of stakeholder assigned actions and recommendations for interested parties who wish to make data FAIR. This app has been built to facilitate easy navigation of these recommendations." ),
                                   br(),
                                   p("To use, navigate to the ",
                                   strong("Stakeholders"),
                                   " tab to identify your community. Then, navigate to the ",
                                   strong("App"), 
                                   " tab and select the relevant stakeholder group and the recommendation you wish to enact from the drop down lists. The app will then deliver the relevant actions required to achieve the recommendations, according to the EU document"),
                                   img(src = "FAIR_Doc_Home_Page.png", align = "centre")
                                    )),
                tabPanel("Stakeholders",
                         mainPanel(tableOutput("stake_table"))),
                tabPanel("App",
                         pageWithSidebar(
                           headerPanel(" "),
                             sidebarPanel(
                               uiOutput("select_var1"), 
                               uiOutput("select_var2")
  ),
  
  mainPanel(tableOutput("table")
  )
  
  
)
)
)



recomends<-read_excel("data/Recommendations_Grouped.xlsx")
stakeholders<-read_excel("data/Stakeholders.xlsx") 


server = function(input, output, session) {
  recomends<-read_excel("data/Recommendations_Grouped.xlsx")
  stakeholders<-read_excel("data/Stakeholders.xlsx")  

  
  tab <- reactive({ 
    
    req(input$var1, input$var2)
    # <-- Reactive function here
    recomends%>%
      filter(Recommendation == input$var2) %>% 
      filter(Stakeholder == input$var1)%>%
      select(2)
    
    
    
  })
  
  output$select_var1 <- renderUI({
    recomends<-read_excel("data/Recommendations_Grouped.xlsx")
    data = recomends%>%
      select(Stakeholder)
    selectizeInput('var1', 'My Stakeholder Group:', choices = c("Select" = "", data))
    
  })
  
  output$select_var2 <- renderUI({
    recomends<-read_excel("data/Recommendations_Grouped.xlsx")
    data = recomends%>%
      select(Stakeholder, Recommendation)
    
    choice_var2 <- reactive({
      
      req(input$var1)
      
      data %>% 
        filter(Stakeholder == input$var1) %>% 
        pull(Recommendation) %>% 
        as.character()
      
    })
    
    selectizeInput('var2', 'I would like to:', choices = c("Select" = "", choice_var2())) # <- put the reactive element here
    
  })
    
  
  output$table <- renderTable({ 
    recomends<-read_excel("data/Recommendations_Grouped.xlsx")
    
    tab()
    
  }) 
  
  output$stake_table <- renderTable({ 
    stakeholders<-read_excel("data/Stakeholders.xlsx")  
    data = stakeholders
    
    
    
  })
  
}


shinyApp(ui, server)