#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string formed by digits and ‘#'.

Write a script to map the given string to English lowercase characters following the given rules.

- Characters 'a' to 'i' are represented by '1' to '9' respectively.
- Characters 'j' to 'z' are represented by '10#' to '26#' respectively.

Example 1

Input: $str = "10#11#12"
Output: "jkab"

10# -> j
11# -> k
1   -> a
2   -> b

Example 2

Input: $str = "1326#"
Output: "acz"

1   -> a
3   -> c
26# -> z

Example 3

Input: $str = "25#24#123"
Output: "yxabc"

25# -> y
24# -> x
1   -> a
2   -> b
3   -> c

Example 4

Input: $str = "20#5"
Output: "te"

20# -> t
5   -> e

Example 5

Input: $str = "1910#26#"
Output: "aijz"

1   -> a
9   -> i
10# -> j
26# -> z
=cut

use Test2::V0 -no_srand => 1;

is(decrypt_string('10#11#12'), 'jkab', 'Example 1');
is(decrypt_string('1326#'), 'acz', 'Example 2');
is(decrypt_string('25#24#123'), 'yxabc', 'Example 3');
is(decrypt_string('20#5'), 'te', 'Example 4');
is(decrypt_string('1910#26#'), 'aijz', 'Example 5');
done_testing();

sub decrypt_string
{
     my $str = $_[0];
     my %dict;
     @dict{1 .. 9} = 'a' .. 'i';
     @dict{10 .. 26} = 'j' .. 'z';
     $str =~ s/([1-2][0-9])(?=#)/$dict{$1}/ge;
     $str =~ tr/#//ds;
     $str =~ s/([1-9])/$dict{$1}/ge;
     return $str;
}
