#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a list binary digits (0 and 1) and a positive integer, $n.

Write a script to return true if you can re-arrange the list by replacing at least $n digits with 1 in the given list so that no two consecutive digits are 1 otherwise return false.
Example 1

Input: @digits = (1, 0, 0, 0, 1), $n = 1
Output: true

Re-arranged list: (1, 0, 1, 0, 1)

Example 2

Input: @digits = (1, 0, 0, 0, 1), $n = 2
Output: false


=cut

use constant { true => 1, false => 0 };
use Test2::V0 -no_srand => 1;

is(arrange_binary([1, 0, 0, 0, 1], 1), true,  'Example 1');
is(arrange_binary([1, 0, 0, 0, 1], 2), false, 'Example 2');
done_testing();

sub arrange_binary
{
     my ($aref, $n) = @_;
     my $binary = join('', @$aref);
     my $ones = $binary =~ tr/1/1/;
     my $all_ones = $ones + $n;
     return $all_ones > int(scalar @$aref/2) + (scalar @$aref) % 2 ?
          false : true;
}