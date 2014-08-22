library(shiny)

shinyUI(pageWithSidebar( 
        headerPanel("Predict Mileage Based on Vehicle Details"), 
        sidebarPanel(
            # Specification of weight as a numeric input field
            numericInput("weight", label = "Weight (lbs)",1000), 
            # Specification of horsepower as a numeric input field
            numericInput("horsepower", label = "Horsepower",150), 
            # Specification of displacement as a numeric input field
            numericInput("displacement", label = "Displacement (cubic inches)",300), 
            # Specification of range within an interval
            sliderInput("cylinders", "Number of Cylinders:",
                        min = 3, max = 8, value = 4),
            submitButton(text = "Predict MPG", icon = NULL),
            # Output section for prediction result
            h3('Prediction Result'),
            textOutput('mpg')
        ), 
        mainPanel(
            h3('Description'),
            p('This application applies a simple model to predict the vechile Mileage using other details. The data used to train the model is Auto MPG data set from UCI machine learning archive [1].'),
            h3('Usage'),
            p('Enter the appropriate value for the fields on the left for Weight, Horspower, Displacement and Number of Cylinders. The prediction will be more accurate if more details are specified. After filling out the details, click the "Predict MPG" button to display the predicted MPG in the Prediction Results section below.'),
            br(),
            h3('References'),
            a(href="https://archive.ics.uci.edu/ml/datasets/Auto+MPG","[1] - UCI Auto MPG Dataset")
        ) 
))
