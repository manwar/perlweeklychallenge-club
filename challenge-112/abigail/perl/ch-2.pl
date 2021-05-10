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
# Run as: perl ch-2.pl < input-file
#

#
# This is just the Fibonacci numbers...
#
sub f ($n) {state $c = {0 => 1, 1 => 1}; $$c {$n} //= f ($n - 1) + f ($n - 2)}
say f ($_) for <>;
