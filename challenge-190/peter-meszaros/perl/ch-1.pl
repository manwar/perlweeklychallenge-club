#!/usr/bin/env perl
#
=head1 Task 1: Capital Detection

Submitted by: Mohammad S Anwar

You are given a string with alphabetic characters only: A..Z and a..z.  Write a
script to find out if the usage of Capital is appropriate if it satisfies at
least one of the following rules:

    1) Only first letter is capital and all others are small.
    2) Every letter is small.
    3) Every letter is capital.

=head2 Example 1

    Input: $s = 'Perl'
    Output: 1

=head2 Example 2

    Input: $s = 'TPF'
    Output: 1

=head2 Example 3

    Input: $s = 'PyThon'
    Output: 0

=head2 Example 4

    Input: $s = 'raku'
    Output: 1

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    ['Perl',   true,  'Example 1'],
    ['TPF',    true,  'Example 2'],
    ['PyThon', false, 'Example 3'],
    ['raku',   true,  'Example 4'],
];

sub capital_detection
{
    my $s = shift;
    return ($s =~ /^[A-Z][a-z]*$/ ||
            $s =~ /^[a-z]+$/      ||
            $s =~ /^[A-Z]+$/) ? true : false;
}

for (@$cases) {
    is(capital_detection($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
