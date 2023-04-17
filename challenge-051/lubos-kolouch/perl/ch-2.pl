#!/usr/bin/perl
use strict;
use warnings;

sub is_colorful {
    my $number = shift;
    my %products;

    my @digits = split //, $number;
    my $len    = scalar @digits;

    for ( my $i = 0 ; $i < $len ; $i++ ) {
        my $product = 1;
        for ( my $j = $i ; $j < $len ; $j++ ) {
            $product *= $digits[$j];
            return 0 if exists $products{$product};
            $products{$product} = 1;
        }
    }

    return 1;
}

for my $num ( 100 .. 999 ) {
    print "$num\n" if is_colorful($num);
}
