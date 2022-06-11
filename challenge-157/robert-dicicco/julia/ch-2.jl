#!julia.exe

# AUTHOR: Robert DiCicco
# DATE: 24-MAR-2022
# Challenge 157 Brazilian Number ( Julia )

function checkDigits( n )
  x =string( n )
  d =split(x, "")
  f = first( d )

  for (value) in ( d )
    retval = cmp(first(d), value)
    if retval != 0
      return 0
    end
  end

  return 1
end

num = 7
#num = 6
#num = 8

println("Input: $num")

for b = 2:(num - 2)
  flag = 0
  x = string(num, base=b)
  retval = checkDigits(x)

  println("In base $b: $x")

  if retval == 1
    println("Output: $retval")
    exit(0)
  end

end

println("Output: 0")
