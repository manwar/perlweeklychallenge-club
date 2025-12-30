#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use List::Util      qw(min);
use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Int);

=pod

=head1 NAME

ch-2.pl - Right Interval

=head1 SYNOPSIS

  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

For each interval i = [start_i, end_i], find the index j such that start_j is
the smallest start >= end_i. If none exists, return -1 for that i.

Since all start values are unique, we can sort starts and binary-search.

=cut

my $INTERVALS_CHECK = compile( ArrayRef [ArrayRef [Int]] );

sub _lower_bound ($starts, $value) {
    my ( $lo, $hi ) = ( 0, scalar(@$starts) );
    while ( $lo < $hi ) {
        my $mid = int( ( $lo + $hi ) / 2 );
        if ( $starts->[$mid] < $value ) {
            $lo = $mid + 1;
        }
        else {
            $hi = $mid;
        }
    }
    return $lo;
}

sub right_interval_indices ($intervals) {
    ($intervals) = $INTERVALS_CHECK->($intervals);
    return [] if !@$intervals;

    my @starts;
    for my $i ( 0 .. $#$intervals ) {
        my $start = $intervals->[$i][0];
        push @starts, [ $start, $i ];
    }
    @starts = sort { $a->[0] <=> $b->[0] } @starts;
    my @sorted_starts = map { $_->[0] } @starts;

    my @out;
    for my $i ( 0 .. $#$intervals ) {
        my $end = $intervals->[$i][1];
        my $pos = _lower_bound( \@sorted_starts, $end );
        push @out, $pos == @sorted_starts ? -1 : $starts[$pos][1];
    }
    return \@out;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "CLI not implemented; run without args for tests\n";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        {
            label     => 'Example 1',
            intervals => [ [ 3, 4 ], [ 2, 3 ], [ 1, 2 ] ],
            expected  => [ -1, 0, 1 ],
        },
        {
            label     => 'Example 2',
            intervals => [ [ 1, 4 ], [ 2, 3 ], [ 3, 4 ] ],
            expected  => [ -1, 2, -1 ],
        },
        {
            label     => 'Example 3',
            intervals => [ [ 1, 2 ] ],
            expected  => [-1],
        },
        {
            label     => 'Example 4',
            intervals => [ [ 1, 4 ], [ 2, 2 ], [ 3, 4 ] ],
            expected  => [ -1, 1, -1 ],
        },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = right_interval_indices( $case->{intervals} );
        Test::More::is_deeply( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 right_interval_indices($intervals)

Returns an array reference of indices of right intervals, or -1 when missing.

=cut
