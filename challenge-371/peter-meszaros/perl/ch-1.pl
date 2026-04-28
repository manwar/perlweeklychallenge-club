#!/usr/bin/env perl
#
=head1 Task 1: Missing Letter

Submitted by: Reinier Maliepaard

You are given a sequence of 5 lowercase letters, with one letter replaced by
'?'. Each letter maps to its position in the alphabet ('a = 1', 'b = 2', ... 'z
= 26'). The sequence follows a repeating pattern of step sizes between
consecutive letters. The pattern is either a constant step (e.g., '+2, +2, +2,
+2') or a simple alternating pattern of two distinct steps (e.g., '+2, +3, +2,
+3').

=head2 Example 1

    Input: @seq = qw(a c ? g i)
    Output: e

    The pattern of the sequence is +2,+2,+2,+2.
    1: a
    3: c
    5: e
    7: g
    9: i

=head2 Example 2

    Input: @seq = qw(a d ? j m)
    Output: g

    The pattern of the sequence is +3,+3,+3,+3.
    1: a
    4: d
    7: g
    10: j
    13: m

=head2 Example 3

    Input: @seq = qw(a e ? m q)
    Output: i

    The pattern of the sequence is +4,+4,+4,+4.
    1: a
    5: e
    9: i
    13: m
    17: q

=head2 Example 4

    Input: @seq = qw(a c f ? k)
    Output: h

    The pattern of the sequence is +2,+3,+2,+3.
    1: a
    3: c
    6: f
    8: h
    11: k

=head2 Example 5

    Input: @seq = qw(b e g ? l)
    Output: j

    The pattern of the sequence is +3,+2,+3,+2.
    2: b
    5: e
    7: g
    10: j
    12: l

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[qw/a c ? g i/], 'e', 'Example 1'],
    [[qw/a d ? j m/], 'g', 'Example 2'],
    [[qw/a e ? m q/], 'i', 'Example 3'],
    [[qw/a c f ? k/], 'h', 'Example 4'],
    [[qw/b e g ? l/], 'j', 'Example 5'],
];

sub missing_letter
{
    my $seq = shift;

    my $step = ord($seq->[1]) - ord($seq->[0]);

    for my $i (2 .. 4) {
        return chr(ord($seq->[$i-1]) + $step) if $seq->[$i] eq '?';
    }
    return undef;
}

for (@$cases) {
    is(missing_letter($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
