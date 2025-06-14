#!/usr/bin/env perl
use v5.40;

sub consecutive_one($ar) {
    my $best = 0;
    my $run = 0;

    for my $d ($ar->@*) {
        if ($d == 1) {
            $run++;
            $best = $run if $run > $best;
        } else {
            $run = 0;
        }
    }

    return $best;
}        

my @binary1 = (0, 1, 1, 0, 1, 1, 1);
my @binary2 = (0, 0, 0, 0);
my @binary3 = (1, 0, 1, 0, 1, 1);

for my $ar (\@binary1, \@binary2, \@binary3) {
    say consecutive_one($ar);
}
