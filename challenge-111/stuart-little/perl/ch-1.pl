#!/usr/bin/perl
use warnings;
use v5.12;

# run <script>

use feature qw(signatures);
no warnings qw(experimental::signatures);

use List::AllUtils qw(bsearchidx reduce);

sub searchMatrix($needle,$mat) {
    my $flat = reduce {my @a = (@$a, @$b); \@a} @$mat;
    return ((bsearchidx {$_ - $needle} @$flat) >= 0) ? (1) : (0);
}

my $ar = [
    [  1,  2,  3,  5,  7 ],
    [  9, 11, 15, 19, 20 ],
    [ 23, 24, 25, 29, 31 ],
    [ 32, 33, 39, 40, 42 ],
    [ 45, 47, 48, 49, 50 ],
    ];
say "Array:";
for (@$ar) {
    say "@$_";
}
say "";
my @toSearch=(1,35,39,100);
for (@toSearch) {
    say "Found $_?";
    say searchMatrix($_,$ar);
}
