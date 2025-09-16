#!/usr/bin/env perl
use strict;
use warnings;

=head1 NAME

ch-2.pl - The Weekly Challenge 339 Task 2: Peak Point

=head1 DESCRIPTION

Given a list of altitude gains, compute the cumulative altitude starting at
zero and return the highest altitude reached. The script processes the gains in
order, keeps the running total, and tracks the maximum value encountered.

=head1 AUTHOR

Lubos Kolouch

=cut

use constant GainList => 'ARRAY';
use Test::More tests => 5;

sub peak_point {
    my (@gains) = @_;

    my $current = 0;
    my $max_alt = 0;
    for my $delta (@gains) {
        $current += $delta;
        $max_alt = $current if $current > $max_alt;
    }

    return $max_alt;
}

subtest 'Example 1' => sub {
    my @gain = ( -5, 1, 5, -9, 2 );
    is( peak_point(@gain), 1, 'Peak altitude is 1' );
};

subtest 'Example 2' => sub {
    my @gain = ( 10, 10, 10, -25 );
    is( peak_point(@gain), 30, 'Peak altitude is 30' );
};

subtest 'Example 3' => sub {
    my @gain = ( 3, -4, 2, 5, -6, 1 );
    is( peak_point(@gain), 6, 'Peak altitude is 6' );
};

subtest 'Example 4' => sub {
    my @gain = ( -1, -2, -3, -4 );
    is( peak_point(@gain), 0, 'Peak altitude is 0' );
};

subtest 'Example 5' => sub {
    my @gain = ( -10, 15, 5 );
    is( peak_point(@gain), 10, 'Peak altitude is 10' );
};
