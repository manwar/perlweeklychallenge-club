#!/usr/bin/env perl
#
# Write a script to print the smallest pair of Amicable Numbers. For more
# information, please checkout wikipedia page.
#
# (https://en.wikipedia.org/wiki/Amicable_numbers).
################################################################################

use strict;
use warnings;

sub sum_divisors {
    my $n = shift;
    my $sum = 0;
    foreach my $i (1 .. $n/2) {
        $sum += $i if $n % $i == 0;
    }
    return $sum;
}

my $n1 = 2;
my $n2;
my @already_checked;

while (!$n2) {
    my $sum = sum_divisors($n1);
    if (!grep(/^$sum$/, @already_checked) && $sum != $n1 && sum_divisors($sum) == $n1) {
        $n2 = $sum;
    }
    push @already_checked, $sum, $n1++;
}
$n1--;

print "($n1, $n2)\n";
