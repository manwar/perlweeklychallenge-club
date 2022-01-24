#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-149
#

#
# Run as: perl ch-1.pl < input-file
#

#
# This is sequence A028840 of the OEIS. The first 10,000 entries can
# be found at https://oeis.org/A028840/b028840.txt
#
# We will make use of the following conjecture: the Nth number is <= 10 * N.
# This holds for the first 10,000 numbers.
#
# Consider that we are asked to generate all the first N numbers (and not
# the Nth number), I doubt we'll be feeding numbers exceeding 10,000 to
# this program.
#
# For the sum of digits, we hark back to challenge 133, part 2.
#

use List::Util qw [sum];
sub digitsum ($n) {sum $n =~ /\d/ag}

while (<>) {
    my $N = 0 + $_;
    #
    # Get an upper bound on the sum of the digits.
    #
    my $max_fib = 9 * (1 + length $N);
    #
    # Generate all the Fibonacci numbers up to $max_fib.
    #
    my %fib = (0 => 1, 1 => 1);
    my ($f, $g) = (0, 1);
    while ($g < $max_fib) {
        ($f, $g) = ($g, $f + $g);
        $fib {$g} = 1;
    }

    for (my ($c, $k) = (0, 0); $c < $N; $k ++) {
        if ($fib {digitsum $k}) {
            print "$k ";
            $c ++;
        }
    }
    print "\n";
}
