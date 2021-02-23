#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

# You are given an array @A of items (integers say,
# but they can be anything).
#
# Your task is to pack that array into an MxN matrix
# spirally counterclockwise, as tightly as possible.

if (@ARGV) {
    spiral(@ARGV);
    exit;
}

my @input;
push @input, [ 1 .. 4 ];
push @input, [ 1 .. 6 ];
push @input, [ 1 .. 8 ];
push @input, [ 1 .. 9 ];
push @input, [ 1 .. 12 ];
push @input, [ 1 .. 15 ];
push @input, [ 1 .. 16 ];
push @input, [ 'A' .. 'Y' ];

for my $input (@input) { spiral( $input->@* ) }
exit;

sub spiral ( @array ) {
    my $s = scalar @array;
    my $m = 0;
    my $n = 0;
    my @mn;

    # find the size of the matrix
    for my $x ( 1 .. $s ) {
        for my $y ( 1 .. $s ) {
            if ( $x * $y == $s ) {
                my ( $mm, $nn ) = sort { $a <=> $b } ( $x, $y );
                ( $m, $n ) = ( $mm, $nn ) if $mm > $m;
            }
        }
    }

    # create the matrix we're filling, and fill the matrix
    my $base;
    for my $x ( 1 .. $m ) {
        for my $y ( 1 .. $n ) { $base->[ $x - 1 ][ $y - 1 ] = undef; }
    }
    make_spiral( $base, \@array, 0, $m, $n, $m - 1, 0, 0 );

    say join ', ', @array;
    say '';
    for my $i ( 0 .. -1 + $m ) {
        print '  ';
        for my $j ( 0 .. -1 + $n ) {
            print sprintf( '% 3s', $base->[$i][$j] ) || ' . ';
        }
        say '';
    }
    say '';
}

# again, this looks like a job for recursion

# direction:
#   0 = right
#   1 = up
#   2 = left
#   3 = down
sub make_spiral ( $base, $array, $dir, $m, $n, $x, $y, $i ) {
    my $s = scalar $array->@*;
    $base->[$x][$y] = $array->[$i];

    # handles cases when we need to change $dir
    if (0) { '' }
    elsif ( $dir == 0 && ( $y + 1 >= $n || defined $base->[$x][ $y + 1 ] ) ) {
        $dir = 1;
    }
    elsif ( $dir == 1 && ( $x - 1 < 0 || defined $base->[ $x - 1 ][$y] ) ) {
        $dir = 2;
    }
    elsif ( $dir == 2 && ( $y - 1 < 0 || defined $base->[$x][ $y - 1 ] ) ) {
        $dir = 3;
    }
    elsif ( $dir == 3 && ( $x + 1 < 0 || defined $base->[ $x + 1 ][$y] ) ) {
        $dir = 0;
    }

    # goes to the next spot in the matrix
    # if there's any places in the matrix open still
    if ( scalar grep { !defined } flatten($base) ) {
        if (0) { }
        elsif ( $dir == 0 ) {
            make_spiral( $base, $array, $dir, $m, $n, $x, $y + 1, $i + 1 );
        }
        elsif ( $dir == 1 ) {
            make_spiral( $base, $array, $dir, $m, $n, $x - 1, $y, $i + 1 );
        }
        elsif ( $dir == 2 ) {
            make_spiral( $base, $array, $dir, $m, $n, $x, $y - 1, $i + 1 );
        }
        elsif ( $dir == 3 ) {
            make_spiral( $base, $array, $dir, $m, $n, $x + 1, $y, $i + 1 );
        }
    }

}

# turns a matrix into an array
sub flatten ( $arrayref ) {
    return map { $_->@* } $arrayref->@*;
}
