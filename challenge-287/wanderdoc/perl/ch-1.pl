#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string, $str.

Write a program to return the minimum number of steps required to make the given string very strong password. If it is already strong then return 0.

Criteria:

- It must have at least 6 characters.
- It must contains at least one lowercase letter, at least one upper case letter and at least one digit.
- It shouldn't contain 3 repeating characters in a row.

Following can be considered as one step:

- Insert one character
- Delete one character
- Replace one character with another

Example 1

Input: $str = "a"
Output: 5

Example 2

Input: $str = "aB2"
Output: 3

Example 3

Input: $str = "PaaSW0rd"
Output: 0

Example 4

Input: $str = "Paaasw0rd"
Output: 1

Example 5

Input: $str = "aaaaa"
Output: 2
=cut



use Test2::V0;
use List::Util qw(sum max);

is(evaluate("a"), 5, 'Example 1');
is(evaluate("aB2"), 3, 'Example 2');
is(evaluate("PaaSW0rd"), 0, 'Example 3');
is(evaluate("Paaasw0rd"), 1, 'Example 4');
is(evaluate("aaaaa"), 2, 'Example 5');

done_testing();

sub evaluate
{
     my $fragment = $_[0];

     my $steps = 0;
     my $steps_length = max(0, 6 - length($fragment));

     my $steps_repeating = $fragment =~ /((?<char>.)\k<char>{2,})/ ?
          int(length($1)/3) : 0;
     my $steps_lc = $fragment =~ /[a-z]/ ? 0 : 1;
     my $steps_uc = $fragment =~ /[A-Z]/ ? 0 : 1;
     my $steps_num = $fragment =~ /[0-9]/ ? 0 : 1;
     $steps = 
          max($steps_length, $steps_repeating, sum($steps_lc, $steps_uc, $steps_num));
     return $steps; 
}
