#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.30);
use experimental qw(signatures);
use List::Util qw(product);

# Colourful Number
# Write a script to display all Colorful Number with 3 digits.
#
# A number can be declare Colorful Number where all the products of
# consecutive subsets of digit are different.
#
# For example, 263 is a Colorful Number since 2, 6, 3, 2x6, 6x3, 2x6x3 are unique.

sub is_colorful($n) {
    my %prods;
    for my $len (1..length($n)) {
        for my $i (0..length($n) - $len) {
            my $p = product split //, substr($n, $i, $len);
            if (defined $prods{$p}) {
                return 0;
            } else {
                $prods{$p} = 1;
            }
        }
    }
    return 1;
}

for my $n (100..999) {
    say $n if is_colorful($n);
}
