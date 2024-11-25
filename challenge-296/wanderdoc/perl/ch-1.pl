#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string of alphabetic characters, $chars.

Write a script to compress the string with run-length encoding, as shown in the examples.

A compressed unit can be either a single character or a count followed by a character.

BONUS: Write a decompression function.
Example 1

Input: $chars = "abbc"
Output: "a2bc"

Example 2

Input: $chars = "aaabccc"
Output: "3ab3c"

Example 3

Input: $chars = "abcc"
Output: "ab2c"

=cut

use List::Util qw(uniq);
use Test2::V0 -no_srand => 1;

is(string_compression('abbc'), 'a2bc', 'Example 1');
is(string_compression('aaabccc'), '3ab3c', 'Example 2');
is(string_compression('abcc'), 'ab2c', 'Example 3');
done_testing();


sub string_compression
{
     my $str = $_[0];
     my @arr = split(//, $str);
     my %counter;
     $counter{$_}++ for @arr;
     my $output = join('',
          map { $counter{$_} > 1 ? join('', $counter{$_}, $_) : $_ } uniq @arr);
     return $output;
}