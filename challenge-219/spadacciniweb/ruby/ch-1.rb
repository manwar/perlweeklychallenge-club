# Task 1: Sorted Squares
# Submitted by: Mohammad S Anwar
# 
# You are given a list of numbers.
# 
# Write a script to square each number in the list and return the sorted list, increasing order.
# Example 1
# 
# Input: @list = (-2, -1, 0, 3, 4)
# Output: (0, 1, 4, 9, 16)
# 
# Example 2
# 
# Input: @list = (5, -4, -1, 3, 6)
# Output: (1, 9, 16, 25, 36)

def main(input)
    if input.length < 1 \
       or \
       input.select{ |i| i[/[^\-\d]/] }.length > 0
    then
        puts "Input error"
        exit(0)
    end

    new_array = []
    input.each {|x| new_array << x.to_i**2}
    print new_array.sort{ |a,b| a <=> b}
end

main ARGV
