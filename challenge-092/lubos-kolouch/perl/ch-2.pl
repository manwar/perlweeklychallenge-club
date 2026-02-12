#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-2.pl - Insert Interval

=head1 SYNOPSIS

  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a list of sorted, non-overlapping intervals and a new interval, merge the
new interval into the list (coalescing overlaps) and return the resulting list.

=cut

sub insert_interval ( $intervals, $new_interval ) {
    my ( $new_start, $new_end ) = @$new_interval;

    my @out;
    my $inserted = 0;

    for my $iv (@$intervals) {
        my ( $s, $e ) = @$iv;

        if ( $e < $new_start ) {
            push @out, [ $s, $e ];
            next;
        }

        if ( $new_end < $s ) {
            if ( !$inserted ) {
                push @out, [ $new_start, $new_end ];
                $inserted = 1;
            }
            push @out, [ $s, $e ];
            next;
        }

        $new_start = $s if $s < $new_start;
        $new_end   = $e if $e > $new_end;
    }

    push @out, [ $new_start, $new_end ] if !$inserted;
    return \@out;
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    Test::More::is_deeply(
        insert_interval( [ [ 1, 4 ], [ 8, 10 ] ], [ 2, 6 ] ),
        [ [ 1, 6 ], [ 8, 10 ] ],
        'Example 1'
    );
    Test::More::is_deeply(
        insert_interval( [ [ 1, 2 ], [ 3, 7 ], [ 8, 10 ] ], [ 5, 8 ] ),
        [ [ 1, 2 ], [ 3, 10 ] ],
        'Example 2'
    );
    Test::More::is_deeply(
        insert_interval( [ [ 1, 5 ], [ 7, 9 ] ], [ 10, 11 ] ),
        [ [ 1, 5 ], [ 7, 9 ], [ 10, 11 ] ],
        'Example 3'
    );

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
