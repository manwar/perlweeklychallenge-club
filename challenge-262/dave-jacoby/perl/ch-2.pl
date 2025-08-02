#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = (

    { ints => [ 3, 1, 2, 2, 2, 1, 3 ], k => 2 },
    { ints => [ 1, 2, 3 ], k => 1 },
);

for my $example (@examples) {
    my $k      = $example->{k};
    my @ints   = $example->{ints}->@*;
    my $output = count_equal_divisible( $k, @ints );
    my $ints   = join ',', @ints;
    say <<"END";
    Input: \@ints = ($ints) and \$k = $k
    Output: $output
END
}

sub count_equal_divisible ( $k, @ints ) {
    my $output = 0;
    for my $i ( 0 .. $#ints ) {
        for my $j ( $i + 1 .. $#ints ) {
            next unless $ints[$i] == $ints[$j];
            next unless ( $i * $j ) % $k == 0;
            $output++;
        }
    }
    return $output;
}
