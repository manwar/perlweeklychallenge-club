#!/usr/bin/perl
use strict;
use warnings;

sub count_different_bits {
    my ( $a, $b ) = @_;
    my $count = 0;
    while ( $a > 0 or $b > 0 ) {
        $count += ( $a % 2 ) ^ ( $b % 2 );
        $a >>= 1;
        $b >>= 1;
    }
    return $count;
}

sub sum_different_bits {
    my @numbers = @_;
    my $sum     = 0;
    for my $i ( 0 .. $#numbers ) {
        for my $j ( $i + 1 .. $#numbers ) {
            $sum += count_different_bits( $numbers[$i], $numbers[$j] );
        }
    }
    return $sum;
}

my @input = ( 2, 3, 4 );
print sum_different_bits(@input), "\n";
