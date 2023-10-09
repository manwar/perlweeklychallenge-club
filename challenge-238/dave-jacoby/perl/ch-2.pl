#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use Algorithm::Permute;
use List::Util qw{ product };

my @examples = (

    [ 15, 99, 1,  34 ],
    [ 50, 25, 33, 22 ],
);

for my $e (@examples) {
    my @int    = $e->@*;
    my $int    = join ', ', @int;
    my @output = persistence_sort(@int);
    my $output = join ', ', @output;
    say <<~"END";
    Input:  \@int = ($int)
    Output: ($output)
    END
}

sub persistence_sort (@nums) {
    my @output =
        map  { $_->[0] }
        sort { $a->[1] <=> $b->[1] }
        map  { [ $_, munge($_) ] } sort @nums;
    return @output;
}

sub munge ($i) {
    my $c = 0;
    while (1) {
        return $c if $i < 10;
        $i = product split //, $i;
        $c++;
    }
    return -1; # just in case
}
