#!/usr/bin/env perl
#
=head1 Task 2: Outermost Parentheses

Submitted by: Mohammad Sajid Anwar

You are given a valid parentheses string. Write a script to return the string
after removing the outermost parentheses of every primitive string in the
primitive decomposition of the given string.

=head2 Example 1

    Input: $str = "()()()"
    Output: ""

    Primitive Decomposition: "()" + "()" + "()"

=head2 Example 2

    Input: $str = "(((())))"
    Output: "((()))"

    Primitive Decomposition: "(((())))"

=head2 Example 3

    Input: $str = "(()())(())"
    Output: "()()()"

    Primitive Decomposition: "(()())" + "(())"

=head2 Example 4

    Input: $str = "()((()))()"
    Output: "(())"

    Primitive Decomposition: "()" + "((()))" + "()"

=head2 Example 5

    Input: $str = "(()(()))(()())"
    Output: "()(())()()"

    Primitive Decomposition: "(()(()))" + "(()())"

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {str => "()()()",         out => "",           name => 'Example 1'},
    {str => "(((())))",       out => "((()))",     name => 'Example 2'},
    {str => "(()())(())",     out => "()()()",     name => 'Example 3'},
    {str => "()((()))()",     out => "(())",       name => 'Example 4'},
    {str => "(()(()))(()())", out => "()(())()()", name => 'Example 5'},
);

sub outermost_parentheses
{
    my $str = shift;

    my $depth = 1;
    my $close = -1;
    my $start = 0;
    my $result = '';

    for (my $i = 1; $i < length($str); $i++) {
        my $ch = substr($str, $i, 1);

        if ($ch eq '(') {
            $depth++;
        } elsif ($ch eq ')') {
            $depth--;
            if ($depth == 0) {
                my $substr = substr($str, $start, $i - $start + 1);
                $start = $i + 1;
                $result .= substr($substr, 1, length($substr) - 2);
            }
        }
    }
    return $result;
}

for my $case (@cases) {
    my $got = outermost_parentheses($case->{str});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
