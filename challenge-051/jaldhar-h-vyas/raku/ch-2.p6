#!/usr/bin/perl6

sub isColorful($n) {
    my %subsets;
    my @digits = $n.comb;
    my @products = @digits;

    @products.push(@digits[0] * @digits[1]);
    @products.push(@digits[1] * @digits[2]);
    @products.push(@digits[0] * @digits[1] * @digits[2]);
    @products.map({ %subsets{$_}++ });

    return %subsets.values.all == 1;
}

for (100 .. 999).grep({ isColorful($_) }) -> $n {
    say $n;
}
