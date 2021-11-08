#!/usr/bin/perl
# The Weekly Challenge 115
# Task 2 Largest Multiple
# Usage: ch-2.pl [digits from 0-9]
use strict;
use warnings;

my @digits = @ARGV;

if (!@digits) {@digits = (1,0,4,8,5,7,6);} 

for (@digits) {
    die "Please input digits seperated by spaces.\n", 
        "Usage: ch-2.pl [digits from 0-9]\n"
        unless $_ =~ /^[0-9]$/;
}


@digits = sort {$b <=> $a} @digits;

my $least_sig_fig = -1;
for (reverse 0..$#digits) {
    if ($digits[$_] =~ /[02468]/ ) {
        $least_sig_fig = splice(@digits, $_, 1);
        push @digits, $least_sig_fig;
        last;
    }
}
if ($least_sig_fig == -1) {
    print "NULL", "\n";
}
else {
    print join "", @digits;
    print "\n";
}

