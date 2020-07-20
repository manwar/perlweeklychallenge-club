#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

is(swap('perlandraku', 3, 4),
   'pndraerlaku',
   'testing perlandraku.');
is(swap('weeklychallenge', 5, 2),
   'wklycheeallenge',
   'testing weeklychallenge.');

done_testing;

sub swap {
    my ($string, $count, $offset) = @_;

    my $length = length($string);
    my @array  = split //, $string;
    foreach my $i (1..$count) {
        my $a = $i % $length;
        my $b = ($i + $offset) % $length;
        ($array[$a], $array[$b]) = ($array[$b], $array[$a]);
    }

    return join '', @array;
}
