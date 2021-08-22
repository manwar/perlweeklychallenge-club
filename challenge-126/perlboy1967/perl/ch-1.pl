#!/usr/bin/perl

# Perl Weekly Challenge - 126
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-126/#TASK1
#
# Task 1 - Count Numbers
#
# Author: Niels 'PerlBoy' van Dijke

use 5.16.0;

say scalar grep !/1/,1..shift;
