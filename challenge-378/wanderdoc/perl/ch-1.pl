#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an alphanumeric string.

Write a script to find the second largest distinct digit in the given string. Return -1 if none found.
Example 1

Input: $str = "aaaaa77777"
Output: -1

The only digit in the given string is 7 and there is no second digit.

Example 2

Input: $str = "abcde"
Output: -1

No numerical digits in the given string.

Example 3

Input: $str = "9zero8eight7seven9"
Output: 8

Example 4

Input: $str = "xyz9876543210"
Output: 8

Example 5

Input: $str = "4abc4def2ghi8jkl2"
Output: 4
=cut



use Test2::V0 -no_srand => 1;

is(second_largest_digit("aaaaa77777"), -1, 'Example 1');
is(second_largest_digit("abcde"), -1, 'Example 2');
is(second_largest_digit("9zero8eight7seven9"), 8, 'Example 3');
is(second_largest_digit("xyz9876543210"), 8, 'Example 4');
is(second_largest_digit("4abc4def2ghi8jkl2"), 4, 'Example 5');
done_testing();

sub second_largest_digit
{
     my $str = $_[0];
     $str =~ tr/a-zA-Z//ds;
     return -1 unless length($str);
     my %num;
     $num{$_} = undef for split(//, $str);
     return (sort {$b <=> $a} keys %num)[1] || -1;
}
