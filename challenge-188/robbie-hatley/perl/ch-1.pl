#! /usr/bin/perl

# PWCC_188_P1_Pairs_Robbie-Hatley.pl

=pod

Task 1: Divisible Pairs
Submitted by: Mohammad S Anwar

You are given list of integers @list of size $n and divisor $k.

Write a script to find out count of pairs in the given list
that satisfies the following rules.

The pair (i, j) is eligible if and only if
a) 0 <= i < j < len(list)
b) list[i] + list[j] is divisible by k

Example 1

Input: @list = (4, 5, 1, 6), $k = 2
Output: 2

Example 2

Input: @list = (1, 2, 3, 4), $k = 2
Output: 2

Example 3

Input: @list = (1, 3, 4, 5), $k = 3
Output: 2

Example 4

Input: @list = (5, 1, 2, 3), $k = 4
Output: 2

Example 5

Input: @list = (7, 2, 4, 5), $k = 4
Output: 1

=cut

# NOTE: Input is via command-line arguments, which should be
#       a space-separated list of integers followed by a divisor.

# NOTE: Output is to stdout and will be a non-negative integer giving
#       "number of pairs whose sum is divisible by divisor".

use v5.36;
die if scalar(@ARGV) < 3;     # Must have at least 2 items & divisor.
my $k = splice(@ARGV, -1, 1); # Slice $k off of right end of @ARGV.
my $count = 0;                # Start with count = 0.
for ( my $i = 0 ; $i <= $#ARGV - 1 ; ++$i )        # for each first item
{
   for ( my $j = $i + 1 ; $j <= $#ARGV ; ++$j )    # for each second item
   {
      ++$count if 0 == ($ARGV[$i]+$ARGV[$j]) % $k; # sum is divisible?
   }
}
say $count;
exit;
__END__
