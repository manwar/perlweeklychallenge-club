#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use Set::IntSpan qw{ grep_set };

sub minutes {
    my ($time) = @_;
    my ($hours, $minutes) = split /:/, $time;
    return $hours * 60 + $minutes
}

my $span = 'Set::IntSpan'->new;
while (<DATA>) {
    my ($in, $out) = (split)[3, 5];
    $_ = minutes($_) for $in, $out;
    $span += 'Set::IntSpan'->new([[$in, $out]]);
}

say $span->cardinality;

__DATA__
1) Alex    IN: 09:10 OUT: 09:45
2) Arnold  IN: 09:15 OUT: 09:33
3) Bob     IN: 09:22 OUT: 09:55
4) Charlie IN: 09:25 OUT: 10:05
5) Steve   IN: 09:33 OUT: 10:01
6) Roger   IN: 09:44 OUT: 10:12
7) David   IN: 09:57 OUT: 10:23
8) Neil    IN: 10:01 OUT: 10:19
9) Chris   IN: 10:10 OUT: 11:00
