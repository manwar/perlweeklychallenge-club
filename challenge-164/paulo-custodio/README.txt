Perl Weekly Challenge 164
https://theweeklychallenge.org/blog/perl-weekly-challenge-164/

Task 1: Prime Palindrome
Submitted by: Mohammad S Anwar
Write a script to find all prime numbers less than 1000, which are also palindromes in base 10. Palindromic numbers are numbers whose digits are the same in reverse. For example, 313 is a palindromic prime, but 337 is not, even though 733 (337 reversed) is also prime.


Task 2: Happy Numbers
Submitted by: Robert DiCicco
Write a script to find the first 8 Happy Numbers in base 10. For more information, please check out Wikipedia.

Starting with any positive integer, replace the number by the sum of the squares of its digits, and repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1.

Those numbers for which this process end in 1 are happy numbers, while those numbers that do not end in 1 are unhappy numbers.

Example
19 is Happy Number in base 10, as shown:

19 => 1^2 + 9^2
   => 1   + 81
   => 82 => 8^2 + 2^2
         => 64  + 4
         => 68 => 6^2 + 8^2
               => 36  + 64
               => 100 => 1^2 + 0^2 + 0^2
                      => 1 + 0 + 0
                      => 1
