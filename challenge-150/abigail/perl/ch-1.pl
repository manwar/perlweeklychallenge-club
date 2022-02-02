#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-150
#

#
# Run as: perl ch-1.pl < input-file
#

#
# Not sure what the restriction that both numbers are of the same
# length is going to buy us anything. We don't buy anything from
# the fact the input consists of digits only either.
#

my $LENGTH = 51;

while (<>) {
    my ($fib_prev, $fib_last) = /[0-9]+/g;
    while (length ($fib_last) < $LENGTH) {
        ($fib_prev, $fib_last) = ($fib_last, $fib_prev . $fib_last);
    }
    say substr $fib_last, $LENGTH - 1, 1;
}
