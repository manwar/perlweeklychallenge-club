#!/usr/bin/perl
# Perl Weekly Challenge #070 Task 1 Character Swapping
# Usage: ch-1.pl [string] [swap count] [offset]

use strict;
use warnings;

my $s = 'perlandraku';
my $C = 3;
my $O = 4;

if ($ARGV[0] and $ARGV[1] and $ARGV[2]) {
    $s = $ARGV[0];
    $C = $ARGV[1];
    $O = $ARGV[2];
}


for my $counter (1..$C) {
    my $t = substr $s, $counter, 1;
    my $z = substr($s, $counter+$O, 1, $t);
    substr $s, $counter, 1, $z;
    print $counter, " ", $s, "\n";
}
