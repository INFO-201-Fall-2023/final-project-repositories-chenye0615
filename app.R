#To specify our work allocation: Chenye Wu did all the coding part and the web design. 
#Varun Hariharan wrote the texts.
#Eunseo Jeong didn't contribute anything.
library(shiny)
library(ggplot2)
library(plotly)
library(grid)

combo_df <- read.csv("Combo.csv")

combo_df$Growth.Rate <- as.numeric(gsub("%", "", combo_df$Growth.Rate))
combo_df$Year <- as.numeric(combo_df$Year)

plot_emission <- ggplot(combo_df, aes(x = Year, y = Metric.Tons.Per.Capita)) +
  geom_line(color = "blue") +
  labs(x = "Year", y = "Metric Tons Per Capita", title = "Metric Tons Per Capita Change Over Time")

plot_wheat_production <- ggplot(combo_df, aes(x = Year, y = wheat_production_per_capita)) +
  geom_line(color = "orange") +
  labs(x = "Year", y = "Wheat Production Per Capita", title = "Wheat Production Per Capita Change Over Time")


early_years <- combo_df[combo_df$Year >= 1990 & combo_df$Year <= 2000, ]
recent_years <- combo_df[combo_df$Year >= 2010 & combo_df$Year <= 2019, ]

combined_plots1 <- ggplot() +
  geom_line(data = early_years, aes(x = Year, y = Metric.Tons.Per.Capita, color = "Early Years"), size = 1) +
  geom_line(data = recent_years, aes(x = Year, y = Metric.Tons.Per.Capita, color = "Recent Years"), size = 1) +
  labs(x = "Year", y = "CO2 Emissions Per Capita (Kilotons)", title = "Contrast in CO2 Emissions: Early Years vs. Recent Years") +
  scale_color_manual(values = c("Early Years" = "blue", "Recent Years" = "red")) +
  theme_minimal()

combined_plots2 <- ggplot() +
  geom_line(data = early_years, aes(x = Year, y = Production, color = "Early Years"), size = 1) +
  geom_line(data = recent_years, aes(x = Year, y = Production, color = "Recent Years"), size = 1) +
  labs(x = "Year", y = "Wheat Production", title = "Contrast in Wheat Production: Early Years vs. Recent Years") +
  scale_color_manual(values = c("Early Years" = "blue", "Recent Years" = "red")) +
  theme_minimal()



ui <- fluidPage(
  titlePanel("US Carbon Emissions and Wheat Production"),
  tabsetPanel(
    tabPanel("Introduction",
             #includeHTML("https://www.bing.com/images/search?view=detailV2&ccid=itTV5jOb&id=7F99488C8F29D285C5D2033955CCF05927FBFBE6&thid=OIP.itTV5jObV3MvMKyHv-ZzFgHaE7&mediaurl=https%3a%2f%2fwww.greengeeks.com%2fblog%2fwp-content%2fuploads%2f2018%2f12%2fCO2-emission_header.jpg&exph=1176&expw=1766&q=co2+emissions&simid=607997121418371055&FORM=IRPRST&ck=9AA284BE3B01E7ADB192B9E63F80CE8F&selectedIndex=271&ajaxhist=0&ajaxserp=0."),
             h1("Overview: An Environmental Analysis"),
             br(),
             p("Welcome to our project on the impact of the climate crisis on our daily food and meals.
In this analysis, we delve into the pressing issue of how climate change affects the
production and availability of staple foods, such as wheat. By examining factors such
as, carbon emissions, and crop production, we aim to shed light on the importance of
addressing the climate crisis and its tangible consequences on our meals. Join us on
this fascinating journey to understand the connection between climate change and the
food we consume."),
             br(),
             p("The climate crisis poses a significant threat to our food security and overall well-being.
As the world experiences more frequent and severe extreme weather events, we
witness the direct impact on crop yields, leading to potential food shortages and rising
prices. By exploring this topic, we aim to make the climate crisis more vivid and realistic,
connecting it directly to our daily lives and highlighting the urgent need for action. It is
crucial to understand how climate change affects our food production systems and to
take steps towards building a more sustainable future."),
             br(),
             p("To illustrate our findings, we will present visually engaging graphs, charts, and images,
enabling you to grasp the magnitude of the problem at hand. Our analysis will not only
focus on the global scale but also explore regional variations and the potential
disparities in food security across different parts of the world. By providing data-driven
insights, we hope to inspire meaningful conversations and encourage individuals,
communities, and policymakers to take action towards mitigating the climate crisis and
securing a sustainable food future."),
             
    
    ),
    tabPanel("Change Over Time",
             fluidRow(
               column(width = 6,
                      plotOutput("plot_emission"),
                      
                      hr(),
                      plotOutput("plot_wheat_production"),
                      
               ),
               column(width = 6,
                     
                      h1("Analysis"),
                      p("In this section, we have displayed two visualizations for change over time in order to depict the
change in wheat production over time, as well as the change in metric tonnes of emission per
capita over time. The first graph shows the correlation of Metric tonnes per capita (y axis) and
time in years (x axis). As we can see on the graph the carbon Emissions seem to peak around
the year 2000 and seem to decline since then. This shows a slight negative correlation between
the emission in metric tonnes over time. This is good news for the environment as since 1990
we can say that the emissions have been steadily reducing.", style = "font-size: 14px; font-weight: bold;"),
                  br(),      
                      p("On the other hand the second graph displays a correlation between Wheat production per
capita (y axis) over time in years (x axis). In this case it seems to be much harder to deduce a
consistent correlation due to the constant variance in the production of wheat. There seems to
be no constant relation however we can conclude that Wheat Production peaked during the first
year (1990), while dipping to an all time low in the early 2000’s. However, using the gradient we
can conclude that overall there has been a dip in the wheat production over the years.", style = "font-size: 14px; font-weight: bold;"),
                      br(),    
p("We can also conclude from this that during the period where the carbon emissions peaked, the
wheat production dipped to an all time low, which shows a potential correspondence between
the two. So what correspondence do you think we can conclude after looking at these
visualizations and what can we comment on the effect of climate change on wheat production.", style = "font-size: 14px; font-weight: bold;"),
               )
             )
    ),
    tabPanel("Contrast",
             fluidRow(
               column(width = 6,
                      plotOutput("combined_plots1"),
                     
                      hr(),
                      plotOutput("combined_plots2"),
                      
               ),
               column(width = 6,
                      h1("Analysis"),
                      p("This story displays two visualizations for contrast. The first is a line graph which shows the
contrast in CO2 emissions between the recent years and early years over a period of 30 years
(1990-2019). The first graph displays a comparison between CO2 emissions per capita over
time (y axis) and time in years(x axis). The blue lines display the early years while the red lines
depict the emissions for the more recent years. In this graph we can see clearly the contrast in
carbon emissions in recent vs early years. The magnitude of the carbon emissions in the early
years is at a much higher value in comparison to the recent years. This clearly shows that over
the years the carbon emissions have been decreasing, which shows a more stable environment
and also potentially displays the lessening of climate change over the years.", style = "font-size: 14px; font-weight: bold;"),
                      br(),      
                      p("The second graph displays another contrast comparison between the recent years and early
years. The graph plots wheat production (y axis) against time in years (x-axis). This comparison
however is between wheat production in early years and recent years. This graph shows a
slightly different story as there seems to be more of a fluctuation in wheat production levels of
the years. Initially the wheat production was highest in the starting year of 1990, while towards
the recent years there seems to be a fall in the wheat production. This shows that there may
have been a fall in factors other than climate change which may have dropped the wheat
productions.", style = "font-size: 14px; font-weight: bold;"),
                      br(),    
                      p("This shows that while the carbon emissions have reduced, the wheat production has also
reduced. This shows that there seems to be no direct correlation between carbon emissions and
wheat production. However, this analysis only takes into account two factors and there could be
multiple other factors which could be affecting the level of wheat production.", style = "font-size: 14px; font-weight: bold;"),
               )
             )
    ),
    tabPanel("Growth Rate of Wheat Production",
             fluidPage(sidebarLayout(position = "right",
                                     sidebarPanel(style = "background: black",
                                                  wellPanel(style = "background: white",
                                                            selectInput("Emission Level",
                                                                        "CO2 Emission Level :",
                                                                        choices = c("High" = "disc_number", "Medium" = "singer"),
                                                                        selected = "disc_number")),
                                                  wellPanel(style = "background: white",
                                                            p("This visualization depicts a bar graph of growth rate (y axis) in years (x axis). This graph shows
the individual growth rate of the wheat production over the years. This clearly shows the change
in yearly wheat production and accurately depicts the increase or decrease of wheat production
in a specific year. Through the graph it can be clearly noted that as time passes, the change in
growth of wheat production seems to decrease. While the wheat production peaked during the
early 2000’s there has been a steady reduction in the growth rate of wheat which can be
reflective to the previous visualizations. This clearly shows that over the years, the level of
wheat production has been reducing"),
                                                            
                                                            htmlOutput("sentiment_text"))),
                                     mainPanel(
                                       
                                       plotOutput("growthPlot"),
                                     )
             )
             )
    ),
             #fluidRow(
               #column(width = 12,
                    #  plotOutput("growthPlot"),
                     # p("Text beside plot 5", style = "font-size: 14px; font-weight: bold;")
               #)
             #)
    #),
    tabPanel("Conclusion",
             h1("Summary"),
             p("To summarize, this was an extremely insightful analysis as we were able to learn about the
carbon emission trend as well as the production of wheat over the last 30 years. Our main goal
was to find out the correlation between climate change and crop production. So what exactly is
our hypothesis? During the last 30 years there has been an overall drop in the carbon
emissions, which is great news for our planet! However at the same time there has also been an
overall drop in the production of wheat, which could lead to food shortage in the long run. This
clearly concludes that climate change has not had a direct impact on wheat production. While
on the other hand it is also important to note that other factors were not considered in this
analysis and they could have had an external effect on the wheat production as well. All in all,
we need to stay vigilant as the wheat production decrease could slowly cause a world wide food
shortage, and we must figure out the root cause of this"),
           h2("Comment"),  
           textInput(
             inputId = "opinion",
             label = "Leave your opinion: "
           ),
           
           textOutput(outputId = "Op" ),
    )
  )
)


 


server <- function(input, output) {
  output$plot_emission <- renderPlot({
    print(plot_emission)
  })
  
  output$plot_wheat_production <- renderPlot({
    print(plot_wheat_production)
  
  })

  output$combined_plots1 <- renderPlot({
    print(combined_plots1)
    
  })
  
  output$combined_plots2 <- renderPlot({
    print(combined_plots2)
 
  })
  
  output$growthPlot <- renderPlot({
  
    growthPlot <- ggplot(combo_df, aes(x = Year, y = Growth.Rate, fill = factor(Year))) +
      geom_bar(stat = "identity") +
      labs(x = "Year", y = "Growth Rate", title = "Growth Rate by Year") +
      theme_minimal()
      
      print(growthPlot)
  })

  output$Op <- renderText({
    return(paste("Thank you for giving this comment:",input$opinion, ".Hope you have a great day!"))
})
}

shinyApp(ui = ui, server = server)
