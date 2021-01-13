#!/usr/bin/env perl

use strict;
use warnings;
use List::Util qw/max pairvalues pairfirst/;

sub maximise_product {
        my $lst = shift;
        my @results = ();

        for my $i (0..$#$lst) {
                my $prod = 1;
                for my $j ($i..$#$lst) {
                        $prod *= @$lst[$j];
                        push @results, [$i, $j], $prod;
                }
        }

        my $max_prod = max pairvalues @results;
        my ($sublist) = pairfirst {$b == $max_prod} @results;
        return [@$lst[@$sublist[0] .. @$sublist[1]]];
}

print join(', ', maximise_product([2, 5, -1, 3])->@*), "\n";

## Trying some other examples
# say join(', ', maximise_product([0.5, 2, 3, -2, -1, 0])->@*);
