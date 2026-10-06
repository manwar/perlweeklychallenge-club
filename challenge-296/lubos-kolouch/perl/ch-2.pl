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

ch-2.pl - Matchstick Square (WWC 296 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

This script determines if it's possible to form a square using all the sticks provided
in an array, where each stick's length is given, and each side of the square is formed
by combining one or more sticks.

=cut

my $INTS_CHECK = compile( ArrayRef [Int] );

sub can_form_square ($sticks_ref) {
    ($sticks_ref) = $INTS_CHECK->($sticks_ref);
    my @sticks = @$sticks_ref;
    return 'false' if @sticks < 4;

    my $total_length = 0;
    $total_length += $_ for @sticks;

    return 'false' if $total_length % 4 != 0;

    my $side_length = $total_length / 4;

    # Sort sticks in descending order to optimize pruning
    @sticks = sort { $b <=> $a } @sticks;

    return 'false' if $sticks[0] > $side_length;

    my @sides = ( 0, 0, 0, 0 );
    return _dfs( \@sticks, 0, \@sides, $side_length ) ? 'true' : 'false';
}

sub _dfs ( $sticks_ref, $index, $sides_ref, $target ) {
    if ( $index == @$sticks_ref ) {
        for my $side (@$sides_ref) {
            return 0 if $side != $target;
        }
        return 1;
    }

    my $stick = $sticks_ref->[$index];
    for my $i ( 0 .. 3 ) {
        if ( $sides_ref->[$i] + $stick <= $target ) {
            $sides_ref->[$i] += $stick;
            if ( _dfs( $sticks_ref, $index + 1, $sides_ref, $target ) ) {
                return 1;
            }
            $sides_ref->[$i] -= $stick;
        }

        # If the side is 0, no need to try other empty sides at this level
        if ( $sides_ref->[$i] == 0 ) {
            last;
        }
    }
    return 0;
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
        { label => 'Example 1', sticks => [ 1, 2, 2, 2, 1 ],    expected => 'true' },
        { label => 'Example 2', sticks => [ 2, 2, 2, 4 ],       expected => 'false' },
        { label => 'Example 3', sticks => [ 2, 2, 2, 2, 4 ],    expected => 'false' },
        { label => 'Example 4', sticks => [ 3, 4, 1, 4, 3, 1 ], expected => 'true' },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( can_form_square( $case->{sticks} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 can_form_square(\@ints)

Returns 'true' if it's possible to form a square using all sticks, 'false' otherwise.

=cut
