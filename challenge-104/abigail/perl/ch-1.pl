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
# Run as: perl ch-1.pl
#

#
# This challenge is beyond simple. We're asked to output a fixed list
# of 50 numbers. We're not getting any input, so each run of the program
# is going to produce the same output.
#
# Now, if we were to be asked to produce the Nth number of the fucs
# sequence, or the first N numbers, we might have written some like
#
# sub f ($n) {
#    state $c = {0 => 0, 1 => 1};
#    $$c {$n} //= $n % 2 ? f (($n - 1) / 2) + f (($n + 1) / 2) : f ($n / 2)}
#
# But since we're not asked to do anything smart, we just fetch the
# first 50 numbers from the link provided and print them.
#
# After all, the first rule of optimization is: don't calculate anything
# you don't have to calculate.
#
# (Well, we did do the above anyway, see ch-1a.pl)
#


say "0 1 1 2 1 3 2 3 1 4 3 5 2 5 3 4 1 5 4 7 3 8 5 7 2 7 " .
    "5 8 3 7 4 5 1 6 5 9 4 11 7 10 3 11 8 13 5 12 7 9 2 9";


