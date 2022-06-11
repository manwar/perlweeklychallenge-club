#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

use List::Util qw{ sum0 };

my @examples;
push @examples, [ 1, 3, 5, 7, 9 ];
push @examples, [ 1, 2, 3, 4, 5 ];
push @examples, [ 2, 4, 2 ];

for my $e (@examples) {
    my $i  = equilibrium_index( $e->@* );
    my $ee = join ', ', $e->@*;

    say <<"END";
        Input:  \@n = $ee
        Output: $i
END
}

sub equilibrium_index ( @array ) {

    for my $i ( 1 .. $#array - 1 ) {
        my @s1 = @array[ 0 .. $i - 1 ];
        my @s2 = @array[ $i + 1 .. $#array ];
        my $sum1 = sum0 @s1;
        my $sum2 = sum0 @s2;
        return $i if $sum1 == $sum2;
    }
    return -1;
}
