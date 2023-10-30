#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ uniq };

my @examples = (

    [ 0, 2, 9, 4, 6 ],
    [ 5, 1, 3, 2 ],
    [ 2, 2, 3 ],
);

for my $e (@examples) {
    my @ints   = $e->@*;
    my $ints   = join ',', @ints;
    my $output = remove_one(@ints) ? 'true' : 'false';
    say <<~"END";
    Input:  \@ints = ($ints)
    Output: $output
    END
}

sub remove_one (@ints) {
    return 1 if is_in_order(@ints);
    for my $i ( 0 .. -1 + scalar @ints ) {
        my @copy = map { $ints[$_] } grep { $_ != $i } 0 .. -1 + scalar @ints;
        return 1 if is_in_order( @copy );
    }
    return 0;
}

sub is_in_order (@ints) {
    for my $i ( 1 .. -1 + scalar @ints ) {
        my $j = $i - 1;
        return 0 if $ints[$j] > $ints[$i];
    }
    return 1;
}
