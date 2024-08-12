#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 281 Task 2: Knight’s Move
#
#       Perl solution by Matthias Muth.
#

use v5.38;
use feature 'class';
no warnings 'experimental::class';
no warnings 'experimental::for_list';

class Knight {
    field $start :param;

    my @deltas = qw( -2 -1 -2 +1 -1 -2 -1 +2 +1 -2 +1 +2 +2 -1 +2 +1 );

    sub knight_neighbors( $from ) {
        my ( $a_to_h, $row ) = split "", $from;
        my $col = ord( $a_to_h ) - ord( 'a' ) + 1;
        my @neighbors;
        for my ( $dc, $dr ) ( @deltas ) {
            if ( 1 <= $col + $dc <= 8 && 1 <= $row +$dr <= 8 ) {
                my $square = chr( ord( $a_to_h ) + $dc ) . ( $row + $dr );
                push @neighbors, $square;
            }
        }
        return @neighbors;
    }

    method n_moves( $end ) {
        my %distances = ( $start => 0 );
        my @queue = ( $start );
        while ( my $square = shift @queue ) {
            for my $next ( knight_neighbors( $square ) ) {
                next
                    if exists $distances{$next};
                return $distances{$square} + 1
                    if $next eq $end;
                $distances{$next} = $distances{$square} + 1;
                push @queue, $next;
            }
        }
     }
 }

sub knight_s_move( $start, $end ) {
    return Knight->new( start => $start )->n_moves( $end );
}

use Test2::V0 qw( -no_srand );
is knight_s_move( "g2", "a8" ), 4,
    'Example 1: knight_s_move( "g2", "a8" ) == 4';
is knight_s_move( "g2", "h2" ), 3,
    'Example 2: knight_s_move( "g2", "h2" ) == 3';
done_testing;
