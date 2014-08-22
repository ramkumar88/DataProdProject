shinyServer( 
    function(input, output) {
        output$mpg <- renderText({
                # declare vectors to store the names of variables and their values to use in prediction
                predVars <- vector()
                predVarInputs <- vector()
                
                # function to build the list of prediction variables
                buildpredVars <- function(predVars,valueName){
                    # non-empty value for the variable -> add to prediction variable list
                    if(!is.na(input[[valueName]])){
                        predVars <- c(predVars,valueName)
                    }
                    predVars
                }
                # build the list of prediction variables
                predVars <-  buildpredVars(predVars,"weight")
                predVars <-  buildpredVars(predVars,"horsepower")
                predVars <-  buildpredVars(predVars,"displacement")
                predVars <-  buildpredVars(predVars,"cylinders")
                
                # any prediction variable defined
                if(length(predVars)){
                    # build the values for predictor variables
                    for(name in predVars){
                        predVarInputs <- c(predVarInputs,input[[name]])
                    }
                    # load the training data frame
                    training <- read.table("auto-mpg.data")
                    names(training) <- c("mpg","cylinders","displacement","horsepower","weight","acceleration","model.year","origin","car.name")
                    # convert the horspower column to numeric
                    training$horsepower <- as.numeric(training$horsepower)
                    # build the prediction formula
                    predFormula <- paste("mpg ~ ",paste(predVars,collapse=" + "),sep = "")
                    # apply a linear prediction model
                    predFit <- lm(predFormula,data=training)
                    # build the test input data frame to perform prediction
                    testInput <- rbind(predVarInputs)
                    testInput <- as.data.frame(testInput)
                    names(testInput) <- predVars
                    # get the prediction MPG
                    estimatedMPG <- predict(predFit,testInput)
                    # return the predicted value
                    paste(round(estimatedMPG,digits=2)," Miles Per Gallon")
                }
                else{
                "Please specify at least one detail"
                }
        })
    } 
)