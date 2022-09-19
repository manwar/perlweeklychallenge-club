#!julia.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-06-28
# Challenge 171 Abundant Numbers ( Julia )

function divisors(n)
  temp = []

  for i in 1:n

    if (( n % i == 0 ) && ( n != i))

      push!(temp,i)

    end

  end

  return temp

end

n = 1

count = 0

while count < 20

  sum = 0

  arr = divisors(n)

  sz = size(arr,1)

  for j in 1:sz

    sum += arr[j]

  end

  if ((sum > n) && ( n % 2 == 1))

    print(n," ")

    global count += 1

  end

  global n += 1

end

println(" ")
