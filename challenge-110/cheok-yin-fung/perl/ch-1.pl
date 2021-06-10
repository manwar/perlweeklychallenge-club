#!/usr/bin/perl
# The Weekly Challenge 110 
# Task 1 Phone Number
# Usage:  perl ch-1.pl < [file]
use strict;
use warnings;

my $s;
while ($s = <STDIN>) {
    chomp($s);
    if ( length $s == 15 &&
        substr($s, 4, 1) eq " " && 
        substr($s, -11) =~ / \d{10}/ &&
        (substr($s,0,4) =~ /\d{4}/ ||
         substr($s,0,4) =~ /\+\d{2}/ ||
         substr($s,0,4) =~ /\(\d{2}\)/)
    ) {
        print $s, "\n";
    }
}
