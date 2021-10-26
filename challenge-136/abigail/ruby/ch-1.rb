#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

def is_power_of_n (number, n)
    return number <  1    ? false
         : number == 1    ? true
         : number % n > 0 ? false
         : is_power_of_n(number / n, n)
end

def is_power_of_2 (number)
    return is_power_of_n(number, 2)
end

ARGF . each_line do
    | line |
    m, n = line . split . map {|x| x . to_i}
    r = m . gcd (n)
    puts (r > 1 && is_power_of_2(r) ? 1 : 0)
end
