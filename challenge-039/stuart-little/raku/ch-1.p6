#!/usr/bin/env perl6
use v6;

# run as <script> <path-to-file containing guest book> or just <script> to default to the guest book below

sub extract_intervals(@record) {
    @record.map({ $_ ~~ m:g/(\d ** 2 \: \d ** 2)/; $0.Str, $1.Str }).map({ $_.map( -> $time { ($time.split(':').map(*.Int) Z* (60,1)).sum }) }).map({ $_[0]..^$_[1] })
}

sub interval_union(@intervals) {
    @intervals.reduce(&infix:<(+)>).Set
}

my @record=((@*ARGS) ?? (@*ARGS[0].IO) !! ($=finish)).lines;
say @record.&extract_intervals.&interval_union.elems

=finish
1) Alex    IN: 09:10 OUT: 09:45
2) Arnold  IN: 09:15 OUT: 09:33
3) Bob     IN: 09:22 OUT: 09:55
4) Charlie IN: 09:25 OUT: 10:05
5) Steve   IN: 09:33 OUT: 10:01
6) Roger   IN: 09:44 OUT: 10:12
7) David   IN: 09:57 OUT: 10:23
8) Neil    IN: 10:01 OUT: 10:19
9) Chris   IN: 10:10 OUT: 11:00
