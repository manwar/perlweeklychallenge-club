#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ max };

my @examples = (

    [ 1,  2, 3, 4, 5, 6, 7 ],
    [ 2,  4, 1, 3 ],
    [ 10, 5, 7, 12, 8 ],
);

for my $e (@examples) {
    my $o     = max_xor( $e->@* );
    my $array = $e->@*;
    say <<"END";
    Input:  \@array = $array
    Output: $o
END
}

sub max_xor ( @array ) {
    my @output;
    for my $i ( 0 .. -2 + scalar @array ) {
        my $ii = $array[$i];
        for my $j ( $i + 1 .. -1 + scalar @array ) {
            my $jj = $array[$j];
            my $x =  $ii ^ $jj;
            push @output, $x;
        }
    }
    return max @output;
}
