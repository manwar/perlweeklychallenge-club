#!/usr/bin/env ruby

=begin

AUTHOR: Robert DiCicco

DATE: 2022-12-05

Challenge 194 Digital Clock ( Ruby )

-------------------------------------------

SAMPLE OUTPUT

ruby .\DigitalClock.rb

Input: time = ?5:00

Output: 1

 

Input: time = ?3:00

Output: 2

 

Input: time = 1?:00

Output: 9

 

Input: time = 2?:00

Output: 3

 

Input: time = 12:?5

Output: 5

 

Input: time = 12:5?

Output: 9

=end

templates = ['?5:00', '?3:00', '1?:00', '2?:00', '12:?5','12:5?'];

 

def GetDigit(tp, n)

  puts("Input: time = #{tp}")

  print "Output: "

  if (( n == 0 ) && (tp[1,1] < '4'))

    printf "2\n\n"

  elsif (( n == 0 ) && (tp[1,1] >= '4' ))

    printf "1\n\n"

  elsif (( n == 1 ) && (tp[0,1] <= '1'))

    printf "9\n\n"

  elsif (( n == 1 ) && (tp[0,1] == '2'))

    printf "3\n\n"

  elsif ( n == 3)

    printf "5\n\n"

  elsif ( n == 4)

    printf "9\n\n";

  else

    puts "Error!";

  end

end

 

templates.each do |tp|

  GetDigit(tp,tp.index('?'));

end
