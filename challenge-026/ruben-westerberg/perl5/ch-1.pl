#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(uniqstr);

my ($stones, $jewels)= @ARGV?@ARGV: qw(chancellor chocolate);
print "Alphabet (stone) word: $stones\nTest (jewel) word: $jewels\n";
$_=$jewels;
my @stones= uniqstr(split "", $stones);
s/[@stones]//g;
print "Number of letters of Alphabet found in Test: ", length($jewels) - length, "\n";
