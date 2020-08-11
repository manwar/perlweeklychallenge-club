#!/usr/bin/perl
use strict;
use warnings;
use feature "say";

sub sum_divisors {
    my $num = shift;
    my $limit = int $num / 2 ;
    my $sum = 1;
    for my $test_div (2..$limit) {
        $sum += $test_div if $num % $test_div == 0;
    }
    return $sum;
}

my $i = 2;
while (1) {
    my $sum_div = sum_divisors $i;
    if ($sum_div > $i and $i == sum_divisors $sum_div) {
        say "$i and $sum_div are amicable numbers";
        last;
    }
    $i++
}
