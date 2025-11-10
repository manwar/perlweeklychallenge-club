#!/usr/bin/env perl
#
=head1 Task 2: Magic Expression

Submitted by: Mohammad Sajid Anwar

You are given a string containing only digits and a target integer.

Write a script to insert binary operators +, - and * between the digits in the
given string that evaluates to target integer.

=head2 Example 1

    Input: $str = "123", $target = 6
    Output: ("1*2*3", "1+2+3")

=head2 Example 2

    Input: $str = "105", $target = 5
    Output: ("1*0+5", "10-5")

=head2 Example 3

    Input: $str = "232", $target = 8
    Output: ("2*3+2", "2+3*2")

=head2 Example 4

    Input: $str = "1234", $target = 10
    Output: ("1*2*3+4", "1+2+3+4")

=head2 Example 5

    Input: $str = "1001", $target = 2
    Output: ("1+0*0+1", "1+0+0+1", "1+0-0+1", "1-0*0+1", "1-0+0+1", "1-0-0+1")

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };
use Algorithm::Combinatorics qw/variations_with_repetition/;


my $cases = [
    [["123",   6], ["1*2*3", "1+2+3"],      "Example 1"],
    [["105",   5], ["1*0+5", "10-5"],       "Example 2"],
    [["232",   8], ["2*3+2", "2+3*2"],      "Example 3"],
    [["1234", 10], ["1*2*3+4", "1+2+3+4"],  "Example 4"],
    [["1001",  2], ["1-0*0+1", "1-0-0+1", "1-0+0+1",
        "1+0*0+1", "1+0-0+1", "1+0+0+1"], , "Example 5"],
];

sub magic_expression
{
    my $str    = $_[0]->[0];
    my $target = $_[0]->[1];

    my @oper = ('*', '-', '+', '');
    my @str = split //, $str;
    my $result;
    my $iter = variations_with_repetition(\@oper, length($str) - 1);
    while (my $c = $iter->next) {
        my $expr;
        for (my $i = 0; $i < length($str) - 1; $i++) {
            $expr .= $str[$i] . $c->[$i];
        }
        $expr .= $str[-1];
        my $eval = eval $expr;
        next if $expr =~ /0\d/;
        if (defined $eval && $eval == $target) {
            push @$result, $expr;
        }
    }
    return $result;
}

for (@$cases) {
    is(magic_expression($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
