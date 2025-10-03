#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string, $str and a character in the given string, $char.
Write a script to reverse the prefix upto the first occurrence of the given $char in the given string $str and return the new string.

Example 1

Input: $str = "programming", $char = "g"
Output: "gorpramming"

Reverse of prefix "prog" is "gorp".

Example 2

Input: $str = "hello", $char = "h"
Output: "hello"

Example 3

Input: $str = "abcdefghij", $char = "h"
Output: "hgfedcbaij"

Example 4

Input: $str = "reverse", $char = "s"
Output: "srevere"

Example 5

Input: $str = "perl", $char = "r"
Output: "repl"

=cut




use Test2::V0 -no_srand => 1;

is(reverse_prefix("programming", "g"), "gorpramming", "Example 1");
is(reverse_prefix("hello", "h"), "hello", "Example 2");
is(reverse_prefix("abcdefghij", "h"), "hgfedcbaij", "Example 3");
is(reverse_prefix("reverse", "s"), "srevere", "Example 4");
is(reverse_prefix("perl", "r"), "repl", "Example 5");
done_testing();

sub reverse_prefix 
{
     my ($str, $char) = @_;
     my $idx = index($str, $char, 0);
     return reverse(substr($str, 0, $idx + 1)) . substr($str, $idx + 1);
}
