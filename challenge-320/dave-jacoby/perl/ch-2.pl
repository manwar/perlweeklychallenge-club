#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{ sum0 };

my @examples = (

    [ 1, 23, 4, 5 ],
    [ 1, 2,  3, 4, 5 ],
    [ 1, 2,  34 ],
);

for my $example (@examples) {
    my $str    = join ', ', $example->@*;
    my $output = sum_diff( $example->@* );
    say <<"END";
    Input:  \$str = ($str)
    Output: $output
END
}

sub sum_diff (@ints) {
    my $digit_sum   = sum0 @ints;
    my $element_sum = sum0 map { split //, $_ } @ints;
    return abs $digit_sum - $element_sum;
}

