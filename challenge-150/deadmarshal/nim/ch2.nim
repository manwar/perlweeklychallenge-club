import sequtils

proc primeFactors(num:int):seq[int] =
  var
    c:int = 2
    n:int = num
  while true:
    if(n mod c) == 0:
        result.add(c)
        n = n div c
    else: c += 1
    if n <= 1: break

proc squareFreeIntegers() =
  var
    factors:seq[int]
    i:int = 1
  while true:
    factors = primeFactors(i)
    if factors.len - deduplicate(factors).len == 0:
      stdout.write(i, ' ')
    i += 1
    if i >= 500: break
  
when isMainModule:
  squareFreeIntegers()

