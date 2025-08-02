#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two strings, $str1 and $str2. Write a script to merge the given strings by adding in alternative order starting with the first string. If a string is longer than the other then append the remaining at the end.
Example 1 Input: $str1 = "abcd", $str2 = "1234" Output: "a1b2c3d4"
Example 2 Input: $str1 = "abc", $str2 = "12345" Output: "a1b2c345"
Example 3 Input: $str1 = "abcde", $str2 = "123" Output: "a1b2c3de"
=cut








use List::MoreUtils qw(mesh);
use Test2::V0;

sub merge_strings
{
     return join('', 
          grep defined, 
               mesh(
                    @{[split(//,$_[0])]},
                    @{[split(//,$_[1])]}
                    )
               );
}

is(merge_strings("abcd", "1234"), "a1b2c3d4", "Example 1");
is(merge_strings("abc", "12345"), "a1b2c345", "Example 2");
is(merge_strings("abcde", "123"), "a1b2c3de", "Example 3");
done_testing();
