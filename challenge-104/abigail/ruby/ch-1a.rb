#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1a.rb
#

#
# Initialize the cache. For some reason, this needs to be a global variable.
#
$cache = Hash . new
$cache [0] =  0
$cache [1] =  1
max        = 50

#
# Calculate the nth element of the FUSC sequence.
#
def fusc (n)
    if !($cache . has_value? (n))
        if n % 2 == 1
            $cache [n] = (fusc ((n - 1) / 2)) + (fusc ((n + 1) / 2))
        else 
            $cache [n] =  fusc  (n      / 2)
        end
    end

    return $cache [n]
end
    

#
# Print the first 50 values of the FUSC sequence.
#
for n in 0 .. (max - 1) do
    if n > 0
        print (" ")
    end
    print (fusc (n))
end

print ("\n")
