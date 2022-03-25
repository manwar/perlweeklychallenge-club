#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtabs
use v6.d;
use Math::Root;

=begin comment
TASK #1 › Pythagorean Means
Arithmetic Mean, Geometric Mean and Harmonic Mean
Disputing 1st GM value.
=end comment

constant $scale = 1;

my @input = (1,3,5,6,9), (2,4,6,8,10), (1,2,3,4,5);
my @exp   = "AM = 4.8, GM = 3.8, HM = 2.8",   # NOTE: 3.8 not 3.9
            "AM = 6.0, GM = 5.2, HM = 4.4",
            "AM = 3.0, GM = 2.6, HM = 2.2";

for @input -> @n {
    my $n = @n.elems;
    say 'Input: @n = ', @n.raku;
    printf "AM = %.{$scale}f, GM = %.{$scale}f, HM = %.{$scale}f\n\n",
            ([+] @n) / $n,
            root( abs( [×] @n).Rat, $n),
            $n ÷ ([+] map { 1 ÷ $_ }, @n);
}

