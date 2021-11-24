#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

my @examples;
push @examples, [ 2, 3, 4 ];
push @examples, [ 3, 3, 6 ];

for my $example (@examples) {
    my $element = solve_task_2( $example->@* );
    say <<"END";
    Input:  \$i = $example->[0]; \$j = $example->[1]; \$k = $example->[2] 
    Output: $element
END
}

sub solve_task_2 ( $i, $j, $k ) {
    my @table;
    for my $x ( 1 .. $i ) {
        for my $y ( 1 .. $j ) {
            $table[ $x - 1 ][ $y - 1 ] = $x * $y;
        }
    }
    my @array = sort { $a <=> $b } flatten(@table);
    return $array[ $k - 1 ] || -1;
}

sub flatten ( @two_d_array ) {
    return map { $_->@* } @two_d_array;
}
