#!/usr/bin/perl

# Perl Weekly Challenge - 110
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-110/#TASK2
#
# Task 2 - Transpose File
#
# Author: Niels 'PerlBoy' van Dijke
# 
# *** Extra submission ***
# Inspired by other solutions usage of '[split/,/]'
# to find minimalistic 'sub transposeFile($)'
#

use v5.16;
use strict;
use warnings;

use File::Basename qw(dirname);
use File::Slurp;
use Array::Transpose;

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
  map{join(',',@$_)}transpose[map{s/^\s*(.*?)\s*$/$1/;[split/,/]}read_file($_[0])];
}

