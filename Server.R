

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