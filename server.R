library(shiny)
library(tidyverse)
#install_github("ramnathv/rCharts")
library(rCharts)
library(devtools)

setwd("C:/Users/ACER/Desktop/Visualizacion_Avanzada/E_cronicas/Poblacion")
distritos <- read_xlsx("C:/Users/ACER/Desktop/Visualizacion_Avanzada/E_cronicas/Poblacion/distritos.xlsx",1)
distritos
save(distritos, file = "distritos.rda")


function(input, output) {

  output$lines = renderChart2({
    DISSelected = input$dis
    NACSelected = input$nac
    EDADSelected = input$edad
    SEXSelected = input$sex
    
    
    lines_data = subset(distritos,
                        distrito == DISSelected &
                          nacionalidad == NACSelected &
                          ano >= input$ano[1] &
                          ano <= input$ano[2] &
                          grupo_edad == EDADSelected &
                          sex == SEXSelected
    )
    
    h1 = hPlot(x = "ano", y = "Valor",
               group = "distrito",
               data = lines_data,
               type = 'line')
    h1$title(text = NACSelected) 
    return(h1)
  }
  )

  
  output$bars = renderChart2(({
    NASelected = input$nac_a
    AASelected = input$ano_a
    EDASelected = input$edad_a
    SEXBSelected = input$sex_a
    
    bars_data = subset(distritos,
                       nacionalidad == NASelected &
                         ano == AASelected &
                         grupo_edad == EDASelected &
                         sex == SEXBSelected)
    
    h2 = hPlot(Valor ~ distrito,
               data = bars_data,
               type = 'column')
    h2$title(text = NASelected)
    return(h2)
    
  }))
  
}