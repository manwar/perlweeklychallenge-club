#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-336/#TASK1
#
# Task 1: Equal Group
# ===================
#
# You are given an array of integers.
#
# Write a script to return true if the given array can be divided into one or
# more groups: each group must be of the same size as the others, with at least
# two members, and with all members having the same value.
#
## Example 1
##
## Input: @ints = (1,1,2,2,2,2)
## Output: true
##
## Groups: (1,1), (2,2), (2,2)
#
#
## Example 2
##
## Input: @ints = (1,1,1,2,2,2,3,3)
## Output: false
##
## Groups: (1,1,1), (2,2,2), (3,3)
#
#
## Example 3
##
## Input: @ints = (5,5,5,5,5,5,7,7,7,7,7,7)
## Output: true
##
## Groups: (5,5,5,5,5,5), (7,7,7,7,7,7)
#
#
## Example 4
##
## Input: @ints = (1,2,3,4)
## Output: false
#
############################################################
##
## discussion
##
############################################################
#
# You can create matching groups if all the numbers of integers of the same
# value are divisible by a common prime. So we check if we find a common prime
# factor: for each prime, check if it is a divisor of the number and count that,
# and if a prime happens to appear as often as there are distinct numbers in
# the input array, we can return "true". If in the end, this wasn't the case
# for any prime from our list, we return "false".

use v5.36;
use List::Util qw(max);

equal_group(1,1,2,2,2,2);
equal_group(1,1,1,2,2,2,3,3);
equal_group(5,5,5,5,5,5,7,7,7,7,7,7);
equal_group(1,2,3,4);

sub equal_group( @ints ) {
    say "Input: (" . join(", ", @ints) . ")";
    my $numbers;
    foreach my $i (@ints) {
        $numbers->{$i}++;
    }
    my $biggest = max( map { $numbers->{$_} } keys %$numbers );
    my @primes;
    foreach my $n (2..$biggest) {
        push @primes, $n if is_prime($n);
    }
    my $primes_found;
    foreach my $n (keys %$numbers) {
        foreach my $prime (@primes) {
            $primes_found->{$prime}++ unless $numbers->{$n} % $prime;
        }
    }
    foreach my $f (keys %$primes_found) {
        return say "true" if $primes_found->{$f} == scalar(keys %$numbers);
    }
    return say "false";
}


### From the solution of the weekly challenge 223:
sub is_prime {
   my $num = shift;
   return 0 if $num == 1;
   my $divider = 2;
   while($divider <= sqrt($num)) {
      if(int($num/$divider) == $num/$divider) {
         return 0;
      }
      $divider++;
   }
   return 1;
}

