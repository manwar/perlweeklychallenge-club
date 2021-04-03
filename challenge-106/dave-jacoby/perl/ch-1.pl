#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

use JSON;
my $json = JSON->new->pretty;

my $inputs = [

    [ 2, 9, 3, 5 ],
    [ 1, 3, 8, 2, 0 ],
    [5],
    [],

];

for my $input ( $inputs->@* ) {
    my $in = join ', ', $input->@*;
    my $max_gap = max_gap( $input->@* );
    say qq{INPUT:  \@N = ($in)};
    say qq{OUTPUT: $max_gap};
    say '';
}

sub max_gap( @input ) {
    @input = sort { $a <=> $b } @input;
    my $max = 0;
    if ( scalar @input > 1 ) {
        for my $i ( 1 .. -1 + scalar @input ) {
            my $abs = $input[$i] - $input[ $i - 1 ];
            $max = $max < $abs ? $abs : $max;
        }
    }
    return $max;
}
