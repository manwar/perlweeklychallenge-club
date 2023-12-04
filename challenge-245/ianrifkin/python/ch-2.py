#!/usr/local/bin/python3
import sys, argparse
import math
from itertools import permutations

# Task 2: Largest of Three

# You are given an array of integers >= 0.

# Write a script to return the largest number formed by concatenating some of the given integers in any order which is also multiple of 3. Return -1 if none found.

# See https://theweeklychallenge.org/blog/perl-weekly-challenge-245/#TASK2 for more information on this challenge

def main(argv):
    argParser = argparse.ArgumentParser()
    argParser.add_argument("-n", "--nums", nargs='+', type=int, help="space seperated list of positive integers e.g. -n 10 30 4 5")
    args = argParser.parse_args()

    if args.nums:
        nums = args.nums
        print( largest(nums) )
    else:
        # Example 1
        nums = [8, 1, 9]
        print( largest(nums) )        
        #Output: 981

        # Example 2
        nums = [8, 6, 7, 1, 0]
        print( largest(nums) )        
        #Output: 8760
        
        # Example 3
        nums = [1]
        print( largest(nums) )        
        #Output: -1
        
        
def largest(nums):
    numbers_to_try = []
    for i in range(len(nums)):
        num_of_digits = i+1
        perms = list(permutations(nums, num_of_digits))
        
        for group_of_digits in perms:
            combined_digits = int("".join(map(str, group_of_digits)))            
            numbers_to_try.append(combined_digits)

    numbers_to_try.sort(reverse=True)
    
    for num2try in numbers_to_try:
        if num2try % 3 == 0:
            return num2try
    return -1
            

    # # Use array of potential numbers in numerical descending sort order
    # # to determine if any are divisible by 3
    # foreach my $num_2_try (sort { $b <=> $a } @numbers_to_try) {
    #     # return the first (biggest) number found
    #     return $num_2_try unless $num_2_try % 3;
    # }
    # return -1 #default return value of -1 if no number found

    
                    
        
if __name__ == "__main__":
   main(sys.argv[1:])
