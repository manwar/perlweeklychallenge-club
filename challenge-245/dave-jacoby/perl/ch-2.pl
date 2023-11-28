#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use Algorithm::Combinatorics qw{ variations };

my @examples = (

    [ 8, 1, 9 ],
    [ 8, 6, 7, 1, 0 ],
    [1],
    [ 9, 0, 1, 2, 5 ]
);
for my $e (@examples) {
    my $input  = join ', ', $e->@*;
    my $output = largest_of_three( $e->@* );

    say <<~"END";
    Input:  \$input = ($input)
    Output:          $output
    END
}

sub largest_of_three (@input) {
    my @output;
    my $o = -1;
    for my $c ( reverse 1 .. scalar @input ) {
        my $iter = variations( \@input, $c );
        while ( my $p = $iter->next ) {
            my $combo = 0 + join '', $p->@*;
            next        if $combo % 3 != 0;
            $o = $combo if $combo > $o;
        }
    }
    return $o;
}
