#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ uniq };

my @examples = (

    [ 1, 0, 2, 3, 0, 4, 5, 0 ],
    [ 1, 2, 3 ],
    [ 0, 3, 0, 4, 5 ],
    [ 0, 1, 0, 0 ],
);

for my $e (@examples) {
    my @ints   = $e->@*;
    my $ints   = join ', ', @ints;
    my @output = duplicate_zeros(@ints);
    my $output = join ', ', @output;
    say <<~"END";
    Input:  \@ints = ($ints)
    Output:         ($output)
    END
}

sub duplicate_zeros (@ints) {
    my @output;
    for my $v (@ints) {
        push @output, $v;
        last if scalar @output >= scalar @ints;
        push @output, $v if $v == 0;
        last if scalar @output >= scalar @ints;
    }
    return @output;
}
