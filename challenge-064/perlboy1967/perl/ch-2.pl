#!/usr/bin/perl

# Perl Weekly Challenge - 064
#
# Task 1 - Word Break
#
# Author: Niels 'PerlBoy' van Dijke


use strict;
use List::MoreUtils qw(uniq);

my ($s, @w) = @ARGV;

my $re = '('.join('|', @w).')';

my @found = uniq(grep(/$re/, split(/$re/, $s)));

if (@found) {
  printf qq{"%s"\n}, join('", "', @found) ;
} else {
  print "0\n";
}
