#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ sum0 };

my @examples = (

    {
        ints => [ 2, 5, 9, 11, 3 ],
        k    => 1
    },
    {
        ints => [ 2, 5, 9, 11, 3 ],
        k    => 2
    },
    {
        ints => [ 2, 5, 9, 11, 3 ],
        k    => 0
    }
);

for my $example (@examples) {
    my @output = sum_of_values($example);
    my $ints   = join ', ', $example->{ints}->@*;
    my $k      = join ', ', $example->{k};
    my $output = join ', ', @output;

    say <<~"END";
    Input:  \@ints = ($ints), \$k = $k
    Output: $output
    END
}

sub sum_of_values ($obj) {
    my @ints   = $obj->{ints}->@*;
    my $k      = $obj->{k};
    my $output = 0;

    for my $i ( 0 .. $#ints ) {
        my $s = sum0 split //, sprintf '%b', $i;
        $output += $ints[$i] if $s == $k;
    }
    return $output;
}
