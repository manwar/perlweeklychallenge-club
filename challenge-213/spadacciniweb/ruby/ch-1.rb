# Task 1: Fun Sort
# Submitted by: Mohammad S Anwar
# 
# You are given a list of positive integers.
# Write a script to sort the all even integers first then all odds in ascending order.
# 
# Example 1
# Input: @list = (1,2,3,4,5,6)
# Output: (2,4,6,1,3,5)
# 
# Example 2
# Input: @list = (1,2)
# Output: (2,1)
# 
# Example 3
# Input: @list = (1)
# Output: (1)

def main(input)
    if input.length < 1 \
       or \
       input.select{ |i| i[/\D/] }.length > 0
    then
        puts "Input error"
        exit(0)
    end

    list_fun = input.select{ |x| x.to_i.even? }.reverse
    list_fun.concat( input.select{ |x| x.to_i.odd? }.reverse )
    print list_fun

end

main ARGV
