#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string containing only lower case English letters and digits.
Write a script to remove all digits by removing the first digit and the closest non-digit character to its left.

Example 1

Input: $str = "cab12"
Output: "c"

Round 1: remove "1" then "b" => "ca2"
Round 2: remove "2" then "a" => "c"


Example 2

Input: $str = "xy99"
Output: ""

Round 1: remove "9" then "y" => "x9"
Round 2: remove "9" then "x" => ""


Example 3

Input: $str = "pa1erl"
Output: "perl"
=cut

use Test2::V0 -no_srand => 1;
is(clear_digits("cab12"), "c", "Example 1");
is(clear_digits("xy99"), "", "Example 2");
is(clear_digits("pa1erl"), "perl", "Example 3");
done_testing();



sub clear_digits
{
     my $str = $_[0];
     while ( $str =~ /\d/ )
     {
          $str =~ s/([a-z]\d)//;
     }
     return $str;
}
