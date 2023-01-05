#! /usr/bin/perl

# Robbie Hatley's Perl solution to Weekly Challenge #197-2.

# PROBLEM DESCRIPTION:

=pod

Task 2: Prime Count
Submitted by: Mohammad S Anwar

Given an integer $n, write a script to print the count
of primes less than $n.

Example 1:  Input: 10  Output: 4
Example 2:  Input: 15  Output: 6
Example 3:  Input:  1  Output: 0
Example 4:  Input: 25  Output: 9

=cut

# IO NOTES:

# NOTE: Input is from either the built-in array, or from @ARGV.
#       If using @ARGV, the arguments should be a space-separated
#       list of integers.

# NOTE: Output will be to stdout and will be # of primes < input.

# PRELIMINARIES:
use v5.36;

# DEFAULT INPUTS:
my @array = (10, 15, 1, 25);

# NON-DEFAULT INPUT:
if (@ARGV) {@array = @ARGV}

for (@array){
   say '';                                       # Print blank line,
   my $n = $_;                                   # Number.
   say "number = $n";                            # Announce number.
   my $c = 0;                                    # Count.
   if ( $n >= 3 ){                               # If number is 3-or-more,
      $c = 1;                                    # then increment counter,
      say "2 is prime"}                          # because 2 is a prime number < $n.
   for ( my $x = 3 ; $x < $n ; $x+=2 ){          # Other than 2, consider only odds.
      my $l = int $x**0.5;                       # Limit for divisor.
      my $f = 0;                                 # Divisibility flag.
      for ( my $d = 3 ; $d <= $l ; $d+=2 ){      # For each odd divisor from 3 through limit,
         if ( 0 == $x%$d){                       # if number is divisible by divisor,
            $f = 1;                              # number is not prime,
            last;}}                              # so no need to try any more divisors.
      if ( !$f ){                                # If number has no divisors,
         ++$c;                                   # increment prime count
         say "$x is prime"}}                     # and print prime.
   say "There are $c primes less than $n";}      # Announce count.