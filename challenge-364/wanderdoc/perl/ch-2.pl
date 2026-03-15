#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string, $str.

Write a script to interpret the given string using Goal Parser.

    The Goal Parser interprets “G” as the string “G”, “()” as the string “o”, and “(al)” as the string “al”. The interpreted strings are then concatenated in the original order.

Example 1

Input: $str = "G()(al)"
Output: "Goal"

G    -> "G"
()   -> "o"
(al) -> "al"

Example 2

Input: $str = "G()()()()(al)"
Output: "Gooooal"

G       -> "G"
four () -> "oooo"
(al)    -> "al"

Example 3

Input: $str = "(al)G(al)()()"
Output: "alGaloo"

(al) -> "al"
G    -> "G"
(al) -> "al"
()   -> "o"
()   -> "o"

Example 4

Input: $str = "()G()G"
Output: "oGoG"

() -> "o"
G  -> "G"
() -> "o"
G  -> "G"

Example 5

Input: $str = "(al)(al)G()()"
Output: "alalGoo"

(al) -> "al"
(al) -> "al"
G    -> "G"
()   -> "o"
()   -> "o"
=cut



use Test2::V0 -no_srand => 1;


is(goal_parser("G()(al)"), 'Goal', 'Example 1');
is(goal_parser("G()()()()(al)"), 'Gooooal', 'Example 2');
is(goal_parser("(al)G(al)()()"), 'alGaloo', 'Example 3');
is(goal_parser("()G()G"), 'oGoG', 'Example 4');
is(goal_parser("(al)(al)G()()"), 'alalGoo', 'Example 5');
done_testing();

sub goal_parser
{
     my $str = $_[0];
     $str =~ s/\(\)/o/g;
     $str =~ s/\(al\)/al/g;
     return $str;
}
