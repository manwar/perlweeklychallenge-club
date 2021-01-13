#!/usr/bin/perl -w

use strict;
use warnings;
use Test::More;
=head2
TASK #1 › Palindrome Number
Submitted by: Mohammad S Anwar
You are given a number $N.

Write a script to figure out if the given number is Palindrome. Print 1 if true otherwise 0.

Example 1:
Input: 1221
Output: 1
Example 2:
Input: -101
Output: 0, since -101 and 101- are not the same.
Example 3:
Input: 90
Output: 0

=cut

=head2 is_palindrome_number($N)



=cut
sub is_palindrome_number
{
  my $n = shift;
  return 0 if $n < 0;
  return 1 if ($n == reverse $n);
  return 0;
}

for my $p( qw(0 1221 3443 5665) )
{
  ok(is_palindrome_number($p) == 1 );
}

for my $p( qw(-101 1234 5678 90) )
{
  ok(is_palindrome_number($p) == 0 );
}

done_testing(8);