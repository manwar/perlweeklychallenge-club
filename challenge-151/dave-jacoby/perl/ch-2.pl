#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

use List::Util qw{ sum0 };

my @blocks;
push @blocks, [ 2, 4, 5 ];
push @blocks, [ 4, 2, 3, 6, 5, 3 ];
push @blocks, [ 6, 7, 0, 1, 1, 5, 0, 2, 0, 4 ];

for my $block (@blocks) {
    my ( $value, $list ) = plan_robberies($block);
}

sub plan_robberies( $block ) {
    my $b = join ', ', @$block;
    my @x = _plan($block);
    say <<"END";
        Input:  ($b)
        Output: $x[0][0]
                $x[0][1]
END
}

sub _plan ( $block, $index = 0, $list = '' ) {
    my @output;
    if ( !defined $block->[$index] ) {
        my $sum = _score( $block, $list );
        return [ $sum, $list ];
    }

    # don't include this value
    push @output, _plan( $block, $index + 1, $list );

    # include this value
    push @output,
        _plan( $block, $index + 2, join ', ', grep { /\d/ } $list, $index );

    @output = sort { $b->[0] <=> $a->[0] } @output;
    return @output;
}

sub _score ( $block, $list ) {
    return sum0 map { $block->[$_] } grep { /\d/ } split /\D+/, $list;
}
