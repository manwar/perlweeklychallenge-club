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
# Run as: perl ch-1a.pl
#

#
# The smart way of solving this problem is found in the file ch-1.pl.
# 
# Below, we're going to do the actual calculations.
#

my $AMOUNT_OF_NUMBERS_TO_PRODUCE = 50;

sub fusc;
sub fusc ($n) {
    state $cache = {0 => 0, 1 => 1};
    $$cache {$n} //= do {$n % 2 ? fusc (($n - 1) / 2) + fusc (($n + 1) / 2)
                                : fusc  ($n      / 2)}
}

say join " " => map {fusc $_} 0 .. $AMOUNT_OF_NUMBERS_TO_PRODUCE - 1;


__END__
