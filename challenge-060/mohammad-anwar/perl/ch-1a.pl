#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

is (to_excel(28),    "AB", "28 => AB");
is (from_excel("AB"), 28,  "AB => 28");

done_testing;

sub from_excel {
    my ($name) = @_;

    my $i = 0;
    my $b = 26;
    my $d = 0;
    foreach my $c (split //, scalar(reverse(uc $name))) {
        $d += (ord($c) - ord("A") + 1) * ($b ** $i++);
    }

    return $d;
}

sub to_excel {
    my ($number) = @_;

    my $name = '';
    my @name = (0, 'A' .. 'Z');
    while ($number > 26) {
        my $i = int $number / 26;
        $name   .= $name[$i];
        $number -= ($i * 26);
    }
    $name .= $name[$number];

    return $name;
}
