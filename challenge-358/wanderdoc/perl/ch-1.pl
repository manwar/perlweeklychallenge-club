#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of alphanumeric string, @strings.

Write a script to find the max value of alphanumeric string in the given array. The numeric representation of the string, if it comprises of digits only otherwise length of the string.
Example 1

Input: @strings = ("123", "45", "6")
Output: 123

"123" -> 123
"45"  -> 45
"6"   -> 6


Example 2

Input: @strings = ("abc", "de", "fghi")
Output: 4

"abc"  -> 3
"de"   -> 2
"fghi" -> 4


Example 3

Input: @strings = ("0012", "99", "a1b2c")
Output: 99

"0012"  -> 12
"99"    -> 99
"a1b2c" -> 5


Example 4

Input: @strings = ("x", "10", "xyz", "007")
Output: 10

"x"   -> 1
"xyz" -> 3
"007" -> 7
"10"  -> 10


Example 5

Input: @strings = ("hello123", "2026", "perl")
Output: 2026

"hello123" -> 8
"perl"     -> 4
"2026"     -> 2026

=cut

use Test2::V0 -no_srand => 1;
is(max_str_value("123", "45", "6"), 123, "Example 1");
is(max_str_value("abc", "de", "fghi"), 4, "Example 2");
is(max_str_value("0012", "99", "a1b2c"), 99, "Example 3");
is(max_str_value("x", "10", "xyz", "007"), 10, "Example 4");
is(max_str_value("hello123", "2026", "perl"), 2026, "Example 5");

done_testing();


sub max_str_value
{
     my @arr = @_;
     my $max = 0;
     for my $elm ( @arr )
     {
          my $val = $elm =~/\D/ ? length($elm) : $elm;
          $max = $val > $max ? $val : $max;
     }
     return $max;
}
