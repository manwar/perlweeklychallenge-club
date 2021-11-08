#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures };
no warnings qw{ experimental };

my @examples;
push @examples, [ 1,  2,  3,  6,  7,  8, 9 ];
push @examples, [ 11, 12, 14, 17, 18, 19 ];
push @examples, [ 2,  4,  6,  8 ];
push @examples, [ 1,  2,  3,  4, 5 ];

for my $e (@examples) {
    my $input  = join ', ', $e->@*;
    my $o      = consecutive_arrays( $e->@* );
    my $output = join ', ', map { qq{[$_]} }
        map { join ', ', $_->@* } $o->@*;

    say <<"END";
    Input:  ( $input )
    Output: ( $output )
END
}

sub consecutive_arrays( @array ) {
    my $output = [];
    while (@array) {
        my $n = shift @array;
        push $output->@*, []
            unless scalar $output->@*
            && $n == $output->[-1][-1] + 1;
        push $output->[-1]->@*, $n;
    }
    return $output;
}
