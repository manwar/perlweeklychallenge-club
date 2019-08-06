#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say);

use List::Util qw{ sum0 };

sub sum_divisors {
    my $n = shift;
    return sum0(grep 0 == $n % $_, 1 .. $n - 1)
}

my ($a1, $a2) = (0, 0);
until ($a1 == sum_divisors($a2) && $a1 < $a2) {
    $a2 = sum_divisors(++$a1);
}
say "$a1 $a2";
