#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

ARGF . each_line do |_|
    for i in 1 .. _ . to_i do
        puts i % 15 == 0 ? "fizzbuzz"
           : i %  5 == 0 ?     "buzz"
           : i %  3 == 0 ? "fizz"
           : i
    end
end
