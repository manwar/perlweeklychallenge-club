#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a positive integer $number and a mode flag $mode. If the mode flag is zero, calculate little omega (the count of all distinct prime factors of that number). If it is one, calculate big omega (the count of all prime factors including duplicates).

Example 1

Input: $number = 100061
       $mode = 0
Output: 3

Prime factors are 13, 43, 179. Count is 3.
Example 2
Input: $number = 971088
       $mode = 0
Output: 3

Prime factors are 2, 2, 2, 2, 3, 20231. Count of distinct numbers is 3.
Example 3

Input: $number = 63640
       $mode = 1
Output: 6
Prime factors are 2, 2, 2, 5, 37, 43. Count including duplicates is 6.
Example 4
Input: $number = 988841
       $mode = 1
Output: 2

Example 5

Input: $number = 211529
       $mode = 0
Output: 2

=cut


use Test2::V0 -no_srand => 1;

is(prime_factors(100061, 0), 3, "Example 1");
is(prime_factors(971088, 0), 3, "Example 2");
is(prime_factors(63640,  1), 6, "Example 3");
is(prime_factors(988841, 1), 2, "Example 4");
is(prime_factors(211529, 0), 2, "Example 5");
done_testing();

sub prime_factors
{
     my ($number, $mode) = @_;
     my @factors;
     for my $x ( 2 .. $number / 2 )
     {
          if ( $number % $x == 0 )
          {
               push @factors, $x;
               $number /= $x;
               redo;
          }
     }
     if ( $mode == 1 )
     {
          return scalar @factors;
     }
     elsif ( $mode == 0 )
     {
          my %seen;
          return scalar grep {!$seen{$_}++} @factors;
     }
     else
     {
          die "Unknown mode!";
     }
}
