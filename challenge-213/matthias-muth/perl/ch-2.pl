#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 213 Task 2: Shortest Route
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';

use Data::Dump qw( pp );
use List::Util qw( sum );

sub shortest_route {
    my ( $routes, $source, $destination ) = @_;

    my %neighbors;
    for my $segment ( @$routes ) {
        for ( 0..$#$segment ) {
            push @{$neighbors{$segment->[$_]}},
                $_ > 0    ? $segment->[$_-1] : (),
                $_ < $#$segment ? $segment->[$_+1] : ();
        }
    }

    my @stack = ( [ $source ] );
    my %visited = ( $source => 1 );
    while ( @stack ) {
        my $path = pop @stack;
        my $last_node = $path->[-1];
        return $path
            if $last_node == $destination;
        if ( $neighbors{$last_node} ) {
            for ( @{$neighbors{$last_node}} ) {
                unless ( $visited{$_} ) {
                    push @stack, [ @$path, $_ ];
                    $visited{$_} = 1;
                }
            }
        }
    }
    return -1;
}


use Test::More;

do {
    is_deeply shortest_route( @{$_->{INPUT}} ), $_->{EXPECTED},
        "shortest_route" . pp( @{$_->{INPUT}} )
            . " == " . pp( $_->{EXPECTED} );
} for (
    { INPUT => [ [ [1,2,6], [5,6,7] ], 1, 7 ], EXPECTED => [ 1,2,6,7 ] },
    { INPUT => [ [ [1,2,3], [4,5,6] ], 2, 5 ], EXPECTED => -1 },
    { INPUT => [ [ [1,2,3], [4,5,6], [3,8,9], [7,8] ], 1, 7 ], EXPECTED => [ 1,2,3,8,7 ] },
);

done_testing;
