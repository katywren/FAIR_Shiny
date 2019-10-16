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
                                     " tab and select the relevant stakeholder group and the recommendation you wish to enact from the drop down lists. The app will then deliver the relevant actions your stakeholder group must enact to achieve the recommendations, according to the EU document"),
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