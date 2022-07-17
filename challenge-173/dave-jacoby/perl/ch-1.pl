#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @numbers = ( 5456, 120, 123 );

for my $n (@numbers) {
    my $str = 'is not an esthetic number ';
    if ( is_esthetic($n) ) { $str = 'is an esthetic number ' }
    say qq{  $n $str};
}

sub is_esthetic($n) {
    my @n = split //, $n;
    for my $i ( 1 .. -1 + scalar @n ) {
        my $j = $i - 1;
        my $e = abs $n[$i] - $n[$j];
        return 0 if $e != 1;
    }
    return 1;
}
