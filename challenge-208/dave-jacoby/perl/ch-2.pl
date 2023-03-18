#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ min max };

my @examples = (

    [ 1, 2, 2, 4 ],
    [ 1, 2, 3, 4 ],
    [ 1, 2, 3, 3 ],
);

for my $e (@examples) {
    my $o     = duplicate_and_missing( $e->@* );
    my $array = join ', ', $e->@*;
    say <<"END";
    Input:  \@array = $array
    Output: $o
END
}

sub duplicate_and_missing (@array) {
    my $min = min @array;
    my $max = max @array;

    my $duplicate;
    my $missing;
    for my $i ( $min .. $max ) {
        my $c = () = grep { $_ == $i } @array;
        $duplicate = $i if $c > 1;
        $missing   = $i if $c < 1;
    }
    return -1 if !defined $duplicate && !defined $missing;
    $missing //= $max + 1;
    return join ',', $duplicate, $missing;
}
