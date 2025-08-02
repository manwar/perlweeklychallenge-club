#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a binary array.

Write a script to return an array of booleans where the partial binary number up to that point is prime.
Example 1

Input: @binary = (1, 0, 1)
Output: (false, true, true)

Sub-arrays (base-10):
(1): 1 - not prime
(1, 0): 2 - prime
(1, 0, 1): 5 - prime

Example 2

Input: @binary = (1, 1, 0)
Output: (false, true, false)

Sub-arrays (base-10):
(1): 1 - not prime
(1, 1): 3 - prime
(1, 1, 0): 6 - not prime

Example 3

Input: @binary = (1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1)
Output: (false, true, true, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, true)

=cut

use Math::Prime::Util qw(primes);
use constant { true => 1, false => 0 };
use Test2::V0 -no_srand => 1;



is(bin_prefix(1, 0, 1), [false, true, true], 'Example 1');
is(bin_prefix(1, 1, 0), [false, true, false], 'Example 2');
is(bin_prefix(1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1),
     [false, true, true, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, true], 'Example 3');
done_testing();



sub bin_prefix
{
     my @arr = @_;
     my $max = oct("0b" . '1' x scalar(@arr)); 
     my %primes_bin = map { sprintf("%b", $_) => true }  
          @{ primes($max) };
     my @output;
     for my $idx ( 0 .. $#arr )
     {
          push @output, 
               $primes_bin{ join('', @arr[0 .. $idx]) } // false;
     }
     return \@output;
}




