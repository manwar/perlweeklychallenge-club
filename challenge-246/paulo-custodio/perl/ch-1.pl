#!/usr/bin/env perl

# Challenge 246
#
# Task 1: 6 out of 49
# Submitted by: Andreas Voegele
#
# 6 out of 49 is a German lottery.
#
# Write a script that outputs six unique random integers from the range 1 to 49.
# Output
#
# 3
# 10
# 11
# 22
# 38
# 49

use Modern::Perl;

use constant NR_BALLS => 49;
use constant NR_DRAWS => 6;

if (@ARGV) {
    srand($ARGV[0]+0);
}

my @balls = (1..NR_BALLS);
my @drawn;
for (1..NR_DRAWS) {
    my $i = int(rand()*scalar(@balls));
    push @drawn, splice(@balls, $i, 1);
}

say join("\n", sort {$a<=>$b} @drawn);
