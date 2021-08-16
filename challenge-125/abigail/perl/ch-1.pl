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

sub introot ($square) {
    #
    # Return the largest integer less than, or equal to the
    # square root of $square.
    #
    int (.4 + sqrt ($square));
}



while (my $n = <>) {
    chomp ($n);
    say (-1), next if $n <= 2;
    #
    # First case, $n is not the hypothenuse; wlog, assume n = a.
    #
    #   Then, we start searching from c = n + 1 until 
    #   c^2 - (c - 1)^2 > n^2. Note that c^2 - (c - 1)^2 = 2c - 1
    #   In each iteration, we calculate b^2 = c^2 - n^2. If b^2 is
    #   a proper square, we have a Pythagorian triple.
    #
    my $n_sq = $n * $n;

    my $c    = $n + 1;
    my $c_sq = $n_sq + 2 * $n + 1;
    while (2 * $c - 1 <= $n_sq) {
        #
        # We now have a^2 (n_sq) and c^2. We can calculate b^2 (b_sq)
        # and check whether this is a proper square.
        #
        my $b_sq = $c_sq - $n_sq;
        my $b    = introot ($b_sq);

        say "$n $b $c" if $b_sq == $b * $b;
        $c_sq += 2 * $c ++ + 1;  # (c + 1)^2 == c^2 + 2 * c + 1
    }

    #
    # Handle the case $n is the hypothenuse, so $n == c.
    #
    # We now need to search for a, b such that a^2 + b^2 = c^2 ($n_sq).
    # Wlog, assume a < b (a == b cannot happen). Then a < c / sqrt (2).
    #
    my $max_a = int ($n / sqrt (2));
    for (my $a = 3; $a <= $max_a; $a ++) {
        my $b_sq = $n_sq - $a * $a;
        my $b    = introot ($b_sq);
        say "$a $b $n" if $b_sq == $b * $b;
    }
}
