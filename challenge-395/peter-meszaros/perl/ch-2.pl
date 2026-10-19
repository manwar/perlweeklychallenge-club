#!/usr/bin/env perl
#
=head1 Task 2: Word Squares

Submitted by: Mohammad Sajid Anwar

You are given a list of equal lengths words.  Write a script to arrange a set
of words into a grid that reading across any row gives the exact same word as
reading down its corresponding column.

=head2 Example 1

    Input: @words = ("MA", "AM", "MY", "ME")
    Output: ("MA", "AM")

        M A
        A M

=head2 Example 2

    Input: @words = ("SUN", "USE", "NET", "SEE", "TEN")
    Output: ("SUN", "USE", "NET")

        S U N
        U S E
        N E T

=head2 Example 3

    Input: @words = ("BOAT", "TEAL", "AREA", "TSAR", "OGRE")
    Output: ("BOAT", "OGRE", "AREA", "TEAL")

        B O A T
        O G R E
        A R E A
        T E A L

=head2 Example 4

    Input: @words = ("CARD", "AREA", "REAR", "DART")
    Output: ("CARD", "AREA", "REAR", "DART")

        C A R D
        A R E A
        R E A R
        D A R T

=head2 Example 5

    Input: @words = ("HEART", "TREND", "EMBER", "RESIN", "ABUSE")
    Output: ("HEART", "EMBER", "ABUSE", "RESIN", "TREND")

        H E A R T
        E M B E R
        A B U S E
        R E S I N
        T R E N D

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };
use Algorithm::Combinatorics qw/variations/;

my @cases = (
    {words => ["MA", "AM", "MY", "ME"],
        out => ["MA", "AM"],
        name => 'Example 1'},
    {words => ["SUN", "USE", "NET", "SEE", "TEN"],
        out => ["SUN", "USE", "NET"],
        name => 'Example 2'},
    {words => ["BOAT", "TEAL", "AREA", "TSAR", "OGRE"],
        out => ["BOAT", "OGRE", "AREA", "TEAL"],
        name => 'Example 3'},
    {words => ["CARD", "AREA", "REAR", "DART"],
        out => ["CARD", "AREA", "REAR", "DART"],
       name => 'Example 4'},
    {words => ["HEART", "TREND", "EMBER", "RESIN", "ABUSE"],
        out => ["HEART", "EMBER", "ABUSE", "RESIN", "TREND"],
        name => 'Example 5'},
);

sub word_squares
{
    my $words = shift;

    my $n = length($words->[0]);
    my $res;
    my $iter = variations($words, $n);
    NEXTVAR: while (my $p = $iter->next) {
        for my $i (0..$n-1) {
            my $col = join("", map { substr($_, $i, 1) } @$p);
            next NEXTVAR if $col ne $p->[$i];
        }
        $res = $p;
        last;
    }

    return $res;
}

for my $case (@cases) {
    my $got = word_squares($case->{words});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
