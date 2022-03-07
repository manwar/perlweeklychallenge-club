#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-155
#

#
# Run as: perl ch-2.pl
#

#
# So, we just want *ONE*, fixed, number from an OEIS sequence
# (Sequence A001175). 
#

#
# From the OEIS page of this sequence:
#
#   Index the Fibonacci numbers so that 3 is the fourth number. If
#   the modulo base is a Fibonacci number (>=3) with an even index, the
#   period is twice the index. If the base is a Fibonacci number (>=5)
#   with an odd index, the period is 4 times the index. - Kerry Mitchell,
#   Dec 11 2005
#
# We have a modulo base of 3. 3 is a Fibonnacci number, is >= 3, and
# is on index 4. 4 is even. Hence, the third Pisano period is 8.
#
# Which leaves us exactly nothing to compute. (Unless one needs a
# calculator to double 4).
#
# I guess the good thing is, we don't have to calculate Fibonacci 
# numbers, like we've done a gazillion times recently.
#

say 8
