#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-2.pl - Find Celebrity

=head1 SYNOPSIS

  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a binary matrix (n x n) describing who knows whom, find the celebrity.

A celebrity is someone who:

- is known by everyone else
- knows nobody

Return the celebrity index, or -1 if none exists.

This uses the classic O(n) candidate-elimination approach, followed by a
verification pass.

=cut

sub find_celebrity ($party) {
    my $n = scalar(@$party);
    return -1 if $n == 0;

    my $cand = 0;
    for my $i ( 1 .. $n - 1 ) {
        if ( $party->[$cand][$i] ) {
            $cand = $i;
        }
    }

    for my $i ( 0 .. $n - 1 ) {
        next if $i == $cand;
        return -1 if $party->[$cand][$i];
        return -1 if !$party->[$i][$cand];
    }

    return $cand;
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @party1 = (
        [ 0, 0, 0, 0, 1, 0 ],
        [ 0, 0, 0, 0, 1, 0 ],
        [ 0, 0, 0, 0, 1, 0 ],
        [ 0, 0, 0, 0, 1, 0 ],
        [ 0, 0, 0, 0, 0, 0 ],
        [ 0, 0, 0, 0, 1, 0 ],
    );
    Test::More::is( find_celebrity( \@party1 ), 4, 'Example 1' );

    my @party2 = ( [ 0, 1, 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 0, 1 ], [ 1, 0, 0, 0 ] );
    Test::More::is( find_celebrity( \@party2 ), -1, 'Example 2' );

    my @party3 = (
        [ 0, 0, 0, 0, 0 ],
        [ 1, 0, 0, 0, 0 ],
        [ 1, 0, 0, 0, 0 ],
        [ 1, 0, 0, 0, 0 ],
        [ 1, 0, 0, 0, 0 ],
    );
    Test::More::is( find_celebrity( \@party3 ), 0, 'Example 3' );

    my @party4 = (
        [ 0, 1, 0, 1, 0, 1 ],
        [ 1, 0, 1, 1, 0, 0 ],
        [ 0, 0, 0, 1, 1, 0 ],
        [ 0, 0, 0, 0, 0, 0 ],
        [ 0, 1, 0, 1, 0, 0 ],
        [ 1, 0, 1, 1, 0, 0 ],
    );
    Test::More::is( find_celebrity( \@party4 ), 3, 'Example 4' );

    my @party5 = ( [ 0, 1, 1, 0 ], [ 1, 0, 1, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] );
    Test::More::is( find_celebrity( \@party5 ), -1, 'Example 5' );

    my @party6 = ( [ 0, 0, 1, 1 ], [ 1, 0, 0, 0 ], [ 1, 1, 0, 1 ], [ 1, 1, 0, 0 ] );
    Test::More::is( find_celebrity( \@party6 ), -1, 'Example 6' );

    Test::More::done_testing();
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Run without arguments to execute embedded tests.\n";
}

_run_cli(@ARGV);

