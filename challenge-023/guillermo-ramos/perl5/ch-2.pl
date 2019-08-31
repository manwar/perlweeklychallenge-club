#!/usr/bin/env perl
#
# Create a script that prints Prime Decomposition of a given number. The prime
# decomposition of a number is defined as a list of prime numbers which when all
# multiplied together, are equal to that number. For example, the Prime
# decomposition of 228 is 2,2,3,19 as 228 = 2 * 2 * 3 * 19.
################################################################################

use strict;
use warnings;

use List::Util qw<any>;

my $n = my $number = shift or die "Usage: $0 <number>";

my @primes = (2);
my @factors;
while ($n != 1) {
    my $lastp = $primes[-1];
    if ($n % $lastp == 0) {
        push @factors, $lastp;
        $n /= $lastp;
    } else {
        $lastp++ while any { $lastp % $_ == 0 } @primes;
        push @primes, $lastp;
    }
}

print "$number = ", join("*", @factors), "\n";

# Quick test
$n *= $_ foreach (@factors);
$n == $number or die "Oops, something went wrong!";
