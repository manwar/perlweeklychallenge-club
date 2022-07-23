#!julia.exe

using Printf

# AUTHOR: Robert DiCicco
# DATE: 2022-07-18
# Challenge 174 Disarium Numbers ( Julia )

function getPosiSum( a )

  arr = digits(a);
  arr = reverse(arr)
  elems = length(arr)

  i = 1
  sum = 0

  while i <= elems

    sum += arr[i] ^ (i)

    i += 1

  end

  return sum

  println(sum)

end

count = 1;

num = 0

while count < 20

  retval = getPosiSum(num)

  if retval == num

    @printf("%d ", num)

    global count += 1

  end

  global num += 1

end

println(" ")
