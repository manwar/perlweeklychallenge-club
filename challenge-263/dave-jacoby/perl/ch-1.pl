#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = (

    { ints => [ 1, 5, 3, 2, 4, 2 ], k => 2 },
    { ints => [ 1, 2, 4, 3, 5 ],    k => 6 },
    { ints => [ 5, 3, 2, 4, 2, 1 ], k => 4 },
);

for my $example (@examples) {
    my @output = target_index($example);
    my $output = join ', ', @output;
    my $ints   = join ', ', $example->{ints}->@*;
    my $k      = $example->{k};
    say <<"END";
    Input:  \@ints = ($ints), \$k = $k
    Output: ($output)
END
}

sub target_index ($obj) {
    my @sorted = sort { $a <=> $b } $obj->{ints}->@*;
    my $k      = $obj->{k};
    my @output = grep { $k == $sorted[$_] } 0 .. $#sorted;
    return @output;
}
