#!/usr/bin/env perl

##############################################################################
# Perl Weekly Challenge #117
##############################################################################
#
# Task #2 - Find Possible Paths
#
# You are given size of a triangle.
#
# Write a script to find all possible paths from top to the bottom right
# corner.
#
# In each step, we can either move horizontally to the right (H), or move
# downwards to the left (L) or right (R).
#
# BONUS: Try if it can handle triangle of size 10 or 20.
#
##############################################################################

use strict;
use warnings;

use Test::More;

if (@ARGV) {
    my $paths = find_possible_paths_through_triangle(@ARGV);
    print join( "\n", @{$paths} ), "\n";
}
else {
    my @tests = (
        { input => 1, output => [qw/LH R/], },
        { input => 2, output => [qw/LHLH LHR LLHH LRH RLH RR/], },
    );

    for my $test (@tests) {

        my $paths = find_possible_paths_through_triangle( $test->{'input'} );

        is( $#{$paths},
            $#{ $test->{'output'} },
            'Got the right number of paths'
        );
        is_deeply( $paths, $test->{'output'}, 'Got the right paths' );
    }

    done_testing();
}

exit;

##############################################################################
#
# Triangle of height 2
#
#    *      [0,0]
#    |\
#    *-*    [1,0] [1,1]
#    | /\
#    *-*-*  [2,0] [2,1] [2,2]

##############################################################################

sub find_possible_paths_through_triangle {
    my $n = shift;

    die "N must be at least one" unless ( $n =~ /^\d+$/ && $n > 0 );

    my $triangle = [];
    return _paths_through_triangle( $triangle, $n, 0, 0 );
}

sub _paths_through_triangle {
    my ( $triangle, $n, $row, $col ) = @_;

    return [''] if ( $row == $n && $col == $n );

    return $triangle->[$row]->[$col] if ( $triangle->[$row]->[$col] );

    if ( $row != $col ) {

        # move horizontal
        my $paths = _paths_through_triangle( $triangle, $n, $row, $col + 1 );
        push @{ $triangle->[$row]->[$col] }, map {"H$_"} @{$paths};
    }

    if ( $row < $n ) {

        # move left
        my $paths = _paths_through_triangle( $triangle, $n, $row + 1, $col );
        push @{ $triangle->[$row]->[$col] }, map {"L$_"} @{$paths};

        # move right
        $paths = _paths_through_triangle( $triangle, $n, $row + 1, $col + 1 );
        push @{ $triangle->[$row]->[$col] }, map {"R$_"} @{$paths};
    }

    return $triangle->[$row]->[$col];
}
