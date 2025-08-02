#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ sum0 };

my @examples = (

    [ 1,   2,   3, 45 ],
    [ 1,   12,  3 ],
    [ 1,   2,   3,   4 ],
    [ 236, 416, 336, 350 ],
);

for my $example (@examples) {
    my @ints   = $example->@*;
    my $ints   = join ',', @ints;
    my $output = element_digit_sum(@ints);
    say <<"END";
    Input:  \@ints = ($ints)
    Output: $output
END
}

sub element_digit_sum (@ints) {
    my @digits      = map { split //, $_ } @ints;
    my $element_sum = sum0 @ints;
    my $digit_sum   = sum0 @digits;
    return abs $element_sum - $digit_sum;
}
