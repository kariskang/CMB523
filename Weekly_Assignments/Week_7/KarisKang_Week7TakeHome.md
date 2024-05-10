Today, we are going to work with some real data and machine to get used
to the process of using packages without *really* knowing what the
package is doing.

UC Irvine provides a lot of data for oncology machine learning training.
You are going to write a random forest classifier that will learn how to
classify breast leisions as benign or malignant.

I’ve labelled the columns of the data for you. There are 32 columns, 30
of which contain data that we are going to use to train our model. One
of the remaining columns (the first) is an ID that identifies the sample
uniquely and the other (the second) contains the answer (known as the
label) that we are going to train our machine learning algorithm to
classify.

We are going to use the caret and randomForest packages to do so.

    if(!"caret"%in%installed.packages()){install.packages("caret", dependencies = TRUE)}
    if(!"randomForest"%in%installed.packages()){install.packages("randomForest")}
    library(caret)

    ## Warning: package 'caret' was built under R version 4.2.3

    ## Loading required package: ggplot2

    ## Warning: package 'ggplot2' was built under R version 4.2.3

    ## Loading required package: lattice

    library(randomForest)

    ## Warning: package 'randomForest' was built under R version 4.2.3

    ## randomForest 4.7-1.1

    ## Type rfNews() to see new features/changes/bug fixes.

    ## 
    ## Attaching package: 'randomForest'

    ## The following object is masked from 'package:ggplot2':
    ## 
    ##     margin

Next, lets read in the data.

    #set FILENAME to be the location of the file on your computer
    breastFNA<-"breastFNA.csv" #note: why do this step instead of reading the file straight from CSV?
    all_breast_data<-read.csv(breastFNA,header = T)

The above code should load the data in as a variable called
“all\_breast\_data”. One common feature of machine learning classifiers
is that we need to split the data we have into different pieces called
training and testing. The training data is what the computer will use to
analyze underlying and complex relationships between the data and the
labels. The testing data is what we will use to determine if the machine
learning algorithm worked well or not (that is, we leave some data out
so we can give the program a test it doesn’t know the answer to).

    #<write a line of code that prints how many rows are in the data>
    print(nrow(all_breast_data))

    ## [1] 569

It is not uncommon to set aside around one-fifth of your data for
testing. To make things easy to interpret, you will set aside 100
samples for testing. Split all\_breast\_data into two variables, one
called testDat, containing 100 random rows from all\_breast\_data, and
trainDat, containing the rest.

    set.seed(42666) #just makes it easier for Dr. Fisk to grade

    #YOUR CODE HERE
    rowvector <- 1:569
    newvector <-sample(rowvector, 100, replace = FALSE)
    testDat <- data.frame(all_breast_data[newvector,])
    trainDat <- data.frame(all_breast_data[-newvector,])
    #there are lots of ways to do this
    #if you are having a hard time figuring out what to do
    #then I recommend creating a vector of all the numbers between 1
    #and the number of rows. Then, I would use the sample() function without replacement to randomly pick 100 row numbers from the aforementioned vector and save it as a new vector.
    #Then, test would be testDat<-all_breast_data[new_vector,] and train would be trainDat<-all_breast_data[-new_vector,]
    #however you do it is fine

Great! Now that you’ve split your data in two, we are going to train our
machine learning model! We need to do just a bit of data cleaning first
by converting our training label to something called a factor.

QUESTION 1: What is a factor data type in R?

**Answer 1: Factor data is a type of categorical data where there are a
set number of character values data can be grouped in e.g. Pokemon types
are factor data (“Grass”, “Fire”, “Psychic”)**

    ##NONE OF THIS IS CODE YOU NEED TO CHANGE OR ADD TO, BUT LOOK IT OVER ALL THE SAME

    #diagnosis is what we are trying to predict
    #B (benign) or M (malignant)
    trainDat$Diagnosis<-factor(trainDat$Diagnosis)

    #now we are going to train the model
    #we are using the randomforest algorithm, which is 'rf' and what is called a 5 fold cross-validation where the algorithm is trained on random subsets of the data and tested to get initial accuracy. 
    model<-train(Diagnosis~.,
                data=trainDat,
                method ='rf',
                trControl=trainControl(method = "cv",number = 5)
    )

    print(model)

    ## Random Forest 
    ## 
    ## 469 samples
    ##  31 predictor
    ##   2 classes: 'B', 'M' 
    ## 
    ## No pre-processing
    ## Resampling: Cross-Validated (5 fold) 
    ## Summary of sample sizes: 376, 376, 375, 375, 374 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa    
    ##    2    0.9553382  0.9040762
    ##   16    0.9552929  0.9045759
    ##   31    0.9574663  0.9090647
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was mtry = 31.

QUESTION 2: What mtry value had the best accuracy for your model?

**Answer 2: mtry =31 had the best accuracy at 0.9616997**

mtry is what is called a hyperparameter. It is basically a number that
somehow shapes how well the machine learning model does. For random
forests, they have a hyperparameter called mtry that decides how many
variables are used at each split in the decision tree.

Now we are going to test our model on data it has never seen before
(testDat) and see how well it learned.

    ###AGAIN, NO NEED TO ALTER ANY OF THIS RIGHT NOW

    #need to convert the diagnosis into a factor in the test data too
    testDat$Diagnosis<-factor(testDat$Diagnosis)

    #make the predictions and store them in a new column called prediction
    testDat$Prediction<-predict(model, newdata = testDat)

Now your variable testDat has a new column with the predictions the
machine model made, given the other columns. How did it do? You are
going to write code to find out! The “Diagnosis” column has the true
answers. The “Prediction” column has the predicted answers. Your task
here is to determine for how many of the rows out of 100 they do not
match.

    #YOU DO NEED CODE HERE
    length(which(testDat$Diagnosis==testDat$Prediction)) #Karis note: gives me number of values that DO match

    ## [1] 96

    #Karis note: 96/100 predictions match the diagnosis in the testDat data
    nrow(testDat) - length(which(testDat$Diagnosis==testDat$Prediction)) #Karis note: gives me number of values that do NOT match

    ## [1] 4

    #Karis note: 4/100 predictions do NOT match the diagnosis
    (nrow(testDat) - length(which(testDat$Diagnosis==testDat$Prediction)))/(nrow(testDat)) # gives proportion of values that do not match

    ## [1] 0.04

    #Karis note: 0.04 predictions do not match the diagnosis, allows for varying sample sizes instead of assuming 100

    #write code to determine how many values in trainDat's Prediction column (accessible with $) do not match the value in it's Diagnosis column (accessible with $)

Below is code that will tell you the true diagnosis of those that the
model misclassified. That is, when it was wrong, what was the right
answer.

    #NO NEED FOR YOU TO ADD CODE HERE
    print(summary(testDat[which(testDat$Diagnosis!=testDat$Prediction),"Diagnosis"]))

    ## B M 
    ## 4 0

QUESTION 3: In your results, was there a bias to which kind of leision
was misclassified more often?

**Answer 3: Benign (B) lesions were more likely to be misclassified as
malignant (M), than malignant as benign; aka, Type I error**

QUESTION 4: Do you think that it would be better for the machine
learning algorithm to classify benign tumors as malignant or malignant
tumors as benign. What other information might you want to make that
decision? (Not really a right or wrong questions, but making you think
about what your data looks like)

**Answer 4:In the case of cancer diagnosis, Type I errors are preferable
if error is present; better to scare someone with a misdiagnosis of
malignancy that turns out to be benign, rather than miss a malignant
tumor**

There are only 2 outcomes the model could decide: B or M.

QUESTION 5: If you or your model just guessed at random (equal chance in
this case), what do you expect your accuracy to be?

**Answer 5: If the model were to guess at random, there would be a 50:50
chance of getting the prediction correct aka accuracy = 0.50**

There might be more to it than you thought at first glance. Lets think
back to all the data. How many samples in the training data are B and
how many are M?

    #NO NEED TO ADD CODE HERE
    print(table(all_breast_data$Diagnosis))

    ## 
    ##   B   M 
    ## 357 212

    print(table(all_breast_data$Diagnosis)/nrow(all_breast_data))

    ## 
    ##         B         M 
    ## 0.6274165 0.3725835

Hmm… around 63% of the data is benign. That means that if you guessed
benign every time, no matter what, you would get an accuracy of 63%!
Better than the (probably) 50% you guessed above. Indeed, guessing at
random (with equal probabilities, like a coin flip) would get you below
a 50% accuracy on this data, on average because there is more benign
data than malignant data.

Why is this important? In your projects (and in your life!)
understanding what we expect to see is key to understanding whether or
not what we see is surprising or important. In this case, the dumbest
model could achieve 63% accuracy by just always guessing benign. So if
you wrote a program that gave you an accuracy of, say, 70%, that would
not actually be a very impressive machine learning program!

Think critically about your data whenever you can. Ask “are the
characteristics uniformly distributed among members of my data?” or more
simply “what do I expect to see and how often do I expect to see it”.

We are going to see if doing any preprocessing of our data helps with
the outcome at all. The chances are it probably won’t for a random
forest, but it is good practice all the same. All the new bit of code
below does is change the numbers such that they are centered about a
single number and scaled proportionally between 0 and 1. There are
reasons this can help not worth getting into today.

    #NO NEED FOR YOU TO ALTER THIS CODE
    #Same thing but with preprocessing
    #You can use this block of code again down below.
    model2<-train(Diagnosis~.,
                data=trainDat,
                method ='rf',
                preProc=c("center","scale"), #note this line
                trControl=trainControl(method = "cv",number = 5)
    )

    testDat$Prediction2<-predict(model2, newdata = testDat)
    print(summary(testDat[which(testDat$Diagnosis!=testDat$Prediction2),"Diagnosis"]))

    ## B M 
    ## 4 0

As expected, the preprocessing didn’t help in this case. However, more
numerically intensive methods can benefit from this preprocessing.

Here is where I leave you with one last counter-intuitive fact about
working with data.

More isn’t always better.

    # NO NEED FOR YOU TO ALTER THE CODE HERE
    #plot the model
    ggplot(model2)

![](KarisKang_Week7TakeHome_files/figure-markdown_strict/unnamed-chunk-11-1.png)

As the decision tree considers more and more predictors to include (that
is, columns to include), its prediction accuracy actually goes down.
Collecting more rows of data can usually help this problem, but in
biology we are often dealing with lots of columns, few rows. For
instance, each location in the human genome could be considered a
column.

A fundamental task and skill of scientific computing and the analysis of
biological data is using your biological knowledge and your tech skills
to determine what to include and what to exclude from your data in a way
that doesn’t also just bias the answer to what you want to see.

A delicate balance indeed!

You last task for today is to repeat the process of training the data,
predicting the diagnoses, and calculating the % correct and which ones
were wrong using a different machine learning method. [A list of
available models compatable can be found
here.](https://topepo.github.io/caret/available-models.html) Remember
that you are performing a classification task, so don’t use a regression
model. You may need to install another packackage(s) to get the code to
work. But ultimately, your should really have to change the method=“rf”
parameter from the train function above. Plot the model once it is done
training, like I did above with the ggplot function.

    ### Your code here, including installing and loading (via library) whatever other packages you end up needing to use
    library(mda) #library for Bagged Flexible Discriminant Analysis; not sure what it does, but let's give it a spin

    ## Warning: package 'mda' was built under R version 4.2.3

    ## Loading required package: class

    ## Loaded mda 0.5-4

    ### you can copy what I did above--that is ultimately how I wrote and ran the code, too!
    ### change the method from 'rf' to another classification method.
    ### don't forget to train the model first, then predict the outcomes, then calculate how many you got write, then plot the model.
    ### this should be mostly copy-ing and pasting, like you will be doing in your final projects!

    model3<-train(Diagnosis~.,
                data=trainDat,
                method ='bagFDA',
                preProc=c("center","scale"), 
                trControl=trainControl(method = "cv",number = 5)) #trained a third model using Bagged Flexible Discriminant Analysis; copied Prof Fisk code from above and adjusted parameters and variable names

    ## Loading required package: earth

    ## Warning: package 'earth' was built under R version 4.2.3

    ## Loading required package: Formula

    ## Loading required package: plotmo

    ## Warning: package 'plotmo' was built under R version 4.2.3

    ## Loading required package: plotrix

    ## Warning: package 'plotrix' was built under R version 4.2.3

    testDat$Prediction3<-predict(model3, newdata = testDat) #asking my new third model to make predictions and put them in a column called "Prediction 3"

    print(summary(testDat[which(testDat$Diagnosis!=testDat$Prediction3),"Diagnosis"])) 

    ## B M 
    ## 0 1

    #result: only 1 wrong prediction, but it was for a malignant tumor :( 

    ggplot(model3)

![](KarisKang_Week7TakeHome_files/figure-markdown_strict/unnamed-chunk-12-1.png)

    #this model does not seem to decrease in accuracy with more terms, though the accuracy does plateau from 9 terms onwards

QUESTION 6: What did you think of this assignment?

**Answer 6: I did this assignment very late, and I wish I hadn’t so that
I could have spent more time exploring the code - it’s interesting to
see the modeling tools that are out there even if I don’t fully
understand them, and get a feel for how different models takes different
snapshots of the data to create predictions.**
