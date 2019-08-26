#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

sub is_prime{
    my $num = shift;
    for my $i (2 .. $num ** .5) {
        return 0 if $num % $i == 0;
    }
    return 1;
}

my ($candidate, $count) = (2, 0);
while (1) {
    if (is_prime $candidate and is_prime $candidate + 6) {
        say "$candidate ", $candidate + 6;
        $count ++
    }
    last if $count >= 10;
    $candidate ++;
}
