# ui.R ----


ui <- page_navbar(
  title = "HMIS API Product Suite",
  id = "page",
  theme = bs_theme(bootswatch = "lumen"), #update to this? https://posit-dev.github.io/brand-yml/
  nav_panel("Home", 
            page_fluid(
              page_sidebar(
                sidebar = card(
                 card_header("Sidebar Content"),
                 "Option 1", "Next to option 1", 
                 br(), 
                 "Option2"
                ),
                layout_columns(cards[[1]],cards[[2]]),
                cards[[3]]
            ))),
  nav_panel("Updated JSON Schema Builder",
            page_fluid(
              page_sidebar(
                sidebar =list( 
                  selectizeInput(
                    inputId = "selected_elements",
                    label = "Select HMIS Data Elements",
                    choices = NULL,
                    multiple = TRUE,
                    options = list(
                      placeholder = "Search by data dictionary name, element number, or field type",
                      plugins = list("remove_button"),
                      maxItems = NULL
                    )), br(),
                actionButton(
                  inputId = "build_schema",
                  label = "Build JSON Schema",
                  class = "btn-primary"
                ),
                downloadButton(
                  outputId = "download_schema",
                  label = "Download JSON"
                )
              ),
              accordion(
                open = c("Selected HMIS Data Elements","Generated JSON Schema"),
                accordion_panel(
                  "Selected HMIS Data Elements",
                    tableOutput("selected_table")
                  ),
                br(),
                accordion_panel(
                  "Generated JSON Schema",
                    verbatimTextOutput("schema_output")
                  )
                )
                )))
  # nav_panel("JSON Schema Builder", 
  #           fluidPage(
  #             titlePanel("HMIS Ontology JSON Schema Builder"),
  #             sidebarLayout(
  #               sidebarPanel(
  #                 selectizeInput(
  #                   inputId = "selected_elements",
  #                   label = "Select HMIS Data Elements",
  #                   choices = NULL,
  #                   multiple = TRUE,
  #                   options = list(
  #                     placeholder = "Search by data dictionary name, element number, or field type",
  #                     plugins = list("remove_button"),
  #                     maxItems = NULL
  #                   )
  #                 ),
  #                 br(),
  #                 
  #                 actionButton(
  #                   inputId = "build_schema",
  #                   label = "Build JSON Schema",
  #                   class = "btn-primary"
  #                 ),
  #                 br(),
  #                 br(),
  #                 
  #                 downloadButton(
  #                   outputId = "download_schema",
  #                   label = "Download JSON"
  #                 )
  #               ),
  #               mainPanel(
  #                 h4("Selected HMIS Data Elements"),
  #                 tableOutput("selected_table"),
  #                 br(),
  #                 h4("Generated JSON Schema"),
  #                 verbatimTextOutput("schema_output")
  #               )
  #             )
  #           )
  #           )
#)
)