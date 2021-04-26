#!/usr/bin/perl

# Perl Weekly Challenge - 110
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-110/#TASK2
#
# Task 2 - Transpose File
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use File::Basename qw(dirname);
use File::Slurp;

use Test::More;
use Test::Deep;

# Prototype(s)
sub transposeFile($);

# Work relative from script directory
chdir(dirname($0));

cmp_deeply ([transposeFile('input2.txt')],
            ['name,Mohammad,Joe,Julie,Cristina',
             'age,45,20,35,10',
             'sex,m,m,f,f']);

done_testing;


sub transposeFile($) {
  my ($f) = @_;

  # Read and trim
  my @lines = map { s/^\s*(.*?)\s*$/$1/; $_ } read_file($f);

  my @out;
  map {
    my $i = 0;
    map { push(@{$out[$i++]},$_) } split(/,/, $_);
  } @lines;

  return map {join(',',@$_)} @out;
}

