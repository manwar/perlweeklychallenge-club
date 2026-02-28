Challenge 301
https://theweeklychallenge.org/blog/perl-weekly-challenge-301/

Task 1: Largest Number
Submitted by: Mohammad Sajid Anwar
You are given a list of positive integers, @ints.

Write a script to arrange all the elements in the given list such that they form the largest number and return it.

Example 1
Input: @ints = (20, 3)
Output: 320
Example 2
Input: @ints = (3, 30, 34, 5, 9)
Output: 9534330

Task 2: Hamming Distance
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.

Write a script to return the sum of Hamming distances between all the pairs of the integers in the given array of integers.


The Hamming distance between two integers is the number of places in which their binary representations differ.

Example 1
Input: @ints = (4, 14, 2)
Output: 6

Binary representation:
4  => 0100
14 => 1110
2  => 0010

HammingDistance(4, 14) + HammingDistance(4, 2) + HammingDistance(14, 2) = 2 + 2 + 2 = 6.
Example 2
Input: @ints = (4, 14, 4)
Output: 4
