##############################################################################
## Assignment 7
## Shiny App of Kernel Density Plots
##############################################################################

# load libraries 
library(shiny)
library(ggplot2)
library(ggthemes)
library(dplyr)
library(gridExtra)
library(shinythemes)

# import data 
x_kde <- readRDS("~/Documents/coursework/intro_to_datascience/assignments/assignment7/final/x_kde.rds")
geneinfo <- readRDS("~/Documents/coursework/intro_to_datascience/assignments/assignment7/final/geneinfo.rds")

# Define UI using superhero theme
ui <- fluidPage(theme = shinytheme("superhero"),
                
    fluidRow(
        # main title
        column(10, offset = 2, titlePanel ("Expression of 10 Genes in GSE21935 Samples")),
        # ouput plots on top 
        column(11, offset = 1, plotOutput("kernPlots"))
        ),
    
    hr(), 
    
    # lower section
    fluidRow(
        # create input selection, without disease_state col
        column(3, 
               h4("Options"), 
               selectInput("gene", "Select Gene", 
                           choices = head(colnames(x_kde), -1)) 
               ), 
        # output gene info 
        column(9, 
               h4("Gene Info"),
                verbatimTextOutput("info"))
    ))

# define server ouput 
server = function(input, output) {
    
    # data prep
    control = subset(x_kde, x_kde$disease_status == 0) %>% 
        head(., -1) 
    schizo = subset(x_kde, x_kde$disease_status == 1) %>% 
        head(., -1) 
    
    # KDE plots 
    output$kernPlots <- renderPlot({
        # control KDE
        controlKern <- ggplot(control, aes(control[,input$gene])) + 
            geom_density(color="black", fill="white") +
            ggtitle("Control Condition") +
            theme_solarized(light = FALSE) +
            theme(plot.title = element_text(hjust = 0.5, size = 17)) +
            xlab(paste(input$gene, "Distribution")) + 
            ylab("Density") 
        
        # schizo KDE
        schizoKern <- ggplot(schizo, aes(schizo[,input$gene])) + 
            geom_density(color="black", fill="white") +
            ggtitle("Schizophrenia Condition") +
            theme_solarized(light = FALSE) +
            theme(plot.title = element_text(hjust = 0.5, size = 17)) +
            xlab(paste(input$gene, "Distribution")) +
            ylab("Density") 
        # side by side using gridExtra
        grid.arrange(schizoKern, controlKern, ncol = 2)  
    }, 
    height = 400, width = 800)
    
    # print gene info 
    output$info <- renderPrint({ 
    geneinfo = subset(geneinfo, input$gene == geneinfo$Gene) 
    info <- paste("ID:", geneinfo$ID, "Gene:",geneinfo$Gene, "Title:", geneinfo$Title, "Accession:", geneinfo$Accession, "Description:", geneinfo$Description, sep = "\n")
    writeLines(info)
    })
}

# run
shinyApp(ui = ui, server = server)
