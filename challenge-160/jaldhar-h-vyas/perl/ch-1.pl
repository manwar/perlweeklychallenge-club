#!/usr/bin/perl
use 5.030;
use warnings;

my $n = shift // die "Need an integer from 1-9\n";
if ($n < 1 || $n > 9) {
    die "Need an integer from 1-9\n";
}

my %words = (
    1  => 'one',
    2  => 'two',
    3  => 'three',
    4  => 'four',
    5  => 'five',
    6  => 'six',
    7  => 'seven',
    8  => 'eight',
    9  => 'nine',
);

my $first = $words{$n};
while(1) {
    if ($first eq 'four') {
        say "four is magic.";
        last;
    } else {
        my $second = $words{length $first};
        print "$first is $second, ";
        $first = $second;
    }
}
