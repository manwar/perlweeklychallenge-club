#!/usr/bin/perl
# The Weekly Challenge #102
# Task 2 Hash-counting String
# Usage: ch-2.pl [positive integer]
use strict;
use warnings;
use Test::Simple tests => 5;

sub hcs {
    my $N = $_[0];
    return "#" if $N == 1;
    return "2#" if $N == 2;
    my $p = length $N;
    return (hcs($N-$p-1) . "$N" . "#");
}

print hcs($ARGV[0]), "\n" 
    if defined($ARGV[0]) && $ARGV[0] > 0 && $ARGV[0]=~/^\d+$/;

ok hcs(1) eq "#", "Example a" ;
ok hcs(2) eq "2#", "Example b";
ok hcs(3) eq "#3#", "Example c";
ok hcs(10) eq "#3#5#7#10#", "Example d";
ok hcs(14) eq "2#4#6#8#11#14#", "Example e";
