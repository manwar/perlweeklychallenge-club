#!/usr/bin/env perl
use v5.40;

sub final_price($ar) {
    my @output;

    for my $i (0..$#$ar) {
        my $discount = 0;
        for my $j ($i+1..$#$ar) {
            if ($ar->[$j] <= $ar->[$i]) {
                $discount = $ar->[$j];
                last;
            }
        }
        push @output, $ar->[$i] - $discount;
    }
    return @output;
}                

my @prices = (
              [8, 4, 6, 2, 3],
              [1, 2, 3, 4, 5],
              [7, 1, 1, 5],
             );

for my $prices (@prices) {
    printf "(%s)\n", join(", ", final_price($prices));
}
