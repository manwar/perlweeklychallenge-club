#!/usr/bin/env perl
#
# ch-1.pl - Light tracker
#
# Ryan Thompson <rjt@cpan.org>
#
# Assumption: All times are in the same 00:00 - 23:59 day

use 5.010;
use warnings;
use strict;

my %on; # Minutes during which the lights were definitely on

for (<DATA>) {
    # I'll demonstrate a full parse, here, but you could also
    # do with a much simpler regex or even split in this case.
    /^\s*
        \d+\)\s+                             # Line number
        (?<who>    \w+)\s+                   # Guest's name
        IN: \s+
        (?<in_hh>  \d\d):(?<in_mm>  \d\d)\s+ # Time in
        OUT:\s+
        (?<out_hh> \d\d):(?<out_mm> \d\d)\s* # Time out
    $/x or die "Invalid input format: $_";

    my $in_min  = $+{in_hh}  * 60 + $+{in_mm};
    my $out_min = $+{out_hh} * 60 + $+{out_mm};

    $on{$_}++ for $in_min .. $out_min;
}

say scalar keys %on;

__DATA__
0) Ryan    IN: 03:25 OUT: 04:20
1) Alex    IN: 09:10 OUT: 09:45
2) Arnold  IN: 09:15 OUT: 09:33
3) Bob     IN: 09:22 OUT: 09:55
4) Charlie IN: 09:25 OUT: 10:05
5) Steve   IN: 09:33 OUT: 10:01
6) Roger   IN: 09:44 OUT: 10:12
7) David   IN: 09:57 OUT: 10:23
8) Neil    IN: 10:01 OUT: 10:19
9) Chris   IN: 10:10 OUT: 11:00
