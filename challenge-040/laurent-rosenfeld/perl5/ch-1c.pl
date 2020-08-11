#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

my @a1 = qw /I L OOO V E Y O U/;
my @a2 = qw /244 42 0 1233 222 0 11 90/;
my @a3 = qw /! ???? £ $ %% ^ & */;

say "$a1[$_]\t$a2[$_]\t$a3[$_]" for 0..$#a1;
