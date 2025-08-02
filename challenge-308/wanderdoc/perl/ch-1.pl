#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two array of strings, @str1 and @str2.

Write a script to return the count of common strings in both arrays.
Example 1

Input: @str1 = ("perl", "weekly", "challenge")
       @str2 = ("raku", "weekly", "challenge")
Output: 2

Example 2

Input: @str1 = ("perl", "raku", "python")
       @str2 = ("python", "java")
Output: 1

Example 3

Input: @str1 = ("guest", "contribution")
       @str2 = ("fun", "weekly", "challenge")
Output: 0
=cut

use Test2::V0 -no_srand => 1;

is(count_common(["perl", "weekly", "challenge"], ["raku", "weekly", "challenge"]),
     2, 'Example 1');
is(count_common(["perl", "raku", "python"], ["python", "java"]),
     1, 'Example 2');
is(count_common(["guest", "contribution"], ["fun", "weekly", "challenge"]),
     0, 'Example 3');
done_testing();

sub count_common
{
     my ($aref_1, $aref_2) = @_;
     my %checking = map { $_ => 1 } @$aref_1; 
     my @common = grep { $checking{$_} } @$aref_2;
     return scalar @common // 0;
}