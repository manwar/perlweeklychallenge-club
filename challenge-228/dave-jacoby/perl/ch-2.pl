#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw( min );

my @examples = (

    [ 3, 4, 2 ],
    [ 1, 2, 3 ],

);

for my $e (@examples) {
    my @array  = $e->@*;
    my $array  = join ', ', @array;
    my $output = empty_array(@array);
    say <<~"END";
    Input:  \@int = ($array)
    Output: $output
    END
}

# if the first element is the smallest
#     then remove it
# else
#     move it to the end
sub empty_array (@array) {
    my $c = 0;
    while ( scalar @array ) {
        my $min  = min @array;
        my $next = shift @array;
        if ( $min != $next ) { push @array, $next; }
        $c++;
    }
    return $c;
}
