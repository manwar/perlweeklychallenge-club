decomp <- function(x)
{
  num <- x
  
  div_max <-num/2
  fct<-numeric(0)
  if(x <=3) {return(fct)} # because of for loop below.
  
  for(i in 2:div_max)
  {
    while( 0 == x%%i)
    {

      fct <- c(fct, i) 
      x = x/i
    }
  }
  fct<-fct[!is.na(fct)]
}

# https://stackoverflow.com/questions/3789968 , here slightly modified to match 2 too:

isPrime <- function(x)
{
  div <- 2:ceiling(sqrt(x))

  !any(x %% div == 0) || 2 == x
}

print_attractive <- function(x)
{
  factors <- decomp(x)
  size <- length(factors)
  if(size > 0 && isPrime(size)) 
     {
       print(paste(x, paste(factors, collapse=" x "), sep = " = "))
     }
}


for (i in 1:50)
{
  print_attractive(i)
}





# Prints:
# [1] "4 = 2 x 2"
# [1] "6 = 2 x 3"
# [1] "8 = 2 x 2 x 2"
# [1] "9 = 3 x 3"
# [1] "10 = 2 x 5"
# [1] "12 = 2 x 2 x 3"
# [1] "14 = 2 x 7"
# [1] "15 = 3 x 5"
# [1] "18 = 2 x 3 x 3"
# [1] "20 = 2 x 2 x 5"
# [1] "21 = 3 x 7"
# [1] "22 = 2 x 11"
# [1] "25 = 5 x 5"
# [1] "26 = 2 x 13"
# [1] "27 = 3 x 3 x 3"
# [1] "28 = 2 x 2 x 7"
# [1] "30 = 2 x 3 x 5"
# [1] "32 = 2 x 2 x 2 x 2 x 2"
# [1] "33 = 3 x 11"
# [1] "34 = 2 x 17"
# [1] "35 = 5 x 7"
# [1] "38 = 2 x 19"
# [1] "39 = 3 x 13"
# [1] "42 = 2 x 3 x 7"
# [1] "44 = 2 x 2 x 11"
# [1] "45 = 3 x 3 x 5"
# [1] "46 = 2 x 23"
# [1] "48 = 2 x 2 x 2 x 2 x 3"
# [1] "49 = 7 x 7"
# [1] "50 = 2 x 5 x 5"