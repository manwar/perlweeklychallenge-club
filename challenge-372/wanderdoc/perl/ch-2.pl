#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string.

Write a script to return the length of the largest substring between two equal characters excluding the two characters. Return -1 if there is no such substring.
Example 1

Input: $str = "aaaaa"
Output: 3

For character "a", we have substring "aaa".

Example 2

Input: $str = "abcdeba"
Output: 5

For character "a", we have substring "bcdeb".

Example 3

Input: $str = "abbc
Output: 0

For character "b", we have substring "".

Example 4

Input: $str = "abcaacbc"
Output: 4

For character "a", we have substring "bca".
For character "b", we have substring "caac".
For character "c", we have substring "aacb".

Example 5

Input: $str = "laptop"
Output: 2

For character "p", we have substring "to".


=cut


use Test2::V0 -no_srand => 1;
is(largest_substring("aaaaa"), 3, "Example 1");
is(largest_substring("abcdeba"), 5, "Example 2");
is(largest_substring("abbc"), 0, "Example 3");
is(largest_substring("abcaacbc"), 4, "Example 4");
is(largest_substring("laptop"), 2, "Example 5");
done_testing();


sub largest_substring
{
     my $str = $_[0];
     my $re = qr/(?<char>.)(.*)\k<char>/;
     my $max = 0;
     while ($str =~ /$re/g)
     {
          my $length = length($2);
          $max = $length > $max ? $length : $max;
          pos($str) -= ($length + 1);
     }
     return $max;
}
