#!/usr/local/bin/python3
import sys, argparse

# Challenge 243, Task 1: Reverse Pairs

# You are given an array of integers.
# Write a script to return the number of reverse pairs in the given array.
# A reverse pair is a pair (i, j) where: a) 0 <= i < j < nums.length and b) nums[i] > 2 * nums[j].
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-243/#TASK1 for more information on this challenge

def main(argv):
    argParser = argparse.ArgumentParser()
    argParser.add_argument("-n", "--nums", nargs='+', type=int, help="space seperated list of integers e.g. -n 10 30 4 5")
    args = argParser.parse_args()

    if args.nums:
        nums = args.nums
        print( reverse_pairs(nums) )
    else:
        #Example 1
        nums = (1, 3, 2, 3, 1)
        print( reverse_pairs(nums) )     
        #Example 2
        nums = (2, 4, 3, 5, 1)
        print( reverse_pairs(nums) )        
        
def reverse_pairs(nums):
    pairs_found = 0
    for i, inum in enumerate(nums):
        for j, jnum in enumerate(nums):
            if i >= j:
                pass
            else:
                if inum > jnum * 2:
                    pairs_found = pairs_found + 1
    return pairs_found
                    
        
if __name__ == "__main__":
   main(sys.argv[1:])
