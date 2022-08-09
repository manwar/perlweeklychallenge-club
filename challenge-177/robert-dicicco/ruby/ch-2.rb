#!ruby.exe

require 'prime'

# AUTHOR: Robert DiCicco
# DATE: 2022-08-08
# Challenge 177 Palindromic Prime Cyclops ( Ruby )

def MidChar ( num )

  x = num.to_s.length()

  case x

    when 3

      return num.to_s[1,1]

    when 5

      return num.to_s[2,1]

    when 7

      return num.to_s[3,1]

    else

      return -1

   end

end

def IsOdd ( str )

  return str.digits.length().odd?

end

count = 0

candidate = 100

while ( count <= 20 )

  if (IsOdd(candidate) && Prime.prime?(candidate) && candidate.to_s == candidate.to_s.reverse && MidChar(candidate) == "0" )

    print("#{candidate} ")

    count += 1

  end

  candidate += 1

end

puts " "
