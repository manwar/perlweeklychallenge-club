#!julia.exe

using Printf

# AUTHOR: Robert DiCicco
# DATE: 2022-08-02
# Challenge 176 Reversible Numbers ( Julia )

function AllDigitsOdd( n )
  arr = digits(n)
  elems = length(arr)

  i = 1

  while i <= elems
    if (iseven(arr[i]))
      return false
    end
    i += 1
  end

  return true
end

for num in 10:99
  forward = digits(num)
  V = Vector(forward)
  VR = reverse(V)
  f = parse(Int64, join(V))
  b = parse(Int64, join(VR))
  retval = AllDigitsOdd(f+b)

  if (retval )
     @printf("%d ",num)
   end
end

println(" ")
