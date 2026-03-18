#!/usr/bin/env perl

# Perl Weekly Challenge 267 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-267/

use Modern::Perl;
use List::Util 'product';

my $prod = product(@ARGV);
say $prod>0 ? 1 : $prod==0 ? 0 : -1;
