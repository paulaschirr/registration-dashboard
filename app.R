#install all packages before first use with:
#install.packages("shiny", "remotes")
#remotes::install_github("datawookie/emayili")

library(shiny)
library(remotes)
library(emayili)
format(Sys.time(), "%F %H:%M")

if (file.exists("ID_key.csv")) {
    ID_key<-read.csv("ID_key.csv")}

if (!file.exists('registration_all.csv')) {
    df1 = data.frame(
        date = character(),
        ID_no = character(),
        Name = character())
    write.csv(df1, 'registration_all.csv', row.names = FALSE)
}
if (weekdays(Sys.Date())=="Monday") {
    email <- envelope() %>%
        from("my-email@email.com") %>%
        to("your-email@email.com") %>%
        subject("Registration data") %>%
        text("Last week's registration data is attached.")%>%
        attachment("./registration_all.csv")
    
    

    smtp <- server(host = "host",
                   port = 465,
                   username = "my-email@email.com",
                   password = "INSERTPASSWORDHERE")
    
    smtp(email, verbose = TRUE)
}

ui <- fluidPage(
    tags$img(src='logo_ftwv.png', height="20%", width="20%", align = "right", border="2000px"),
    titlePanel("registration FTWV"),
    
    sidebarPanel(
        textInput(inputId = "Number",
                  label = "ID_no", 
                  value = ""),
        actionButton("Anmelden", "Anmelden")),
    
    mainPanel(htmlOutput("text"),
              tableOutput(outputId = "registration"))
)


server <- function(input, output){
    
rv <- reactiveValues(
    df = data.frame(
        date = character(),
        ID_no = character(),
        Name = character()
    )
)

observeEvent(input$Anmelden, {

    if (!file.exists('ID_key.csv')){
        # Display text
        output$text <- renderText({ paste("<b>ID key missing. Csv file 'ID_key.csv' with columns 'ID_no' and 'Name' must be saved in the same folder as the app.<br>") })
    }
})

observeEvent(input$Anmelden, {
if (file.exists('ID_key.csv'))  { 
    if (input$Number %in% ID_key$ID_no)
    {
        if (!is.element(Sys.Date(),unlist(as.Date(read.csv('registration_all.csv')$date[read.csv('registration_all.csv')$ID_no==input$Number])))) {
                rv$df <- rbind(data.frame(date = as.character(format(Sys.time(), "%F %H:%M")), 
                                        ID_no = input$Number,
                                        Name=ID_key$Name[ID_key$ID_no==input$Number]), rv$df)
            write.csv(rbind(
                rv$df[1,], read.csv('registration_all.csv')
            ), "registration_all.csv", row.names = FALSE)
    }   else {rv$df}
    }
    else {rv$df}}
})

output$registration<-renderTable({
    rv$df
})

}

shinyApp(ui = ui, server = server)
