#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

my @a1 = qw /I L O V E Y O U/;
my @a2 = qw /2 4 0 3 2 0 1 9/;
my @a3 = qw /! ? £ $ % ^ & */;

say "$a1[$_] $a2[$_] $a3[$_]" for 0..$#a1;
