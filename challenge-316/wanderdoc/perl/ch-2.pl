#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two string.

Write a script to find out if one string is a subsequence of another.

A subsequence of a string is a new string that is formed from the original string
by deleting some (can be none) of the characters without disturbing the relative
positions of the remaining characters.

Example 1

Input: $str1 = "uvw", $str2 = "bcudvew"
Output: true

Example 2

Input: $str1 = "aec", $str2 = "abcde"
Output: false

Example 3

Input: $str1 = "sip", $str2 = "javascript"
Output: true
=cut

use constant { true => 1, false => 0 };
use utf8;
use Test2::V0 -no_srand => 1;

is(is_subsequence("uvw", "bcudvew"), true, 'Example 1');
is(is_subsequence("aec", "abcde"), false, 'Example 2');
is(is_subsequence("sip", "javascript"), true, 'Example 3');
done_testing();

sub is_subsequence
{
     my ($str1, $str2) = map { utf8::upgrade($_); $_ } @_;
     if ( length($str1) > length($str2) )
     {
          ($str1, $str2) = ($str2, $str1);
     }
     my $str_to_re = join('\p{L}*', split(//, $str1));
     my $re = qr/$str_to_re/;
     return $str2 =~ /$re/ ? true : false;
}
