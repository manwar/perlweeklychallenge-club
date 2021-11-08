#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use List::Util qw(any uniq);

sub main {
    my @target_strings = map { lc } @_;
    die "You must specify one or more chess positions!\n" unless @target_strings;

    # The knight always starts from the top left square.
    unshift @target_strings, 'a8';

    # Find all the targets on the board (0,0 = bottom left)
    my $targets = _input_to_targets(@target_strings);

    # Find the intermediate moves for all possible combinations. We only
    #  need to calculate half of them, as the reverse can be used for going
    #  the other way.
    my @intermediates = ();
    for my $start ( 0 .. $#$targets - 1 ) {
        foreach my $end ( $start + 1 .. $#$targets ) {
            my $intermediate_points = _get_intermediate_moves( @$targets[ $start, $end ] );
            $intermediates[$start][$end] = $intermediate_points;
            $intermediates[$end][$start] = [ reverse @$intermediate_points ];
        }
    }

    # Work through all possible orders of finding the targets
    my @permutations = _get_permutations( [ 1 .. $#$targets ], [] );

    # Now find the path with the least amount of moves
    my @least_moves = ();
    foreach my $permutation (@permutations) {
        # Each value in the array is x, y, and whether this is the target cell.
        my @this_path = ( [ @{ $targets->[0] }, 1 ] );
        foreach my $move ( 1 .. $#$permutation ) {
            # Add the intermediate moves and then the target cell.
            push @this_path,
              map { [ @$_, 0 ] } @{ $intermediates[ $permutation->[ $move - 1 ] ][ $permutation->[$move] ] };
            push @this_path, [ @{ $targets->[ $permutation->[$move] ] }, 1 ];
        }

        if ( @least_moves == 0 or @least_moves > @this_path ) {
            @least_moves = @this_path;
        }
    }

    # And now display it
    say 'The shortest path is ', scalar(@least_moves), ' steps';
    say join ' » ', map { my $cn = _cn( $_->[0], $_->[1] ); $_->[2] ? "*$cn*" : $cn } @least_moves;
}

sub _input_to_targets {
    my @target_strings = @_;
    my @targets        = ();

    # Check there are no dups
    die "One or more targets are listed twice!\n" if @target_strings != uniq(@target_strings);

    # Turn all the input strings into positions on the board. a1 (bottom
    #  left) is (0, 0).
    foreach my $string (@target_strings) {
        if ( $string =~ /^([a-h])([1-8])$/i ) {
            push @targets, [ ord($1) - 97, $2 - 1 ];
        }
        else {
            die "The value '$string' is not a valid chess position!\n";
        }
    }

    return \@targets;
}

sub _get_intermediate_moves {
    my ( $start, $end )   = @_;
    my ( $end_x, $end_y ) = @$end;

    # All the possible moves a knight can move. First value is left
    #  (negative) or right (postive). The second value is up (positive)
    #  or down (negative).
    my @deltas = ( [ 2, 1 ], [ 2, -1 ], [ -2, 1 ], [ -2, -1 ], [ 1, 2 ], [ 1, -2 ], [ -1, 2 ], [ -1, -2 ] );

    # Seed the movements with our start points
    my @moves = ( [$start] );

    # Record which cells have been seen by other movements
    my @seen = ();
    $seen[ $start->[0] ][ $start->[1] ] = 1;

    my $solution = undef;
  FIND: while ( not defined $solution ) {
        my @new_moves = ();

        # Move in each direction as long as we remain on the board
        foreach my $move (@moves) {
            foreach my $delta (@deltas) {
                my $new_x = $move->[-1][0] + $delta->[0];
                my $new_y = $move->[-1][1] + $delta->[1];

                if ( $new_x == $end_x and $new_y == $end_y ) {
                    # We have found the moves from $start to $end
                    $solution = $move;
                    last FIND;
                }

                # Only add this move if we are within the bounds of the
                #  board AND we haven't already moved to this position
                #  previously
                if ( $new_x >= 0 and $new_x <= 7 and $new_y >= 0 and $new_y <= 7 and not $seen[$new_x][$new_y]++ ) {
                    push @new_moves, [ @$move, [ $new_x, $new_y ] ];
                }
            }
        }

        @moves = @new_moves;
    }

    # Remove the starting point and return the intermediate moves
    shift @$solution;
    return $solution;
}

sub _cn {
    # Turn a grid refence to chess notation (0, 0 => a1)
    my ( $x, $y ) = @_;
    return chr( $x + 97 ) . ( $y + 1 );
}

sub _get_permutations {
    # A little recursive function to generate all permutations of the
    #  sets of numbers.
    my ( $remaining, $used ) = @_;
    my @permutations = ();

    if ( $#$remaining == 0 ) {
        # We have a new permutation
        return [ 0, @$used, @$remaining ];
    }

    for my $i ( 0 .. $#$remaining ) {
        # Use one of the remaining numbers (in the order of the array),
        #  any recursively call this function
        my @new_used      = ( @$used, $remaining->[$i] );
        my @new_remaining = @$remaining;
        splice( @new_remaining, $i, 1 );
        push @permutations, _get_permutations( \@new_remaining, \@new_used );
    }

    return @permutations;

}

main(@ARGV);
