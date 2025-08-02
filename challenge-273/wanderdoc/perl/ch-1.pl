#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string, $str and a character $char.

Write a script to return the percentage, nearest whole, of given character in the given string.
Example 1

Input: $str = "perl", $char = "e"
Output: 25

Example 2

Input: $str = "java", $char = "a"
Output: 50

Example 3

Input: $str = "python", $char = "m"
Output: 0

Example 4

Input: $str = "ada", $char = "a"
Output: 67

Example 5

Input: $str = "ballerina", $char = "l"
Output: 22

Example 6

Input: $str = "analitik", $char = "k"
Output: 13
=cut


use List::Util qw(sum);
# use Math::Round;
use Test2::V0;

# sprintf uses the Round half to even method.
# Math::Round would do the right thing.
# Here we imitate  $Math::Round::half to fix the sprintf behavior.
use constant epsilon => 1e-6;

is(percentage_character('perl', 'e'), 25, 'Example 1');
is(percentage_character('java', 'a'), 50, 'Example 2');
is(percentage_character('python', 'm'), 0, 'Example 3');
is(percentage_character('ada', 'a'), 67, 'Example 4');
is(percentage_character('ballerina', 'l'), 22, 'Example 5');
is(percentage_character('analitik', 'k'), 13, 'Example 6');
done_testing();


sub percentage_character
{
     my $string = $_[0];
     my $character = $_[1];
     my %freq;
     for my $chr (split(//, lc $string))
     {
          $freq{$chr}++;
     }
     my $this_freq = $freq{ lc $character } // 0;
     return # round($this_freq * 100 / sum(values %freq));
          sprintf("%.0f", (epsilon + $this_freq / sum(values %freq)) * 100 );
}