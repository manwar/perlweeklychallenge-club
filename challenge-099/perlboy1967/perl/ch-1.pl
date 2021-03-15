#!/usr/bin/perl

# Perl Weekly Challenge - 099
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-099/
#
# Task 1 - Pattern Match
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

# Unbuffered STDOUT
$|++;

@ARGV = ('abcde', 'a*c?e')
  unless (scalar(@ARGV) == 2);

my ($S, $P) = @ARGV;

my $RE = $P;
$RE =~ s#([\*\?])#.$1#g;

printf "Input: \$S = '%s', \$P = '%s'\n", $S, $P;
printf "Output: %d\n", ($S =~ m#^($RE)$# ? 1 : 0);
