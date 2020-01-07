ml <- sample(seq(6,20,2), 20, replace=TRUE)
v.base <- c("(", ")")
fair <- 1

simple_brackets <- function(x)
{
  v.s <- sample(v.base, x, TRUE)
  return(v.s)
}





fair_brackets <- function(x)
{
  v.f <- character(x)
  v.base <- c("(", ")")
  ob <- ifelse(v.base=="(",0.75,0.25)
  cb <- ifelse(v.base==")",0.75,0.25)
  v.f[1] = "("
  for(i in 2:(x-1))
  {
    if(v.f[i-1] == "(") v.f[i] <- sample(v.base, 1, TRUE, prob = cb)
    if(v.f[i-1] == ")") v.f[i] <- sample(v.base, 1, TRUE, prob = ob)

  }
  v.f[x] <- ")"
  return(v.f)
}



for (lenstr in ml)
{
  v.chr <- character(lenstr)
  if(fair == 1) v.chr <- fair_brackets(lenstr)
  else          v.chr <- simple_brackets(lenstr)


  counter<-0


  
  for(ch in v.chr)
  {
    if(ch == ")" ) counter <- counter - 1;
    if (counter < 0) break;
    
    if(ch == "(" ) counter <- counter + 1;
  }
  ok <- ifelse(counter == 0,'OK', 'NOT OK')

  print(paste(paste0(v.chr, collapse=""), ok))
}
