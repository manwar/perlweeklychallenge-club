#!/usr/bin/env python3

# Challenge 136
#
# TASK #2 > Fibonacci Sequence
# Submitted by: Mohammad S Anwar
# You are given a positive number $n.
# 
# Write a script to find how many different sequences you can create using
# Fibonacci numbers where the sum of unique numbers in each sequence are the
# same as the given number.
# 
# Fibonacci Numbers: 1,2,3,5,8,13,21,34,55,89, ...
# 
# Example 1
# Input:  $n = 16
# Output: 4
# 
# Reason: There are 4 possible sequences that can be created using Fibonacci
# numbers
# i.e. (3 + 13), (1 + 2 + 13), (3 + 5 + 8) and (1 + 2 + 5 + 8).
# Example 2
# Input:  $n = 9
# Output: 2
# 
# Reason: There are 2 possible sequences that can be created using Fibonacci
# numbers
# i.e. (1 + 3 + 5) and (1 + 8).
# Example 3
# Input:  $n = 15
# Output: 2
# 
# Reason: There are 2 possible sequences that can be created using Fibonacci
# numbers
# i.e. (2 + 5 + 8) and (2 + 13).

import sys
from itertools import combinations

def fibonacci(n):
    a = 0
    b = 1
     
    # Check is n is less
    # than 0
    if n < 0:
        print("Incorrect input")
         
    # Check is n is equal
    # to 0
    elif n == 0:
        return 0
       
    # Check if n is equal to 1
    elif n == 1:
        return b
    else:
        for i in range(1, n):
            c = a + b
            a = b
            b = c
        return b

def fibonacci_upto(n):
    i = 2                      # skip first '1'
    fibs = [fibonacci(i)]
    i += 1
    while fibs[-1] < n:
        fibs.append(fibonacci(i))
        i += 1
    if fibs[-1] > n:
        fibs.pop()
    return fibs

def count_combin_sum(n, terms):
    count = 0
    for k in range(1, len(terms)+1):
        for combin in combinations(terms, k):
            if sum(combin)==n:
                count += 1
    return count

n = int(sys.argv[1])
fibs = fibonacci_upto(n)
print(count_combin_sum(n, fibs))

# use Modern::Perl;
# use Math::Fibonacci 'term';
# use Math::Combinatorics;
# use List::Util 'sum';
# 
# @ARGV or die "Usage: ch-2.pl n\n";
# my $n = shift;
# my @fibs = fibs_upto($n);
# say count_combin_sum($n, @fibs);
# 
# 
# sub count_combin_sum {
# 	my($n, @fibs) = @_;
# 	my $count = 0;
# 	for my $k (1..@fibs) {
# 		my @combin = combine($k, @fibs);
# 		for (@combin) {
# 			my @combo = @$_;
# 			if (sum(@combo) == $n) {
# 				$count++;
# 			}
# 		}
# 	}
# 	return $count;
# }
# 