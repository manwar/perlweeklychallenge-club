#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = (
    [ 'lacelengh', [ 3, 2, 0, 5, 4, 8, 6, 7, 1 ] ],
    [ 'rulepark',  [ 4, 7, 3, 1, 0, 5, 2, 6 ] ]
);

for my $example (@examples) {
    my $string = $example->[0];
    my $indices = join ',', $example->[1]->@*;
    my $output = reorder_string( $example->[0], $example->[1] );
    say <<~"END";
    Input:  \$string = '$string', \@indices = ($indices)
    Output: '$output'
    END
}

sub reorder_string ( $input, $indices ) {
    my $output = ' ' x length $input;
    my $c = 0;
    for my $i ( $indices->@* ) {
        substr( $output, $i, 1 ) = substr( $input, $c, 1 );
        $c++;
    }
    return $output;
}
