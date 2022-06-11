#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @n = @ARGV;
@n = ( 1, 2, 3, 4, 5 ) unless scalar @n;
my $n = join ', ', @n;
my $s = summations(@n);
say <<"END";
    Input:  \@n = ($n)
    Output: $s
END

sub summations ( @n ) {
    my $max = -1 + scalar @n;
    my @x   = map {
        [ map { '' } 0 .. $max ]
    } 0 .. $max;
    $x[0]->@* = @n;

    for my $i ( 1 .. $max ) {
        for my $j ( $i .. $max ) {
            my $left  = $x[$i][ $j - 1 ] || 0;
            my $above = $x[ $i - 1 ][$j] || 0;
            $x[$i][$j] = $left + $above;
        }
    }
    return $x[$max][$max];
}
