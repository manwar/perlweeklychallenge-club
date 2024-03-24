#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ any };

my @examples = (

    { ints => [ 5, 3, 6, 1, 12 ], start => 3 },
    { ints => [ 1, 2, 4, 3 ],     start => 1 },
    { ints => [ 5, 6, 7 ],        start => 2 },
);

for my $example (@examples) {
    my $start  = $example->{start};
    my @ints   = $example->{ints}->@*;
    my $output = multiply_by_two( $start, @ints );
    my $ints   = join ',', @ints;

    say <<"END";
    Input: \@word = ($ints) and \$start = $start
    Output: $output
END
}

sub multiply_by_two ( $start, @ints ) {
    while ( any { $start == $_ } @ints ) {
        $start *= 2;
    }
    return $start;
}
