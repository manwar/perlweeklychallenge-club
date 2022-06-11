#!ruby.exe

# Author: Robert DiCicco
# Date: 31-JAN-2022
# Challenge 150 Fibonacci Words (Ruby)

a = '1234'
b = '5678'

# recursive routine to create fibonacci series, but using strings

def Fib ( first, second)
  val = first + second
  puts val

  # if new string length is less than 51, go another round using new combined string
  if val.length < 51 then
    Fib( second, val)
  else
    # return the string if length 51 or greater
    return val
  end

end

puts 'Fibonacci Words'
puts a
puts b

# get the 51st character
char = Fib(a,b)[50].chr
puts "51st digit is " + char
