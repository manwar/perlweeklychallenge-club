data <- tempfile("input.txt")
write(matrix(paste0("L", 1:100), ncol = 1), data )
con <- file(description=data, open="r")

from <- 4
to <- 12
counter <- 0


while (length(oneLine <- readLines(con, n = 1, warn = FALSE)) > 0) 
{
  counter = counter + 1

  if (counter >= from && counter <= to )
  {
    print(oneLine)
  }
}
unlink(data)
# rm(data, con, from, to, counter)
