#!/usr/bin/perl

use v5.26;
use warnings;
use experimental 'signatures';

use Math::Prime::Util 'forsetproduct';
use List::Gather;


### Options and Arguments

usage() unless @ARGV == 2;

sub usage {
    die <<~EOS;
    $0 - stepping numbers

    usage: $0 FROM TO

    FROM
        lower limit (>= 100)

    TO
        upper limit (<=999)

    EOS
}


### Input and Output

say "@{[stepping_numbers(@ARGV)]}";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/10/30/ch-052.html#task-1

sub stepping_numbers ($low, $high) {
    state $f = [1..9];
    state $step = [-12, -10, 10, 12];
    gather {
        forsetproduct {
            my $b = 111 * $_[0];
            my $n =  $b + $_[1];
            return if $n >= ($_[0] + 1) * 100;
            return if $n < $_[0] * 100;
            take $n if $low <= $n && $n <= $high;
        } $f, $step;
    };
}

