#!julia.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-07-13
# Challenge 173 Sylvbester's Sequence ( Julia )

arr = [BigInt(2)]

count = 1

while true
  sum = BigInt(prod(arr) + 1)
  push!(arr,sum)
  println(sum)
  global count += 1

  if count == 10
    break
  end

end
