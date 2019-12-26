#!/usr/bin/env perl

use strict;
use warnings;
use List::Util qw<min max>;

my @times=map { my @o;while(/(\d{2}):(\d{2})/g){ push @o,$1*60+$2}; @o} <DATA>;
printf "Lights on for %d minutes\n", max(@times)-min(@times);

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
