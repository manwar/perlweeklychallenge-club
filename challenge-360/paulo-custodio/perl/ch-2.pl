#!/usr/bin/env perl

# Perl Weekly Challenge 360 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-360/

use Modern::Perl;

@ARGV or die "usage: $0 words...\n";
say join " ", sort {lc($a) cmp lc($b)} @ARGV;
