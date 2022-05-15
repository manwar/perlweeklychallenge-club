#!/usr/bin/env perl
#
# ch-1.pl - Prime palindrome
#
# Even though there are 1.6x more primes than palindromes <= 1000,
# we're already sieving the list, so we may as well use that as our
# main loop. This is 5x faster than going the other way around.
#
# Same applies if we use Math::Prime::Util instead.
#
# 2022 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;

no warnings 'uninitialized';

say for grep { $_ eq scalar reverse $_ } primes_under( pop // 1000 );

sub primes_under {
    my $limit = shift;
    my @comp; # Composite numbers (non-primes)

    for my $n (2..$limit) {
        next if $comp[$n];
        $comp[$_] = 1 for map { $n * $_ } 2..$limit/$n;
    }

    2, grep { !$comp[$_] } 3..$limit;
}
