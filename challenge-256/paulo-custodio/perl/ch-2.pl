#!/usr/bin/env perl

# Perl Weekly Challenge 256 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-256/

use Modern::Perl;
use List::Util 'zip';

my($a, $b) = @ARGV;
my @a = split //, $a;
my @b = split //, $b;
my @merge = map {($_->[0]//'').($_->[1]//'')} zip \@a, \@b;
say join '', @merge;
