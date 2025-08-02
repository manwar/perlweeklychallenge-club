# Task 2: Group Digit Sum
# Submitted by: Mohammad Sajid Anwar
# You are given a string, $str, made up of digits, and an integer, $int, which is less than the length of the given string.
# 
# Write a script to divide the given string into consecutive groups of size $int (plus one for leftovers if any). Then sum the digits of each group, and concatenate all group sums to create a new string. If the length of the new string is less than or equal to the given integer then return the new string, otherwise continue the process.
# 
# Example 1
# Input: $str = "111122333", $int = 3
# Output: "359"
# 
# Step 1: "111", "122", "333" => "359"
# Example 2
# Input: $str = "1222312", $int = 2
# Output: "76"
# 
# Step 1: "12", "22", "31", "2" => "3442"
# Step 2: "34", "42" => "76"
# Example 3
# Input: $str = "100012121001", $int = 4
# Output: "162"
# 
# Step 1: "1000", "1212", "1001" => "162"

def reduce_string(big_string, small_num):
    nums = [big_string[i:i+small_num] for i in range(0,len(big_string),small_num)]
    print("split string: ", nums)
    nums = [sum([int(i) for i in list(s)]) for s in nums]
    print("sum of digits in splitstring: ", nums)
    new_string = "".join([str(i) for i in nums])
    if len(new_string)>small_num:
        print(f"interim string is {new_string}")
        new_string = reduce_string(new_string, small_num)
    return new_string

string_of_numbers = input("Enter a random number of random length: ")
the_int = int(input("Enter any number smaller than the number of digits in previous number: "))

final_answer = reduce_string(string_of_numbers, the_int)

print(f"The final answer is {final_answer}")



