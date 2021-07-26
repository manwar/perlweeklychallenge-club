#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-1.pl < input-file
#

use List::Util qw [min];
my @ugly   = (1);
my @primes = (2, 3, 5);
my %next   = map {$_ => 0} @primes;

#
# We will maintain the following invariants:
#
# Foreach $p in @primes:
#      $p * $ugly [$next {$p} - 1] <= $ugly [-1] < $p * $ugly [$next {$p}]
#
# And since every ugly number (except the first) is either twice an
# ugly number, three times an ugly number, or five times an ugly
# number, the next ugly number will be the minimum of 
# (2 * $ugly [$next {2}], 3 * $ugly [$next {3}], 5 * $ugly [$next {5}]).
#
# We will spend O(1) time per generated ugly number, so our
# program will run in O(N) time, using O(N) memory.
#

while (my $n = <>) {
    while (@ugly < $n) {
        #
        # Calculate the next ugly number.
        #
        push @ugly => min map {$_ * $ugly [$next {$_}]} @primes;

        #
        # Update pointers. It could be that more than one pointer needs
        # updating. (This happens if the ugly number generated is
        # divisible by 6, 10, 15, or 30). No pointer ever needs updating twice.
        #
        $_ * $ugly [$next {$_}] <= $ugly [-1] and $next {$_} ++ for @primes;
    }
    say $ugly [-1];
}


__END__
