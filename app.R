# Install Libraries
if(!"shiny" %in% installed.packages()[,"Package"])install.packages("shiny")
if(!"xml2" %in% installed.packages()[,"Package"])install.packages("xml2")

# Include Libraries
library(shiny)
library(xml2)

file_name<- "test_data.txt"


# UI Code
ui<- pageWithSidebar(
  
  # Header
  headerPanel("Sentiment Analysis"),
  
  # Sidebar
  sidebarPanel(
    # Input
    textInput("get_url","Paste Product URL - ","https://www.example.com"),
    
    # Submit Button
    actionButton("run_func","Go!"),
    hr()
    
  ),
  
  
  # Main Panel
  mainPanel(
    h3(id="loading","Click on Go! and Wait",align="center"),
    br(),
    verbatimTextOutput("view")
  )
  
)

# Server Code
server<- function(input,output){
  
  
  # On Button Click
  get_output<- eventReactive(input$run_func, {
    
  # Remove Loading  
  file_output<- system(paste("Rscript scraping_classifying.R",input$get_url,file_name))
  removeUI(
    selector = "#loading"
  )
    
  })
  
  # Render View
  output$view<- renderText({get_output()
    
    
    # Display Text File
    if(file.exists(file_name)){
      data<- readLines(file_name)
    }
    string_final<- ""
    for(i in 1:length(data)){
      string_final<- paste(string_final,data[i],sep="\n")
    }
    string_final
    
    })
  
  
}

# Run Application 
shinyApp(ui = ui, server = server)

