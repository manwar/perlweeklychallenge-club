#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ min max };
use JSON;
my $j = JSON->new->pretty;

my @examples = (

    [ 
        [ 3, 7,  8 ], 
        [ 9, 11, 13 ], 
        [ 15, 16, 17 ] 
    ],
    [ 
        [ 1, 10, 4, 2 ],
        [ 9,  3,  8,  7 ],
        [ 15, 16, 17, 12 ] 
    ],
    [   
        [ 7, 8 ],
        [ 1, 2 ] 
    ],
);
for my $e (@examples) {
    my $input  = format_matrix($e);
    my $output = lucky_numbers($e);

    say <<~"END";
    Input:  \$matrix = $input
    Output: $output
    END
}

sub lucky_numbers ($matrix) {
    for my $i ( 0 .. -1 + scalar $matrix->@* ) {
        for my $j ( 0 .. -1 + scalar $matrix->[$i]->@* ) {
            my $value = $matrix->[$i][$j];
            my @row   = $matrix->[$i]->@*;
            my @col = map { $matrix->[$_][$j] } 0 .. -1 + scalar $matrix->@*;
            return $value if ( $value == min @row ) && ( $value == max @col );
        }
    }
    return -1;    #no luck
}

sub format_matrix ($matrix) {
    my $maxlen = max map { length $_ } map { $_->@* } $matrix->@*;
    my $output = join "\n                  ", '[', (
        map { qq{  [$_],} } map {
            join ',',
                map { pad( $_, 1 + $maxlen ) }
                $_->@*
        } map { $matrix->[$_] } 0 .. -1 + scalar $matrix->@*
        ),
        ']';
    return $output;
}

sub pad ( $str, $len = 4 ) { return sprintf "%${len}s", $str; }
