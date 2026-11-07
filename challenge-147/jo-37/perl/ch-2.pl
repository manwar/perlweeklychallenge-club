#!/usr/bin/perl

use v5.26;
use warnings;
use experimental 'signatures';


### Options and Arguments

usage() if @ARGV;

sub usage {
    die <<~EOS;
    $0 - smallest pentagon pair

    usage: $0 

    EOS
}


### Input and Output

say "@{[pentagon_pair()]}";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/11/08/ch-147.html#task-2


sub pentagon_pair {
    state sub pentagon ($k) {
        $k * (3 * $k - 1) / 2;
    }

    state sub is_pentagon ($n) {
        my $m = (sqrt(24 * $n + 1) + 1) / 6;
        $m == int $m;
    }

    my @seen;
    my $i;
    while () {
        my $pi = pentagon(++$i);
        is_pentagon($pi - $_) && is_pentagon($pi + $_) && return ($pi, $_)
            for @seen;
        push @seen, $pi;
    }
}
