#!/usr/bin/env perl
#
=head1 Task 1: Special Integers

Submitted by: Mohammad S Anwar

You are given a positive integer, $n > 0.  Write a script to print the count of
all special integers between 1 and $n.  An integer is special when all of its
digits are unique.

=head2 Example 1

    Input: $n = 15
    Output: 14 as except 11 all other integers between 1 and 15 are spcial.

=head2 Example 2

    Input: $n = 35
    Output: 32 as except 11, 22, 33 all others are special.

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [15, 14, "Example 1"],
    [35, 32, "Example 2"],
];

sub special_integers
{
    my $n = shift;
    my $count = 0;

    for my $i (1 .. $n) {
        my %seen;
        my $is_special = true;

        for my $digit (split //, $i) {
            if ($seen{$digit}++) {
                $is_special = false;
                last;
            }
        }

        $count++ if $is_special;
    }

    return $count;
}

for (@$cases) {
    is(special_integers($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
