#!/usr/bin/perl -s

use v5.16;
use warnings;
use experimental 'signatures';

our $help;

die <<EOS if $help;
usage: $0 [-help] [N]

-help
    print this help text

N
    find the survivor out of N

EOS


### Input and Output

say survivor(shift // 50);


### Implementation
#
# Instead of a circle, we consider a row where the first is moved to the
# end in each step.

sub survivor ($n) {
	my @row = (1 .. $n);
    push @row, (splice @row, 0, 2)[0] while @row > 1;

    $row[0];
}
