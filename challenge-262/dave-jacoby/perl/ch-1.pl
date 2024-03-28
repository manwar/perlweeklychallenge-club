#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = (

    [ -3, 1,  2,  -1, 3, -2, 4 ],
    [ -1, -2, -3, 1 ],
    [ 1,  2 ],

);

for my $example (@examples) {
    my $output = max_pos_neg( $example->@* );
    my @ints   = $example->@*;
    my $ints   = join ',', @ints;
    say <<"END";
    Input:  \@ints = ($ints)
    Output: $output
END
}

sub max_pos_neg (@ints) {
    my $pos = scalar grep { $_ > 0 } @ints;
    my $neg = scalar grep { $_ < 0 } @ints;
    return $pos > $neg ? $pos : $neg;
}
