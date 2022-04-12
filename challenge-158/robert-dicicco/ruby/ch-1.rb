#!ruby.exe

# AUTHOR: Robert DiCicco
# DATE: 29-MAR-2022
# Challenge 158 Additive Primes ( Ruby )

require 'prime'

def sumOfDigits (num)
    digsum = num.digits.sum

    if digsum.prime?
      return num
    end

    return -1
end

TARGET = 100
i = 1

while i < TARGET
  dsum = sumOfDigits(i)

  if dsum > 0 && i.prime?
    print "#{i} "
  end

  i = i+1
end

puts " "
