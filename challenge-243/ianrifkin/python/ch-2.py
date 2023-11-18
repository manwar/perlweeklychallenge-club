#!/usr/local/bin/python3
import sys, argparse
import math

# Challenge 243, Task 2: Floor Sum

# You are given an array of positive integers (>=1).
# Write a script to return the sum of floor(nums[i] / nums[j]) where 0 <= i,j < nums.length. The floor() function returns the integer part of the division.
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-243/#TASK2 for more information on this challenge

# else set default values from example if no cmd line input

def main(argv):
    argParser = argparse.ArgumentParser()
    argParser.add_argument("-n", "--nums", nargs='+', type=int, help="space seperated list of positive integers e.g. -n 10 30 4 5")
    args = argParser.parse_args()

    if args.nums:
        nums = args.nums
        print( sum_floors(nums) )
    else:
        #Example 1
        nums = (2, 5, 9)
        print( sum_floors(nums) )     
        #Example 2
        nums = (7, 7, 7, 7, 7, 7, 7)
        print( sum_floors(nums) )        
        
def sum_floors(nums):
    sum_of_floors = 0
    for i, inum in enumerate(nums):
        for j, jnum in enumerate(nums):
            sum_of_floors = sum_of_floors + math.floor(inum / jnum)
    return sum_of_floors
                    
        
if __name__ == "__main__":
   main(sys.argv[1:])
