#!ruby.exe

require 'prime'

# AUTHOR: Robert DiCicco
# DATE: 2022-06-0
# Challenge 170 Primorial Numbers ( Ruby )

product = 1;

count = 1;

puts("1")

(1..100).each do |n|

  if Prime.prime?(n)

    product *= n

    puts("#{product}")

    count += 1

    if(count == 10 )

      break

    end

  end

end
