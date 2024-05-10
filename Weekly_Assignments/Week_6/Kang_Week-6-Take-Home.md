Week 6: Benchmarking Notebook
================
<Karis Kang>

## Testing out R Notebooks

This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you
execute code within the notebook, the results appear beneath the code.

Try executing this chunk by clicking the *Run* button within the chunk
or by placing your cursor inside it and pressing *Ctrl+Shift+Enter*.

``` r
plot(cars)
```

![](Kang_Week-6-Take-Home_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

Nice! As you can see above, you can make plots render in-place. Anything
you run will get saved there, though, including error text, warning
text, and other things R prints (like when you download a package). Try
running the code below!

``` r
print("Prof Fisk is the coolest!")
```

    ## [1] "Prof Fisk is the coolest!"

``` r
warning("That's simply untrue!")
```

    ## Warning: That's simply untrue!

## Benchmarking Pt1

Great! Let’s get to the actual work for today! We are working with some
randomness today. Computers can’t actually generate *true* randomness,
but they can get pretty darn close. However, because it isn’t truly
random, we can use something called a seed to make it so that R produces
that same randomness in the same order every time, which makes it easier
to reproduce results, to pass unit tests, and, yes, for Prof Fisk to
grade.

``` r
#leave this set to 66 please! But do run this chunk before continuing.
set.seed(66)
```

Great. We are going to start to examine how different ways of doing the
same task can take different amounts of time to perform.

``` r
n=100000000 #pick a large number for N, around one-hundred million or so
res = runif(n) + 1
```

QUESTION 1: What does the above code do?

KARIS ANSWER 1: It tells R to generate n + 1 number of random values
from within the range of 0 to 1 and save that list of randomly generated
values to vector ‘res’ - Karis

We are going to find the sum of all the logs of the number in our vector
below. The code to compute the sum already works, so you don’t need to
touch it. Instead, you need to write code that, using a loop, runs the
code 3 times–saving how long it takes to run each time–and obtaining the
average of those three attempts to get a sense of how long it takes to
run.

``` r
#write code that runs this code 3 times using a loop, saves the amount of time it took to run each time, then prints the average
log_sum<- 0
for (i in 1:length(res)){
  log_sum <- log_sum + log(res[i])
}
```

``` r
#Karis code: 

#runs Fisk code three times in a loop, taking the start and end time for each iteration and storing the difference in "time" variable
time <- 0
log_sum<- 0
for (a in 1:3){
  start <- Sys.time()
for (i in 1:length(res)){
  log_sum <- log_sum + log(res[i])}
  end <- Sys.time()
 time[a] <- end-start
}

#note to self: if your loop keeps running forever, make sure you didn't use the same variable name for multiple things in loop

print(mean(time)) #prints the average of all values stored in "time" 
```

    ## [1] 5.317885

The above code uses a loop and looks at each element (i.e., number) in
the vector “res”, takes the log of that number, adds it to the current
sum (log_sum), and stores the result as the new log_sum.

QUESTION 2: What is “i” in the above code? What does it do? What value
does it take on the first iteration of the loop? The second? The
thirty-third?

KARIS ANSWER 2: The ‘i’ stands for “for every iteration of this value”.
The function to calculate log_sum runs for every value in the vector
res, aka it loops n+1 times — ‘i’ in the first loop is the first value
in res, in the second loop the second value in res, and in the
thirty-third loop the thirty-third value in the vector res. - Karis

Below is code that does achieves the same result as above, but in a
different way. Again, insert code that runs the code 3 times, saving the
amount of time it takes to run for each, and then printing the average.
This code can be/should be identical or pretty much identical to what
you wrote above.

``` r
#write code that runs this code 3 times using a loop, saves the amount of time it took to run each time, then prints the average

#Karis code: 

time2 <- 0
log_sum<- 0
for (x in 1:3){
  start <- Sys.time()
  log_sum <- sum(log(res))
  end <- Sys.time()
 time2[x] <- end-start
}

#print the average of the three runs here

print(mean(time2))
```

    ## [1] 2.703807

The above approach uses something called vectorization. In R (and other
programming languages supporting vectorized operations), vectorization
is almost always faster than the alternative. This means, effectively,
minimizing the use of loops when you can–instead using built-in
functions or the (l/s)apply family of functions when you can.

The reason why is a bit technical.

``` r
#I don't really expect you to know what this means
#But it is showing you that R is making a copy of this item at a new memory address
#When we replace the 5th element in the vector with the number 1. 
x <- 1:10; tracemem(x); x[5] <- 1
```

    ## [1] "<00000251C4287050>"

    ## tracemem[0x00000251c4287050 -> 0x00000251c44d4db8]: eval eval eval_with_user_handlers withVisible withCallingHandlers handle timing_fn evaluate_call <Anonymous> evaluate in_dir in_input_dir eng_r block_exec call_block process_group.block process_group withCallingHandlers process_file <Anonymous> <Anonymous> 
    ## tracemem[0x00000251c44d4db8 -> 0x00000251c3ea8648]: eval eval eval_with_user_handlers withVisible withCallingHandlers handle timing_fn evaluate_call <Anonymous> evaluate in_dir in_input_dir eng_r block_exec call_block process_group.block process_group withCallingHandlers process_file <Anonymous> <Anonymous>

Basically, whenever you index things and replace them in situ, R often
actually has to make a whole second copy of whatever it is you are
trying to alter. This makes your computer use more memory and adds extra
time to make a copy instead of just altering the value, which it can do
easier with vectorized approaches. The point is ultimately that we
should avoid loops when we can (though if that is the only way you know
how to solve it or if the problem is small, it doesn’t matter much. For
the purposes of your own final projects, for instance, its more
important your code works than it is fast.)

## Benchmarking, pt 2

“OK, Prof Fisk” I hear you say. “We get it, some code runs faster than
other code. But the difference in runtime between the loop and vector
code for calculating the log sum was not that big, even though there was
like one-hundred million data points!”

I hear you, and I get it. But, for better and for worse, bioinformatics
is a strange beast with big data and big problems, with things only
getting bigger. So for the next bits we are going to see how much of a
difference this can make and why we have to care about it so much in
bioinformatics.

Below and for the rest of the examples, I’m simulating an example matrix
of data, where the rows are all different samples (n=1000) and the
columns all represent different genomic loci (n=2200). The value of each
row-column is a DNA base, representing the genotype of that sample at
that genomic loci. Note that this means that there are just over 2
million data points in this simulated data–around/at least 50x smaller
than the data we worked with in our log-sum example. So, in theory,
working with this data should be pretty fast, right? (Note: In the first
code block below, I print the first 6 samples and first 6 loci so you
can get a sense of the data, but I only do so the one time). Keep in
mind that the human genome contains about 3.1 billion loci as you move
forwards.

Well, when making the simulated data, I (purposely) made a mistake and
“accidentally” made the “A” base lower case and all the others upper
case. The code that follows are all different ways to solve that
problem. Like above, you will need to benchmark the code. However, you
don’t need to obtain an average of three runs if you don’t want to–a
single run will suffice for this part of the notebook.

``` r
#Method 1
sequencing_matrix <- as.data.frame(matrix(sample(x = c("a","C","T","G"),size = 2200000,replace = T), nrow=1000))
colnames(sequencing_matrix)<-paste0("Loci",1:ncol(sequencing_matrix))
rownames(sequencing_matrix)<-paste0("Sample",1:nrow(sequencing_matrix))
print(sequencing_matrix[1:6,1:6]) # the only time I print this, to give you a sense of the data.
```

    ##         Loci1 Loci2 Loci3 Loci4 Loci5 Loci6
    ## Sample1     T     a     T     G     C     a
    ## Sample2     a     G     C     a     G     C
    ## Sample3     T     T     a     T     C     a
    ## Sample4     a     a     T     G     a     a
    ## Sample5     T     T     T     G     G     T
    ## Sample6     G     T     T     C     T     a

``` r
#Your benchmarking code should start here

start <- Sys.time() #setting start time
for(i in 1:nrow(sequencing_matrix)){
  for(j in 1:ncol(sequencing_matrix)){
    if(sequencing_matrix[i,j]=="a"){sequencing_matrix[i,j]<-"A"}
  }
}
end <- Sys.time() #setting end time
time3 <- end-start #subtracting the difference (storing each time difference for each problem separately)
#and end here.
#print how long it took to run!
print(time3)
```

    ## Time difference of 47.89472 secs

``` r
print("After replacement...")
```

    ## [1] "After replacement..."

``` r
print(sequencing_matrix[1:6,1:6]) #did it work?
```

    ##         Loci1 Loci2 Loci3 Loci4 Loci5 Loci6
    ## Sample1     T     A     T     G     C     A
    ## Sample2     A     G     C     A     G     C
    ## Sample3     T     T     A     T     C     A
    ## Sample4     A     A     T     G     A     A
    ## Sample5     T     T     T     G     G     T
    ## Sample6     G     T     T     C     T     A

The above code used what is called nested loops. It basically works by
looking at the data frame and saying “for each row and each column, find
the value that is in that row-column cell. Check to see if it is a
lower-case”a” and, if so, replace it with an “A”.”

It is simple code to write, but isn’t the most efficient.

QUESTION 3: What do i and j represent in the loops above, respectively?

KARIS ANSWER 3: i represents the nth row, or which sample the outer loop
is running. j represents the nth column, or which loci the inner loop is
running within the outer loop. This function is going through the data
row by row and processing each column for one row before moving down to
the next row.

The code below actually still uses nested loops, but rather than call
nrow and ncol within the loop, we call them outside of the loop and
store the result.

``` r
#Method 2
sequencing_matrix <- as.data.frame(matrix(sample(x = c("a","C","T","G"),size = 2200000,replace = T), nrow=1000))
colnames(sequencing_matrix)<-paste0("Loci",1:ncol(sequencing_matrix))
rownames(sequencing_matrix)<-paste0("Sample",1:nrow(sequencing_matrix))

#Your benchmarking code starts here
start<-Sys.time()
nrows<-nrow(sequencing_matrix)
ncols<-ncol(sequencing_matrix)
for(i in nrows){
  for(j in ncols){
    if(sequencing_matrix[i,j]=="a"){sequencing_matrix[i,j]<-"A"}
  }
}
end<- Sys.time()
time4<- end-start #stores difference in time difference for Question 4
#and ends here.
#print how long it took to run.
print(time4)
```

    ## Time difference of 0.004550219 secs

The code above should be faster than our first attempt.

QUESTION 4: Since the above code is faster and the only change we made
was storing the result of nrow and ncol, rather than calling them in the
loop declaration, what does that imply about the number of times the
nrow and ncol functions were being called in our first version.

KARIS ANSWER 4: It implies that the nrow and ncol functions were being
called every time one of the loops ran, requiring the computer to
process that request each time it went through a cell in the dataframe.
By taking the nrow and ncol functions, calling them once, storing that
call in a vector, and then referencing that vector within the loop
instead of processing the functions every time, the above code is able
to run much more quickly.

Alright! Maybe you don’t know how to vectorize the whole thing, but
remember you can work with whole rows at once and replace the whole row.
That is, rather than looking at each cell one-by-one, you could instead
look at the whole row at once and replace them all at once. That is what
the code below does!

``` r
#Method 3
sequencing_matrix <- as.data.frame(matrix(sample(x = c("a","C","T","G"),size = 2200000,replace = T), nrow=1000))
colnames(sequencing_matrix)<-paste0("Loci",1:ncol(sequencing_matrix))
rownames(sequencing_matrix)<-paste0("Sample",1:nrow(sequencing_matrix))

#your benchmarking code starts here
start<-Sys.time()
nrows<-nrow(sequencing_matrix)
for(i in nrows){
  sequencing_matrix[i,]<-gsub(pattern = "a",replacement = "A",x = sequencing_matrix[i,],fixed = T)
}
#and ends here
end<-Sys.time()
time5<-end-start
#print how long it took!
print(time5)
```

    ## Time difference of 0.01808095 secs

QUESTION 5: How many times does the loop above execute?

KARIS ANSWER 5: It executes as many times as there are rows, which is
1000

Sometimes, though, the devil is in the details. Below is a solution that
is entirely vectorized (e.g., uses no loops).

``` r
#Method 4
sequencing_matrix <- as.data.frame(matrix(sample(x = c("a","C","T","G"),size = 2200000,replace = T), nrow=1000))
colnames(sequencing_matrix)<-paste0("Loci",1:ncol(sequencing_matrix))
rownames(sequencing_matrix)<-paste0("Sample",1:nrow(sequencing_matrix))

#your benchmarking code starts here
start<-Sys.time()
sequencing_matrix<-as.data.frame(lapply(sequencing_matrix, function(x) {gsub("a ", "A", x)}))
#and ends here
end<-Sys.time()
time6<-end-start
#print how long it took!
print(time6)
```

    ## Time difference of 0.5597479 secs

Depending on some details we don’t have time to get into today, Method 4
may be slower than Method 3 on your machine, despite being completely
vectorized.

QUESTION 6: Which of the methods (1-4) to replace all the lower-case As
with upper case A ran fastest? How many times faster was the fastest
method than the slowest method?

KARIS ANSWER 6: Oddly enough, Method 2 was the shortest at 0.02540207
secs, when compared to Method 3 (0.05823207 secs) and Method 4
(0.5358081 secs), even though Method 4 was entirely vectorized compared
to Method 2’s partial vectorization. Method 2 was roughly 2,000 times
faster than Method 1, which took a whopping 54.73605 secs to run (my
computer was not happy with me)

## Writing code to solve a problem

In the code block below, you are tasked with counting the number of the
base “T” that occurs in sequencing_matrix. Feel free to google the task,
but resist using ChatGPT or other generative aids. You will not be
graded on the speed of your solution, nor its elegance. Your only goal
is to write code that will count the number of times “T” occurs in the
data frame sequencing_matrix. However, your solution should work even if
I change the number of rows and columns in sequencing_matrix (e.g.,
don’t “hard code” that there are 1000 rows anywhere–you you need to use
the number of rows in your solution, obtain it with the nrows()
function!)

There is a vectorized, 1-line of code solution, but I don’t expect you
to find or use it–it is perfectly fine if your code uses nested loops.
Feel free to use the code in Methods 1-4 above to help you with your
solution.

If you are having trouble, it might help you to break down the task into
its pieces–doing it on a piece of paper for a small test set for
yourself, for instance.

Note: You don’t need to write any additional code to generate
sequencing_matrix. The only reason the matrix was made anew in all the
above examples was because we changed all the lower case “a”s to upper
case “A”s–if we used the same sequencing_matrix, then the code that came
after wouldn’t have any lower case “a”s to replace!

TASK: Below, write code that prints the total number of “T”s in the
sequencing_matrix.

``` r
#Karis code: 
table(unlist(sequencing_matrix == "T")) #if T = True, if !T = False, so TRUE = the number of base T's in the df
```

    ## 
    ##   FALSE    TRUE 
    ## 1649402  550598

## Submission

Seperate submission instructions will be uploaded to Brightspace. You’ll
submit this work by uploading it to GitHub and pasting the link to the
repository on Brightspace
