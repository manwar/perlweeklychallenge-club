#!/usr/bin/env perl

# Perl Weekly Challenge 331 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-331/

use Modern::Perl;

my @words = split ' ', <>;
say @words==0 ? 0 : length($words[-1]);
