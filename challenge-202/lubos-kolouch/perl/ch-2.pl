#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Int);

=pod

=head1 NAME

ch-2.pl - Widest Valley

=head1 SYNOPSIS

  perl ch-2.pl 1 5 5 2 8
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a profile as a list of altitudes, return the leftmost widest valley.

A valley is a subarray consisting of a non-increasing part followed by a
non-decreasing part (either part can be empty).

=cut

my $ARR_CHECK = compile( ArrayRef [Int] );

sub widest_valley ($profile) {
    ($profile) = $ARR_CHECK->($profile);
    my $n = scalar @$profile;
    return [] if $n == 0;

    my @left_start;
    $left_start[0] = 0;
    for my $i ( 1 .. $n - 1 ) {
        $left_start[$i] = ( $profile->[ $i - 1 ] >= $profile->[$i] ) ? $left_start[ $i - 1 ] : $i;
    }

    my @right_end;
    $right_end[ $n - 1 ] = $n - 1;
    for ( my $i = $n - 2 ; $i >= 0 ; --$i ) {
        $right_end[$i] = ( $profile->[$i] <= $profile->[ $i + 1 ] ) ? $right_end[ $i + 1 ] : $i;
    }

    my ( $best_l, $best_r, $best_len ) = ( 0, 0, 1 );
    for my $p ( 0 .. $n - 1 ) {
        my $l   = $left_start[$p];
        my $r   = $right_end[$p];
        my $len = $r - $l + 1;
        if ( $len > $best_len || ( $len == $best_len && $l < $best_l ) ) {
            ( $best_l, $best_r, $best_len ) = ( $l, $r, $len );
        }
    }

    return [ @$profile[ $best_l .. $best_r ] ];
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @profile = map { 0 + $_ } @args;
    my $out     = widest_valley( \@profile );
    say 'Input:  ' . join( ', ', @profile );
    say 'Output: ' . join( ', ', @$out );
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', profile => [ 1, 5, 5, 2, 8 ], expected => [ 5, 5, 2, 8 ] },
        { label => 'Example 2', profile => [ 2, 6, 8, 5 ], expected => [ 2, 6, 8 ] },
        { label => 'Example 3', profile => [ 9, 8, 13, 13, 2, 2, 15, 17 ], expected => [ 13, 13, 2, 2, 15, 17 ] },
        { label => 'Example 4', profile => [ 2, 1, 2, 1, 3 ], expected => [ 2, 1, 2 ] },
        { label => 'Example 5', profile => [ 1, 3, 3, 2, 1, 2, 3, 3, 2 ], expected => [ 3, 3, 2, 1, 2, 3, 3 ] },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is_deeply( widest_valley( $case->{profile} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 widest_valley($profile)

Returns the leftmost widest valley as an arrayref.

=cut

