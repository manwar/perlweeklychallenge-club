#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

my @examples = (

    [ -3, 2, -3, 4, 2 ],
    [ 1,  2 ],
    [ 1,  -2, -3 ],
);

for my $example (@examples) {
    my $ints   = join ', ', $example->@*;
    my $output = step_by_step( $example->@* );
    say <<"END";
    Input:  \@ints = ($ints)
    Output: $output
END
}

sub step_by_step (@array) {
    my $max = 20;
    my $v;
OUTER: for my $i ( 1 .. $max ) {
        my $n = $i;
        for my $v (@array) {
            $n += $v;
            next OUTER if $n < 1;
        }
        $v = $i;
        last ;
    }
    return $v;
}

