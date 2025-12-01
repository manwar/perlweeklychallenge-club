#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string.

Write a script to return the number of good substrings of length three in the given string.

    A string is good if there are no repeated characters.

Example 1

Input: $str = "abcaefg"
Output: 5
Good substrings of length 3: abc, bca, cae, aef and efg

Example 2

Input: $str = "xyzzabc"
Output: 3

Good substrings of length 3: "xyz", "zab" and "abc"

Example 3

Input: $str = "aababc"
Output: 1

Good substrings of length 3: "abc"


Example 4

Input: $str = "qwerty"
Output: 4

Good substrings of length 3: "qwe", "wer", "ert" and "rty"


Example 5

Input: $str = "zzzaaa"
Output: 0
=cut




use Test2::V0 -no_srand => 1;
is(good_substrings("abcaefg", 3), 5, 'Example 1');
is(good_substrings("xyzzabc", 3), 3, 'Example 2');
is(good_substrings("aababc", 3), 1, 'Example 3');
is(good_substrings("qwerty", 3), 4, 'Example 4');
is(good_substrings("zzzaaa", 3), 0, 'Example 5');
done_testing();


sub good_substrings
{
     my ($str, $length) = @_;
     my $x = 0;
     my $str_length = length($str);
     my $counter = 0;

     while ( $x < ($str_length - $length + 1) )
     {
          my %letters;
          @letters{ split(//,substr($str, $x, $length))} = undef;
          $counter++ if (scalar(keys %letters) == $length);
          $x++;
     }
     return $counter;
}
