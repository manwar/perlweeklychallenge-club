#!ruby.exe

# AUTHOR: Robert DiCicco
# DATE: 12=APR-2022
# Challenge 160 Equilibrium Index ( Ruby )

def leftsum ( a, i)
  sum = 0

  while ( i >= 0 )
    sum += a[i]
    i = i - 1
  end

  return sum
end

def rightsum ( a, i)
  sum = 0

  while ( i < a.length )
    sum += a[i]
    i = i + 1
  end

  return sum
end

def balance ( a )
  flag = 0
  len = a.length

  for i in 1..len-2 do
    leftval   = leftsum(a, i )
    rightval = rightsum(a, i )
    if (leftval == rightval)         # compare sums
      print "Output: #{i}\n\n"
      flag = flag + 1                         # increment flag if equal
      break
    end
  end

  if ( flag == 0 )
    print "Output: -1 as no Equilibrium Index found.\n\n"
    return
  end
end

arr = [ [1,3,5,7,9], [1,2,3,4,5], [2,4,2] ]

arr.each do |subarr|
  print "Input: \@n =  #{subarr}\n"
  balance(subarr)
end
