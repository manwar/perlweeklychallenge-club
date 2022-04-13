#!julia.exe

# AUTHOR: Robert DiCicco
# DATE: 12-AP:R-2022
# Challenge 160 Equilibrium Index ( Julia )

function leftsum(a, i )
  sum = 0

  while  i > 0
    sum += a[i]
    i = i - 1
  end

  return sum
end

function rightsum(a, i)
  sum = 0

  while i <= length(a)
    sum += a[i]
    i = i + 1
  end

  return sum
end

function balance(a)
  flag = 0
  len = length(a)

  for i in 2:len-1
    leftval = leftsum(a, i)
    rightval = rightsum(a, i)

    if (leftval == rightval)
      i -= 1       # compare sums, subtract 1 to compensate for julia array numbering that starts at 1....
      println("Output: $i\n")
      flag = flag + 1                         # increment flag if equal
      break
    end
  end

  if ( flag == 0 )
    println("Output: -1 as no Equilibrium Index found.\n")
    return
  end
end

function main(a)
  println("Input: @n =  $a")
  balance(a)
end

arr = [[1,3,5,7,9], [1,2,3,4,5], [2,4,2] ]

x = collect(arr)
foreach(main,x)
