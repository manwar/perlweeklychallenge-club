#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

use List::Util qw{ first };

my @examples = (

    [ 2, 5, 3, 4 ],
    [ 9, 4, 1, 3, 6, 4, 6, 1 ],
    [ 1, 2, 2, 3 ],
);

for my $example (@examples) {
    my @output = number_game( $example->@* );
    my $output = join ', ', @output;
    my $ints = join ', ', $example->@*;

    say <<"END";
        Input:  \@ints = ($ints)
        Output: ($output)
END
}

sub number_game (@ints) {
    my @sorted = sort { $a <=> $b } @ints;
    my @output;
    while (@sorted) {
        my @cache;
        push @cache, shift @sorted;
        push @cache, shift @sorted;
        @cache = reverse @cache;
        push @output, @cache;
    }
    return @output;
}
