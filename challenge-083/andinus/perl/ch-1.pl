#!/usr/bin/perl

use strict;
use warnings;

die "usage: ./ch-1.pl <string with 3 or more words>\n"
    unless scalar @ARGV == 1
    and scalar split(/ /, $ARGV[0]) >= 3;

my @words = split / /, $ARGV[0];
shift @words;
pop @words;

my $len;
$len += length($_) foreach @words;

print $len, "\n";
