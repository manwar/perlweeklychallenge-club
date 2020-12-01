#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';

{
    my $MATRIX = [
        [ 1,  2,  3,  4 ],     #
        [ 5,  6,  7,  8 ],     #
        [ 9,  10, 11, 12 ],    #
        [ 13, 14, 15, 16 ],    #
    ];

    say join( ', ', spriral_matrix($MATRIX) )
}

sub spriral_matrix($matrix) {
    my @matrix = @$matrix;

    return () if !@matrix;

    # get top and bottom row  an remove them from the input
    my ( $top, $bot );
    ( $top, @matrix ) = @$matrix;
    ( $bot, @matrix ) = ( $matrix[-1], @matrix[ 0 ... ( $#matrix - 1 ) ] );

    # get left and right side from the remaining rows
    my @right_side = map { $_->[-1] } @matrix;
    @matrix = grep { @$_ } map { [ @{$_}[ 0 ... ( $#$_ - 1 ) ] ] } @matrix;
    my @left_side = map { $_->[0] } @matrix;
    @matrix = grep { @$_ } map { [ @{$_}[ 1 ... ( $#$_ ) ] ] } @matrix;

    return ( @$top, @right_side, reverse( @{ $bot // [] } ),
        reverse(@left_side), spriral_matrix( \@matrix ) );
}
