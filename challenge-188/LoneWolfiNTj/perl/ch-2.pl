#! /usr/bin/perl

# PWCC_188_P2_Zero_Robbie-Hatley.pl

=pod

Task 2: Total Zero
Submitted by: Mohammad S Anwar

You are given two positive integers $x and $y.

Write a script to find out the number of operations needed to make both ZERO. Each operation is made up either of the followings:

$x = $x - $y if $x >= $y

or

$y = $y - $x if $y >= $x (using the original value of $x)

Example 1

Input: $x = 5, $y = 4
Output: 5

Example 2

Input: $x = 4, $y = 6
Output: 3

Example 3

Input: $x = 2, $y = 5
Output: 4

Example 4

Input: $x = 3, $y = 1
Output: 3

Example 5

Input: $x = 7, $y = 4
Output: 5

=cut

# NOTE: Input is via command-line arguments, which should be
#       a space-separated list of integers followed by a divisor.

# NOTE: Output is to stdout and will be a non-negative integer giving
#       "number of pairs whose sum is divisible by divisor".

use v5.36;
die if scalar(@ARGV) != 2;                         # Must have 2 numbers.
my $x = $ARGV[0];
my $y = $ARGV[1];
my $ops_count = 0;
while (0 != $x && 0 != $y)
{
      if ($x >= $y) {$x -= $y; ++$ops_count;}
   elsif ($y >= $x) {$y -= $x; ++$ops_count;}
}
say $ops_count;
exit;
__END__
