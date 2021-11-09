#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

use List::Util qw{ sum0 uniq };

my @squares = map { $_**2 } 1 .. 100;

for my $n (@squares) {
    my $split = split_number($n);
    say join "\t", '', $split, $n,;
}

sub split_number($n) {
    my $sqrt  = sqrt($n);
    my @split = split //, $n;
    if ( scalar @split == 1 ) {
        my $s = shift @split;
        return $s == $sqrt ? 1 : 0;
    }
    else {
        my @numbers = break_up( 1, @split );
        for my $num (@numbers) {
            my $sum = sum0 split /\D/, $num;
            return 1 if $sqrt == $sum;
        }
    }
    return 0;
}

sub break_up ( $position, @array ) {
    my @output;
    my $len = scalar @array;
    my @dup = @array;
    if ( $len <= $position ) {
        return join '+', @array;
    }

    my @copy;
    my $i = 0;
    while (@dup) {
        if ( $i eq $position ) {
            my $x = shift @dup;
            $copy[-1] .= $x;
        }
        else {
            push @copy, shift @dup;
        }
        $i++;
    }

    push @output, break_up( $position,     @copy );
    push @output, break_up( $position + 1, @array );

    @output = uniq sort grep { defined } @output;
    return @output;
}
