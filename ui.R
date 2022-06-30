

library(shiny)
library(tidyverse)
#install_github("ramnathv/rCharts")
library(rCharts)
library(devtools)

setwd("C:/Users/ACER/Desktop/Visualizacion_Avanzada/E_cronicas/Poblacion")
distritos <- read_xlsx("C:/Users/ACER/Desktop/Visualizacion_Avanzada/E_cronicas/Poblacion/distritos.xlsx",1)
distritos
save(distritos, file = "distritos.rda")



nums <- sapply(distritos, is.numeric)
nums
continuas <- names(distritos)[nums]
continuas
cats <- sapply(distritos, is.character)
cats
categoricas <- names(distritos)[cats]
categoricas

# as.factor(distritos$distrito)
# as.factor(distritos$nacionalidad)
# as.factor(distritos$sexo)
# as.factor(distritos$ano)


# Define UI for application that draws a histogram
fluidPage(
  
  headerPanel("Población por Distrito en Madrid"),
  
  tabsetPanel(type = "tabs",
              tabPanel("Line plots",
                       sidebarLayout(
                         sidebarPanel(
                           selectInput(inputId = "dis",
                                       label="Seleccione el Distrito:",
                                       choices = levels(distritos$distrito),
                                       selected = levels(distritos$distrito)[1],
                                       multiple = TRUE),
                           selectInput(inputId = "nac",
                                       label = "Seleccione la Nacionalidad",
                                       choices = levels(distritos$nacionalidad),
                                       selected = levels(distritos$nacionalidad)[1]),
                           selectInput(inputId = "edad",
                                       label = "Grupo Edad",
                                       choices = levels(distritos$grupo_edad),
                                       selected = "Total"),
                           selectInput(inputId = "sex",
                                       label = "Sexo",
                                       choices = levels(distritos$sexo),
                                       selected = "Ambos"),
                           sliderInput("ano","Rango de Años",
                                       min(distritos$ano), max(distritos$ano),
                                       value  = c(2019, 2022),
                                       step = 1)
                           ),
                         
                           mainPanel((showOutput("lines", "highcharts")))),
                       
                       tabPanel("Bar plots",
                                sidebarLayout(
                                  sidebarPanel( 
                                              selectInput(inputId = "ano_a",
                                                          label = "Año"),
                                                          choices = c(2019:2022),
                                                          selected = (2019),
                                              selectInput(inputId = "nac_a",
                                                          label = "Nacionalidad",
                                                          choices = levels(distritos$nacionalidad),
                                                          selected = levels (distritos$nacionalidad)[1]),
                                              selectInput(inputId = "edad_a",
                                                          label = "Grupo de Edad",
                                                          choices = levels(distritos$grupo_edad),
                                                          selected = "Total"),
                                              selectInput(inputId = "sex_a",
                                                          label = "Sexo",
                                                          choices = levels(distritos$sexo),
                                                          selected = "Ambos")),
                                  mainPanel(showOutput("bars", "highcharts")))),
                       
                       tabPanel("About",
                                p(HTML("")),
                                p(HTML("This is a Shiny Application built to plot statistics on income and living conditions from Eurostat.")),
                                p(HTML("It allows to either compare countries across time by using line charts, or to take more specific snapshots of a moment in time by comparing the 34 countries available.")),
                                p(HTML("You can browse through different indicators and look at their values while specifying sex ang age groups.")),
                                p(HTML("Passing the mouse over the chart gives the exact values of the indicators by country and year.")),
                                p(HTML("Code for the app is available on <a href='https://github.com/aaumaitre/eurostat'>Github</a>.")),
                                p(HTML("Data comes from Eurostat and has been retrieved using the eurostat package in R")),
                                p(HTML("Plots are generated using RCharts, but you can expect a ggplot version coming soon"))
                       )
                      )))
                              
   
  