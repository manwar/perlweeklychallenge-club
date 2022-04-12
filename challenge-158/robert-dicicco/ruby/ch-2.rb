#!ruby.exe

# AUTHOR: Robert DiCicco
# DATE: 29-MAR-2022
# Challenge 158 Cuban Primes ( Ruby )

require 'prime'

TARGET = 1000
i = 1

def makeCuban( num )
  cuban = ((3 * (num**2)) + (3 * num) + 1)

  if cuban.prime?
    return cuban
  else
    return -1
  end
end

while true
  retval = makeCuban( i )

  if retval > TARGET
    break
  end

  if retval.prime?
    print "#{retval} "
  end

  i = i+1
end

puts " "
