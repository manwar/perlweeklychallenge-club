Perl Weekly Challenge 167
https://theweeklychallenge.org/blog/perl-weekly-challenge-167/

Task 1: Circular Prime
Submitted by: Mohammad S Anwar
Write a script to find out first 10 circular primes having at least 3 digits (base 10).

Please checkout wikipedia for more information.


A circular prime is a prime number with the property that the number generated at each intermediate step when cyclically permuting its (base 10) digits will also be prime.


Output
113, 197, 199, 337, 1193, 3779, 11939, 19937, 193939, 199933


Task 2: Gamma Function
Submitted by: Mohammad S Anwar
Implement subroutine gamma() using the Lanczos approximation method.


[2022-05-31]
Ryan Thompson wrote an interesting blog explaining the subject in details. Highly recommended if you are looking for more information. BLOG.


Example
print gamma(3); # 1.99
print gamma(5); # 24
print gamma(7); # 719.99
