#!/usr/bin/perl
use strict;
use warnings;
use feature "say";

sub divisors {
    my $num = shift;
    my $limit = 1 + int $num / 2;
    my @divisors = (1);
    for my $test_div (2..$limit) {
        push @divisors, $test_div if $num % $test_div == 0;
    }
    return @divisors;
}

for my $num (2..10000) {
    my $sum_div = 0;
    my @divisors = divisors $num;
    for my $div (@divisors) {
        $sum_div += $div;
    }
    say " $num : @divisors" if $sum_div == $num ;
}
