#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ max sum0 };

my @examples = (

    [
        [ 1, 1, 0, 0, 0 ],
        [ 1, 1, 1, 1, 0 ],
        [ 1, 0, 0, 0, 0 ],
        [ 1, 1, 0, 0, 0 ],
        [ 1, 1, 1, 1, 1 ]
    ],
    [ 
        [ 1, 0, 0, 0 ], 
        [ 1, 1, 1, 1 ], 
        [ 1, 0, 0, 0 ], 
        [ 1, 0, 0, 0 ] 
    ],
);

for my $input (@examples) {
    my @o      = weakest_row($input);
    my $output = join ', ', @o;
    my $matrix = format_matrix($input);

    say <<~"END";
    Input:  \$matrix = $matrix;
    Output: ($output)
    END
}

sub weakest_row ($matrix) {
    my %rank;
    for my $i ( 0 .. -1 + scalar $matrix->@* ) {
        my $r = $matrix->[$i];
        my $s = sum0 $r->@*;
        $rank{$i} = $s;
    }
    my @output = sort { $rank{$a} <=> $rank{$b} } sort keys %rank;
    return @output;
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
