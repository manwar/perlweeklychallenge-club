#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# Run as: perl ch-2.pl < input-file
#

#
# We've done factorization in previous challenges, so now I'll just
# use a module to give me the prime factors of a number.
#
use Math::Prime::Util qw [factor];
use List::Util        qw [sum];

my $COUNT = 10;

#
# Nothing smart going on. Just counting upwards from 1, check if it's
# a Smith Number, and outputting it if it's a Smith Number.
# Stop when we have 10 of them.
#

#
# Return the sum of the digits of the set of given numbers.
#
sub digitsum (@n) {sum "@n" =~ /\d/ag}

my $c = 0;
my $n = 0;
do {
    my @factors = factor ++ $n;
    $c ++, say $n if @factors > 1 && digitsum ($n) == digitsum @factors;
} until $c == $COUNT;
