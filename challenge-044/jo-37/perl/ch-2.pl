#!/usr/bin/perl

use v5.26;
use warnings;
use experimental 'signatures';

use List::Gather;


usage() unless @ARGV == 1;

sub usage {
    die <<~EOS;
    $0 - make it N

    usage: $0 N

    N
        a positive integer

    EOS
}


### Input and Output

say "@{[make_it_long($ARGV[0])]}";
say make_it_short($ARGV[0]);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/10/30/ch-044.html#task-2

sub make_it_long ($n) {
    reverse gather {
        while ($n) {
            take $n;
            $n = $n % 2 ? $n - 1 : $n / 2;
        }
    };
}

sub make_it_short ($n) {
    int(log($n) / log(2)) - 1 + unpack "%32b*", pack "I", $n;
}
