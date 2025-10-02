# Task 1: Broken Keyboard
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string containing English letters only and also you are given broken keys.
# Write a script to return the total words in the given sentence can be typed completely.
# 
# Example 1
# Input: $str = 'Hello World', @keys = ('d')
# Output: 1
# 
# With broken key 'd', we can only type the word 'Hello'.
# 
# Example 2
# Input: $str = 'apple banana cherry', @keys = ('a', 'e')
# Output: 0
# 
# Example 3
# Input: $str = 'Coding is fun', @keys = ()
# Output: 3
# 
# No keys broken.
# 
# Example 4
# Input: $str = 'The Weekly Challenge', @keys = ('a','b')
# Output: 3
# 
# Example 5
# Input: $str = 'Perl and Python', @keys = ('p')
# Output: 1

def broken_keyboard(str, keys)
    words = {}
    str.split.each { |w| words[w] = 0 }
    words.each_key do |w|
        keys.each do |k|
            if w =~ /#{k}/i
                words[w] += 1
                break
            end
        end
    end

    printf "'%s' (%s) -> %d\n", str,
                                keys.join(', '),
                                words.select { |_, v| v == 0 }.length
end

str = 'Hello World'
keys = ['d']
broken_keyboard(str, keys)

str = 'apple banana cherry'
keys = ['a', 'e']
broken_keyboard(str, keys)
# 
str = 'Coding is fun'
keys = []
broken_keyboard(str, keys)

str = 'The Weekly Challenge'
keys = ['a','b']
broken_keyboard(str, keys)

str = 'Perl and Python'
keys = ['p']
broken_keyboard(str, keys)
