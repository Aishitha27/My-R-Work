library(shiny)

ui <- fluidPage(
  
  h1("Intro"),
  p("You are in a land full of dragons. In front of you, you see two caves.
             In one cave the dragon is friendsly and will share the treasures with 
             you, while the other cave has a greedy and hungry dragon which will 
             eat you on sight."),
  actionButton(inputId = "continue", label = "Continue"),
  
  h1("Question"),
  p("Which cave will you go into ? (1 or 2)"),
  actionButton(inputId = "cave_01", label = "Cave 1"),
  actionButton(inputId = "cave_02", label = "Cave 2"),
  
  h1("Consequences"),
  textOutput(outputId = "consequence_text"),
  
  h1("Play Again ?"),
  actionButton(inputId = "play again", label = "Play Again !"),
  actionButton(inputId = "end game", label = "No, thank you!")
)

server <- function(input, output, session){
  observeEvent(input$continue, {
    message("Continue button was pressed")
  })
  
    observeEvent(input$cave_01, {
      message("Cave 1 button was pressed")
      cave_number(1)
  })
  
      observeEvent(input$cave_02, {
        message("Cave 2 button was pressed")
        cave_number(2)
  })
    
    cave_number <- reactiveVal()
    output$consequence_text <- renderText({
      consequences(cave_number())
    })
    
      observeEvent(input$play_again, {
        message("play again button was pressed")
  })
    
      observeEvent(input$end_game, {
        message("end game button was pressed")
  })
}

consequences <- function(cave_number = NULL) {
  if (is.null(cave_number)){ 
    return (NULL) }
  
  # friendly dragon == match with cave_number
  friendly <- sample(1:2, 1)
  if (cave_number == friendly) {
    return("Congratulations, you have a new dragon friend!")
  } else {
    return("Womp womp you have been eaten by a hungry dragon")
  }
}

shinyApp(ui, server)


#                                      Flowchat
# Start
# Introductory Text
# Player chooses a cave
# Check for a hungry dragon or a friendly dragon
#            - player wins
#            - player looses
# Ask to play again
#            - if yes go to start
#            - else:
#               -- End
