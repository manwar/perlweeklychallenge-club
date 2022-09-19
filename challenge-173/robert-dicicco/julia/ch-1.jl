#!julia.exe

using Printf

# AUTHOR: Robert DiCicco
# DATE: 2022-07-12
# Challenge 173 Esthetic Number ( Julia )

function is_esthetic( a )

  arr = digits(a)

  elems = length(arr)

  prev = arr[1]

  i = 2

  while i <= elems

    if(abs(arr[i] - prev) == 1)

      prev = arr[i]

      i += 1

    else

      return -1

    end

  end

  return 1

end

for e in 100:5000

  retval = is_esthetic(e)

  if retval == 1

    @printf("%d ", e)

  end

end

println(" ")
