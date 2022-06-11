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
# For the sum of digits, we hark back to challenge 133, part 2.
#

use List::Util qw [sum];

#
# Return the sum of the digits of its argument
#
sub digitsum ($number) {
    my $sum  =  0;
    my $base = 10;
    while ($number > 0) {
        use integer;
        $sum    += $number % $base;
        $number /= $base;
    }
    return $sum;
}


#
# Return whether the argument is a Fibonacci number. We do this by
# keeping a hash with Fibonacci numbers, and keeping track of the
# last 2 Fibonacci numbers produced. If the argument is larger than
# the last Fibonacci number produced, we keep generating new 
# Fibonacci numbers, until we have exceeded the argument. 
#
# Then it's a simple lookup.
#
sub is_fib ($n) {
    state  $fib = {0 => 1, 1 => 1};
    state  $fib_prev = 0;
    state  $fib_last = 1;
    while ($fib_last < $n) {
        ($fib_prev, $fib_last) = ($fib_last, $fib_prev + $fib_last);
        $$fib {$fib_last}      = 1;
    }
    $$fib {$n}
}

while (<>) {
    for (my ($k, $N) = (0, 0 + $_); $N > 0; $k ++) {
        $N --, print "$k " if is_fib digitsum $k
    }
    print "\n";
}
