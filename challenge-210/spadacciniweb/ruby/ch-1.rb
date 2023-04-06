# Task 1: Kill and Win
# Submitted by: Mohammad S Anwar
# 
# You are given a list of integers.
# 
# Write a script to get the maximum points. You are allowed to take out (kill) any integer and remove from the list. However if you do that then all integers exactly one-less or one-more would also be removed. Find out the total of integers removed.
#
# Example 1
# Input: @int = (2, 3, 1)
# Output: 6
# 
# First we delete 2 and that would also delete 1 and 3. So the maximum points we get is 6.
# 
# Example 2
# Input: @int = (1, 1, 2, 2, 2, 3)
# Output: 11
# 
# First we delete 2 and that would also delete both the 1's and the 3. Now we have (2, 2).
# Then we delete another 2 and followed by the third deletion of 2. So the maximum points we get is 11.

def main(input)
    if input.length < 1 \
       or \
       input.select{ |i| i[/\D/] }.length > 0
    then
        puts "Input error"
        exit(0)
    end

    sum = 0
    input.each { |i| sum += i.to_i }
    puts sum

end

main ARGV
