#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an encoded string.

Write a script to return the decoded string of the given encoded string.

    The encoding rule is: K[encoded_string], where the encoded_string inside the square brackets is repeated exactly K > 0 times.

Example 1

Input: $str = "2[3[a]]"
Output: "aaaaaa"

3[a]    => aaa
2[3[a]] => aaa aaa

Example 2

Input: $str = "10[a]"
Output: "aaaaaaaaaa"

Example 3

Input: $str = "a2[b]c3[d]e"
Output: "abbcddde"

Example 4

Input: $str = "2[a2[b]c]"
Output: "abbcabbc"

Example 5

Input: $str = "1[a]2[b3[c]]"
Output: "abcccbccc"
=cut

use Test2::V0 -no_srand => 1;

is(decode_string("2[3[a]]"), 'aaaaaa', 'Example 1');
is(decode_string("10[a]"), 'aaaaaaaaaa', 'Example 2');
is(decode_string("a2[b]c3[d]e"), 'abbcddde', 'Example 3');
is(decode_string("2[a2[b]c]"), 'abbcabbc', 'Example 4');
is(decode_string("1[a]2[b3[c]]"), 'abcccbccc', 'Example 5');
done_testing();

sub decode_string
{
     my $str = $_[0];

     while ($str =~ /\[/)
     {
          $str =~ s/([[:digit:]]+)\[([[:alpha:]]+)\]/$2 x $1/e;
     }
     
     return $str;
}
