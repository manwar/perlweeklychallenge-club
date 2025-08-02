#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

use List::Util qw{ max };

my @examples = (

[1, 2, 2, 4, 1, 5],
[1, 2, 3, 4, 5],
);

for my $input (@examples) {
    my $output = max_freq($input->@*);
    my $ints = join ', ', $input->@*;

    say <<"END";
        Input:  \@ints = ($ints)
        Output: $output
END
}

sub max_freq ( @ints ) {
    my %hash ; 
    map { $hash{$_}++ } @ints;
    my $max = max values %hash;
    my @keys = grep { $hash{$_} == $max } keys %hash;
    return $max * scalar @keys;
}