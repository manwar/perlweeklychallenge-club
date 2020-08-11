#!/usr/bin/env perl

# challenge-033/ch-1.pl - Count a..z characters in given files
#
# Ryan Thompson <rjt@cpan.org>

use strict;
die "usage: $0 file ..." unless @ARGV;     # Remove to allow input from stdin

my %ch;
map { $ch{ lc() }++ } split '' while <<>>; # unpack is ~15% slower on my CPU
print "$_: $ch{$_}\n" for 'a'..'z';
