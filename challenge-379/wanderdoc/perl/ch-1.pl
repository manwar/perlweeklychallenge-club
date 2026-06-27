#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string.

Write a script to reverse the given string without using standard reverse function.
Example 1

Input: $str = ""
Output: ""

Example 2

Input: $str = "reverse the given string"
Output: "gnirts nevig eht esrever"

Example 3

Input: $str = "Perl is Awesome"
Output: "emosewA si lreP"

Example 4

Input: $str = "v1.0.0-Beta!"
Output: "!ateB-0.0.1v"

Example 5

Input: $str = "racecar"
Output: "racecar"
=cut






use Test2::V0 -no_srand => 1;

is(reverse_timtowdy(''), '', 'Example 1');
is(reverse_timtowdy('reverse the given string'), 'gnirts nevig eht esrever', 'Example 2');
is(reverse_timtowdy('Perl is Awesome'), 'emosewA si lreP', 'Example 3');
is(reverse_timtowdy('v1.0.0-Beta!'), '!ateB-0.0.1v', 'Example 4');
is(reverse_timtowdy('racecar'), 'racecar', 'Example 5');
done_testing();


sub reverse_timtowdy
{
     my $str = $_[0];
     my @arr = split(//, $str);
     my @output = (undef) x scalar @arr;
     for my $idx ( 0 .. $#arr )
     {
          my $goal_idx = $#arr - $idx;
          $output[$goal_idx] = $arr[$idx];
     }
     return join('', @output);
}
