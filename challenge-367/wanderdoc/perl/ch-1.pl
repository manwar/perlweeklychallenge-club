#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a binary string that has at least one '1'.

Write a script to rearrange the bits in such a way that the resulting binary number is the maximum odd binary number and return the resulting binary string. The resulting string can have leading zeros.
Example 1

Input: $str = "1011"
Output: "1101"

"1101" is max odd binary (13).

Example 2

Input: $str = "100"
Output: "001"

"001" is max odd binary (1).

Example 3

Input: $str = "111000"
Output: "110001"

Example 4

Input: $str = "0101"
Output: "1001"

Example 5

Input: $str = "1111"
Output: "1111"

=cut



use List::MoreUtils qw(all none first_index);
use Test2::V0 -no_srand => 1;
is(max_binary("1011"), "1101", "Example 1");
is(max_binary("100"), "001", "Example 2");
is(max_binary("111000"), "110001", "Example 3");
is(max_binary("0101"), "1001", "Example 4");
is(max_binary("1111"), "1111", "Example 5");

done_testing();

sub max_binary
{
     my $str = $_[0];
     my @arr = split(//, $str);
     return $str if ( (all { $_ == 1 } @arr) or (none { $_ == 1 } @arr) );
     my $idx_of_one = first_index { $_ == 1 } @arr;
     # return $str if $idx_of_one == -1;
     my $a_one = splice(@arr, $idx_of_one,1);
     @arr = sort { $b <=> $a } @arr;
     return join('', @arr, $a_one);
}
