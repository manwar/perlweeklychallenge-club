#!/usr/bin/env perl
#
# Write a script to generate first 10 strong and weak prime numbers.
# (https://en.wikipedia.org/wiki/Strong_prime)
################################################################################

use strict;
use warnings;

use List::Util qw<any max>;

my $LIMIT = 10;

# Already found strong/weak primes
my (@strong, @weak);

# Last known prime; will be pushed to either @strong or @weak once the next
# prime is found and we can compare the closeness
my $last_prime = 2;

while (@strong < $LIMIT || @weak < $LIMIT) {
    # Find next prime
    my $candidate = $last_prime+1;
    $candidate++ while any { $candidate % $_ == 0 } @strong, @weak;

    # Now we know whether $last_prime is strong or not; push it correspondingly
    my $max_prime = max($strong[-1] || 0, $weak[-1] || 0);
    if ($candidate - $last_prime < $last_prime - ($max_prime || $last_prime)) {
        push @strong, $last_prime;
    } else {
        push @weak, $last_prime;
    }

    # Candidate becomes the last known prime
    $last_prime = $candidate;
}

print "Strong: @strong[0..$LIMIT-1]\nWeak: @weak[0..$LIMIT-1]\n";
