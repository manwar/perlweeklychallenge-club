#!/usr/bin/perl

# Perl Weekly Challenge - 067
#
# Task 2 - Letter Phone
#
# Author: Niels 'PerlBoy' van Dijke
#
# Comments: Fun with 'glob()' #2 (Not scalable though ;-) )

use strict;
use warnings;

my %keypad = (
  1 => ['_', ',', '@'],
  2 => [qw(a b c)],
  3 => [qw(d e f)],
  4 => [qw(g h i)],
  5 => [qw(j k l)],
  6 => [qw(m n o)],
  7 => [qw(p q r s)],
  8 => [qw(t u v)],
  9 => [qw(w x y z)],
);

my $s;

$s = $ARGV[0] // 35;

die "digits '1' .. '9' only please" 
  unless $s =~ m#^[1-9]+$#;

my @list = glob('{'.join('}{', map {join(',', @{$keypad{$_}}) } split(//, $s)).'}');

printf qq{Input: s = '%d'\n}, $s;
printf qq{Output: ["%s"]\n"}, join('", "', @list);
