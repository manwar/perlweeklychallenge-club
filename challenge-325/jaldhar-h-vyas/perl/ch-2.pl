#!/usr/bin/perl
use 5.030;
use warnings;


my @prices = @ARGV;
my @result;

for my $i (0 .. scalar @prices - 1) {
    my $discount = 0;
    for my $j ($i + 1 .. scalar @prices - 1) {
        if ($prices[$j] <= $prices[$i]) {
            $discount = $prices[$j];
            last;
        }
    }
    push @result, $prices[$i] - $discount;
}

say q{(}, (join q{, }, @result), q{)};
