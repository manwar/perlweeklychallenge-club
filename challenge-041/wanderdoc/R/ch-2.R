fib <- function(n) 
{
  x <- 0; y <- 1;

  m <- 0;
  while (m < n)
  {
    temp <-x;
    x <- y;
    y <- temp + y;
    m = m + 1;
  }

  x
}


leonardo <- function(x)
{
  leo_num <- 2 * fib(x + 1) - 1
  leo_num
}


sapply(1:20, leonardo)

# Prints:
# [1]     1     3     5     9    15    25    41    67   109   177   287   465   753  1219  1973
# [16]  3193  5167  8361 13529 21891
