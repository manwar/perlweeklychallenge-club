#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';

sub print_table {
    my $max = shift;
    # Print header
    printf "%2s |", "x";
    printf "%4d", $_ for 1..$max;
    say "\n---|", "-" x (4 * $max);
    # Print table lines
    for my $i (1..$max) {
        printf "%2d |%s", $i, ' ' x (4 * ($i - 1));
        for my $j ($i..$max) {
            printf "%4d", $i * $j;
        }
        say "";
    }
}
print_table shift//11;
