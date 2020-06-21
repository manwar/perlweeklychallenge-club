#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';

my $digits = 3;
my $sum    = 4;

for my $x (glob "{1,2,3,4,5,6,7,8,9,0}" x $digits) {
    my $s = eval $x=~s/\B/\+/gr;
    (length (int $x) == $digits) && ($s == $sum) && say $x
}