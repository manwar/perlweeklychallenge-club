#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);

# Input
my $S = "    Perl and   Raku are  part of the same family  ";

# Reverse Words
$S =~ s/^\s+|\s+$//g;
$S =~ s/\s+/ /g;

my $res = join(" ", reverse(split(" ", $S)));

# Output
say($res);