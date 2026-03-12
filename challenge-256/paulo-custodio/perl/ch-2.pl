#!/usr/bin/env perl

use Modern::Perl;
use List::Util 'zip';

my($a, $b) = @ARGV;
my @a = split //, $a;
my @b = split //, $b;
my @merge = map {($_->[0]//'').($_->[1]//'')} zip \@a, \@b;
say join '', @merge;
