#!/usr/bin/perl
use 5.038;
use warnings;

my $str = shift;
my $count = 0;

for my $i (2 .. length($str) - 1) {
    my ($a, $b, $c) = split //, substr($str, $i - 2, 3);

    if ($a ne $b && $a ne $c && $b ne $c) {
        $count++;
    }
}

say $count;
