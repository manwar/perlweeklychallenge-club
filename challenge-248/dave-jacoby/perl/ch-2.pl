#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ max sum };

my @examples = (
    [ [ 1, 2, 3, 4 ], [ 5, 6, 7, 8 ], [ 9, 10, 11, 12 ] ],
    [ [ 1, 0, 0, 0 ], [ 0, 1, 0, 0 ], [ 0, 0,  1,  0 ], [ 0, 0, 0, 1 ] ]
);

for my $e (@examples) {
    my $o      = submatrix_sum($e);
    my $input  = format_matrix($e);
    my $output = format_matrix($o);

    say <<~"END";
    Input:  \$a = $input

    Output: \$b = $output
    END
}

sub submatrix_sum ($m) {
    my @output;
    for my $x ( 0 .. -2 + scalar $m->@* ) {
        for my $y ( 0 .. -2 + scalar $m->[$x]->@* ) {
            my @z;
            push @z, $m->[ $x + 0 ][ $y + 0 ];
            push @z, $m->[ $x + 1 ][ $y + 0 ];
            push @z, $m->[ $x + 0 ][ $y + 1 ];
            push @z, $m->[ $x + 1 ][ $y + 1 ];
            my $z = sum @z;
            $output[$x][$y] = $z;
        }
    }
    return \@output;
}

sub format_matrix ($matrix) {
    my $maxlen = max map { length $_ } map { $_->@* } $matrix->@*;
    my $output = join "\n            ", '[', (
        map { qq{  [$_],} }
        map {
            join ',',
                map { pad( $_, 1 + $maxlen ) }
                $_->@*
        }
        map { $matrix->[$_] } 0 .. -1 + scalar $matrix->@*
        ),
        ']';
    return $output;
}

sub pad ( $str, $len = 4 ) {
    return sprintf "%${len}s", $str;
}
