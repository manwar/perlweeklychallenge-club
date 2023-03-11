# Task 1: Keyboard Word
# Submitted by: Mohammad S Anwar
# 
# You are given an array of words.
# Write a script to print all the words in the given array that can be types using alphabet on only one row of the keyboard.
# 
# Let us assume the keys are arranged as below:
# Row 1: qwertyuiop
# Row 2: asdfghjkl
# Row 3: zxcvbnm
# 
# Example 1
# Input: @words = ("Hello","Alaska","Dad","Peace")
# Output: ("Alaska","Dad")
# 
# Example 2
# Input: @array = ("OMG","Bye")
# Output: ()

def main(input)
    a_class = ['qwertyuiop','asdfghjkl','zxcvbnm']
    output = []
    input.each {|word|
        a_class.each {|re|
            if word.match?(/^[#{re}]+$/i)
                output.append(word)
                break
            end
        }
    }
    printf "Output: (%s)\n", output.join(', ')
end

main ARGV
