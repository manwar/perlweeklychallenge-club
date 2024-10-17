#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{ sum0 };

my @examples = (

    [ 2, 3,  -1, 8, 4 ],
    [ 1, -1, 4 ],
    [ 2, 5 ],
);

# [ 1, 1, 0 ] is false, because 1 isn't 2 * 0
# [ 1, 1, 0, 0 ] is true, because 0 is 2 * 0

for my $example (@examples) {
    my $output = middle_index( $example->@* );
    my $input  = join ', ', $example->@*;
    say <<"END";
    Input:  \$ints = ($input)
    Output: $output
END
}

sub middle_index (@array) {
    my $l = -1 + scalar @array;
    for my $i ( 1 .. $l ) {
        my $suml = sum0 @array[ 0 .. $i - 1 ];
        my $sumr = sum0 @array[ $i + 1 .. $l ];
        return $i if $suml eq $sumr;
    }
    return -1;
}
