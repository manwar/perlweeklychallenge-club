#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

=head1 DESCRIPTION

Consecutive One (Weekly Challenge 325)

Given a binary array, return the length of the longest run of 1s.

=cut

sub consecutive_one (@binary) {
    my ($best, $current) = (0, 0);
    for my $bit (@binary) {
        if ($bit == 1) {
            $current++;
            $best = $current if $current > $best;
        }
        else {
            $current = 0;
        }
    }
    return $best;
}

if (!caller) {
    require Test::More;
    Test::More::is( consecutive_one(0, 1, 1, 0, 1, 1, 1), 3, 'Example 1' );
    Test::More::is( consecutive_one(0, 0, 0, 0), 0, 'Example 2' );
    Test::More::is( consecutive_one(1, 0, 1, 0, 1, 1), 2, 'Example 3' );
    Test::More::done_testing();
}
